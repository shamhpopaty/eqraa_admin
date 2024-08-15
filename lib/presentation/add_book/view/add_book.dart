import 'dart:convert';
import 'dart:io';

import 'package:eqraa/core/services/services.dart';
import 'package:eqraa/linkapi.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform; // Import for platform checks
import 'package:flutter/foundation.dart' show Uint8List, kIsWeb;
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';

import '../../../core/app_export.dart';

class AddBookPage extends StatefulWidget {
  const AddBookPage({super.key});

  @override
  _AddBookPageState createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {
  MyServices myServices = Get.find();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController? _bookName = TextEditingController();
  final TextEditingController? _authorName = TextEditingController();
  final TextEditingController? _description = TextEditingController();
  TextEditingController? numberOfPages = TextEditingController();
  String? _pdfPath;
  String? _imagePath;
  String? _selectedCategory;
  String? _fileName;
  Uint8List? _pdfBytes;
  Uint8List? _imageBytes;

  final List<String> categories = [
    'Religious',
    'History',
    'Horror',
    'Drama',
    'Scientific',
    'Cooking',
    'Personal Development',
    'Philosophy',
  ];

  Future<void> _pickFile() async {
    if (kIsWeb || await _requestPermission()) {
      try {
        final result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['pdf'],
        );

        if (result != null && result.files.isNotEmpty) {
          if (kIsWeb) {
            // On web, `path` is null, use `bytes` instead
            setState(() {
              _pdfBytes = result.files.single.bytes; // Save the file bytes
              _fileName =
                  result.files.single.name; // Save the file name for display
            });
            print('File selected successfully (Web)');
          } else {
            // For mobile, use the file path
            setState(() {
              _pdfPath = result.files.single.path; // Save the file path
              _fileName =
                  result.files.single.name; // Save the file name for display
            });
            print('File selected successfully (Mobile)');
          }
        }
      } catch (e) {
        print('Error picking file: $e');
      }
    } else {
      print('Storage permission denied');
    }
  }

  Future<bool> _requestPermission() async {
    if (kIsWeb) {
      // No need to request permissions on web
      return true;
    } else if (Platform.isAndroid || Platform.isIOS) {
      if (await Permission.storage.isGranted) {
        return true;
      }
      if (await Permission.storage.request().isGranted) {
        return true;
      }
      // Handle Android 11+ MANAGE_EXTERNAL_STORAGE permission
      if (Platform.isAndroid &&
          await Permission.manageExternalStorage.isGranted) {
        return true;
      } else if (Platform.isAndroid &&
          await Permission.manageExternalStorage.request().isGranted) {
        return true;
      }
    }
    return false;
  }

  Future<void> _pickImage() async {
    if (kIsWeb || await _requestPermission()) {
      try {
        FilePickerResult? result =
            await FilePicker.platform.pickFiles(type: FileType.image);
        if (result != null && result.files.isNotEmpty) {
          if (kIsWeb) {
            // On web, `path` is null, use `bytes` instead
            setState(() {
              _imageBytes = result.files.single.bytes; // Save the image bytes
            });
            print('Image selected successfully (Web)');
          } else {
            // For mobile, use the file path
            setState(() {
              _imagePath = result.files.single.path; // Save the file path
            });
            print('Image selected successfully (Mobile)');
          }
        }
      } catch (e) {
        print('Error picking image: $e');
      }
    } else {
      print('Storage permission denied');
    }
  }

  void _addBook() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final uri = Uri.parse(AppLink.addBook);
      final request = http.MultipartRequest('POST', uri);

      // Adding form fields
      request.fields['title'] = _bookName!.text;
      request.fields['description'] = _description!.text;
      request.fields['category'] = _selectedCategory!;
      request.fields['author'] = _authorName!.text;
      request.fields['number_of_pages'] = numberOfPages!.text.toString();

      // Adding the book PDF file
      if (_pdfPath != null) {
        request.files.add(await http.MultipartFile.fromPath('book', _pdfPath!,
            filename: _fileName));
      } else if (_pdfBytes != null) {
        request.files.add(http.MultipartFile.fromBytes('book', _pdfBytes!,
            filename: _fileName));
      }

