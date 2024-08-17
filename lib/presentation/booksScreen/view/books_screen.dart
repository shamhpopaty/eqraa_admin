import 'package:eqraa/core/app_export.dart';
import 'package:eqraa/core/class/handlingdataview.dart';
import 'package:eqraa/core/constant/color.dart';

import 'package:flutter/material.dart';
import '../../../core/localization/changelocal.dart';
import '../../../widgets/auth/custom_text_form.dart';
import '../../../widgets/drop_down_list_drawer.dart';
import '../../../widgets/homeScreen/customappbar.dart';

import '../../description_books/view/desc_books.dart';

import '../controller/books_screen_controller.dart';
import 'book_card.dart';

class BooksScreen extends StatefulWidget {
  final String category;

  BooksScreen({required this.category});

  @override
  State<BooksScreen> createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> {
  var isFavorate = [];

  @override
  Widget build(BuildContext context) {

    final BooksScreenControllerImp controller =
        Get.put(BooksScreenControllerImp(widget.category));
    DateTime? selectedTime = DateTime.now();

    return Scaffold(
      backgroundColor:
      (!localController.isDark) ? AppColor.white : AppColor.black,
      appBar: const CustomAppBarHome(),

      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(left: 8.0, right: 8, top: 8, bottom: 8),
              child: AuthTextFormField(
                hintText: "177".tr,
                iconPrefix: Icons.search,
                textBox: '',
                onChanged: (val) {
                  controller.searchQuery.value = val;
                },
              ),
            ),
            GetBuilder<BooksScreenControllerImp>(builder: (controller) {
              LocaleController localController = Get.put(LocaleController());
              if (controller.filteredBooks.isNotEmpty) {
                for (int i = 0; i < controller.filteredBooks.length; i++) {
                  isFavorate.add(false);
                }
              }
              return HandlingDataView(
                statusRequest: controller.statusRequest,
                text: "175".tr,
                onOffline: () {
                  controller.fetchBooks();
                },
                widget: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 5.0,
                    crossAxisSpacing: 5.0,
                  ),
                  itemCount: controller.filteredBooks.length,
                  itemBuilder: (context, i) {


                      final book = controller.filteredBooks[i];


                      return HandlingDataView(
                        statusRequest: controller.statusRequest,
                        imageHeight: 100,
                        widget: SizedBox(
                          height: 200,
                          width: 200,
                          child: BookCard(
                            onTap: () {
                              controller.myServices.sharedPreferences.setString("bookID", book.id.toString());
                              Get.to(() => DescriptionBooks(
                                book: controller.books[i],
                                endTimeMillisecond: selectedTime != null
                                    ? selectedTime!.millisecondsSinceEpoch
                                    : -1, // Pass -1 if no time is picked
                              ));
                            },
                            book: book,


                            selectedTime: selectedTime,
                            onTimePicked: (pickedTime) {
                              setState(() {
                                selectedTime = pickedTime;
                              });
                            },
                            isDark: false, onDelete: () { controller.removeFavoriteBook(book); },
                          ),
                        )

                    );
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
