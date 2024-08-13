import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../admin_home/view/admin_home.dart';

class AddBookPage extends StatefulWidget {
  @override
  _AddBookPageState createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {
  final _formKey = GlobalKey<FormState>();
  String? _bookName;
  String? _authorName;
  String? _description;
  String? _pdfPath;
  String? _imagePath;
  String? _selectedCategory;
  String? _fileName;

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
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result != null && result.files.isNotEmpty) {
        setState(() {
          _fileName = result.files.single.name;
        });
        print('file selected successfully');
      }
    } catch (e) {
      // Handle the error appropriately
      print('Error picking file: $e');
    }
  }

  Future<void> _pickImage() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      setState(() {
        _imagePath = result.files.single.name; // Save only the name
      });
    }
  }

  void _addBook() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final newBook = Book(
        _bookName!,
        _authorName!,
        _description!,
        _pdfPath!,
        _imagePath!,
      );

      // Add the new book to the appropriate category
      // ...

      // Clear the form
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
                fillColor: Color(0xFFFFEFCD),
                labelStyle: TextStyle(color: Color(0xffA68E74)),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffA68E74)),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              value: _selectedCategory,
              items: categories.map((category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category,
                      style: TextStyle(color: Color(0xff424530))),
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
            SizedBox(height: 20),
            _buildTextField(
              labelText: 'Book Name',
              onSaved: (value) {
                _bookName = value;
              },
            ),
            _buildTextField(
              labelText: 'Author Name',
              onSaved: (value) {
                _authorName = value;
              },
            ),
            _buildTextField(
              labelText: 'Description',
              onSaved: (value) {
                _description = value;
              },
            ),
            SizedBox(height: 20),
            _buildButton(
              text: _pickFile == null ? 'Pick PDF' : 'PDF Selected: $_fileName',
              onPressed: _pickFile,
              color: Color(0xff424530),
            ),
            SizedBox(height: 20),
            _buildButton(
              text: _imagePath == null
                  ? 'Pick Image'
                  : 'Image Selected: $_imagePath',
              onPressed: _pickImage,
              color: Color(0xff424530),
            ),
            SizedBox(height: 20),
            _buildButton(
              text: 'Add Book',
              onPressed: () {
                print(_selectedCategory);
                print(_bookName);
                print(_authorName);
                print(_description);
              },
              color: Color(0xffE09132),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String labelText,
    required FormFieldSetter<String> onSaved,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: labelText,
          filled: true,
          fillColor: Color(0xFFFFEFCD),
          labelStyle: TextStyle(color: Color(0xffA68E74)),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(8.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(8.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xffA68E74)),
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        style: TextStyle(color: Color(0xff424530)),
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
      height: 45,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Color(0xFFFFEFCD),
          backgroundColor: color, // background color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: EdgeInsets.symmetric(vertical: 16.0),
        ),
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }
}