      // Adding the cover image file
      if (_imagePath != null) {
        request.files.add(await http.MultipartFile.fromPath(
            'cover', _imagePath!,
            filename: _imagePath!.split('/').last));
      } else if (_imageBytes != null) {
        request.files.add(http.MultipartFile.fromBytes('cover', _imageBytes!,
            filename: _fileName ?? 'cover_image'));
      }

      // Adding the token to the headers
      request.headers['Authorization'] =
          'Bearer ${myServices.getToken()}'; // Replace with your actual token

      // Sending the request
      try {
        final streamedResponse = await request.send();
        final response = await http.Response.fromStream(streamedResponse);

        if (response.statusCode == 200 || response.statusCode == 201) {
          print('Success response: ${response.body}');
          Get.snackbar(
            'Success',
            'Book added successfully',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
        } else {
          print('Error response: ${response.body}');
          print('Failed to add book. Status code: ${response.statusCode} ');
          Get.snackbar(
            'Error',
            'Failed to add book. Status code: ${response.statusCode} ',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      } catch (e) {
        print('Exception: $e');
        Get.snackbar(
          'Error',
          'Error: $e',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }

      // Clear the form after submission
      _formKey.currentState!.reset();
      setState(() {
        _pdfPath = null;
        _imagePath = null;
        _selectedCategory = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0, left: 100, right: 100),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Select Category',
                filled: true,
                fillColor: const Color(0xFFFFEFCD),
                labelStyle: const TextStyle(color: Color(0xffA68E74)),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xffA68E74)),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              value: _selectedCategory,
              items: categories.map((category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category,
                      style: const TextStyle(color: Color(0xff424530))),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select a category';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            _buildTextField(
              labelText: 'Book Name',
              onSaved: (value) {
                _bookName!.text = value!;
              },
              controller: _bookName!,
            ),
            _buildTextField(
                labelText: 'Author Name',
                onSaved: (value) {
                  _authorName!.text = value!;
                },
                controller: _authorName!),
            _buildTextField(
                labelText: 'Description',
                onSaved: (value) {
                  _description.text = value!;
                },
                controller: _description!),
            _buildTextField(
              labelText: 'Number Of Pages',
              onSaved: (value) {
                numberOfPages!.text = value!;
              },
              controller: numberOfPages!,
            ),
            const SizedBox(height: 20),
            _buildButton(
              text: _pickFile == null ? 'Pick PDF' : 'PDF Selected: $_fileName',
              onPressed: _pickFile,
              color: const Color(0xff424530),
            ),
            const SizedBox(height: 20),
            _buildButton(
              text: _imagePath == null
                  ? 'Pick Image'
                  : 'Image Selected: $_imagePath',
              onPressed: _pickImage,
              color: const Color(0xff424530),
            ),
            const SizedBox(height: 20),
            _buildButton(
              text: 'Add Book',
              onPressed: () {
                print(_selectedCategory);
                print(_bookName!.text);
                print(_authorName!.text);
                print(_description!.text.toString());
                print(numberOfPages!.text);
                _addBook();
              },
              color: const Color(0xffE09132),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String labelText,
    required FormFieldSetter<String> onSaved,
    required TextEditingController controller,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          filled: true,
          fillColor: const Color(0xFFFFEFCD),
          labelStyle: const TextStyle(color: Color(0xffA68E74)),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(8.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(8.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xffA68E74)),
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        style: const TextStyle(color: Color(0xff424530)),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter the $labelText';
          }
          return null;
        },
        onSaved: onSaved,
      ),
    );
  }

  Widget _buildButton({
    required String text,
    required VoidCallback onPressed,
    required Color color,
  }) {
    return SizedBox(
      width: double.infinity,
      // height: 45,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: const Color(0xFFFFEFCD),
          backgroundColor: color, // background color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16.0),
        ),
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }
}
