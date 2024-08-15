import 'package:flutter/material.dart';

import '../../book_datails/view/book_datails.dart';

class CategoryBooksPage extends StatelessWidget {
  final String category;

  const CategoryBooksPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {

    final List<BookModel> booksList=[
      BookModel(
        name: "Alshmail",
        authorName: "Dr_Adham",
        image: "assets/coversh.png",
        description: "Summary of playlist for shmail",
        pdfPath: "assets/pdf/shmail.pdf",
      ),
      BookModel(
        name: "Alsera",
          authorName: "Dr_Mohammed",
        image:"assets/alsera.jpg",
        description: "Summary of Alser_Alnabawea book",
        pdfPath: "assets/pdf/sera.pdf",
      ),
      BookModel(
        name: "Doaa",
        authorName: "Anonymous Person",
        image: "assets/camera.jpg",
        description: "Many beautiful doaa",
        pdfPath: "assets/doaa.jpg",
      ),
      // يمكنك إضافة المزيد من الكتب هنا
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('$category Books'),
      ),
      body: ListView.builder(
        itemCount: booksList.length,
        itemBuilder: (context, index) {
          final book = booksList[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookDetailsPage(book: book),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                // boxShadow: [
                //   BoxShadow(
                //     color: Colors.grey.withOpacity(0.5),
                //     spreadRadius: 2,
                //     blurRadius: 5,
                //     offset: Offset(0, 3), // changes position of shadow
                //   ),
                // ],
              ),
              child: Row(
                children: [
                  Image.asset(
                    book.image,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(book.name),
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit),
                    color: const Color(0xffA68E74),
                    onPressed: () {
                      // إضافة كود التعديل هنا
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    color: Colors.red,
                    onPressed: () {
                      // إضافة كود الحذف هنا
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class BookModel {
  String name;
  String authorName;
  String image;
  String description;
  String pdfPath;
  BookModel({
    required this.name,
    required this.authorName,
    required this.image,
    required this.description,
    required this.pdfPath,
  });
}

