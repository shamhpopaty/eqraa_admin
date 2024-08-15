import 'package:flutter/material.dart';

import '../../book_datails/view/book_datails.dart';
import '../../categories_book/view/categories_book.dart';


class PopularBooksPage extends StatefulWidget {
  const PopularBooksPage({super.key});

  @override
  State<PopularBooksPage> createState() => _PopularBooksPageState();
}

class _PopularBooksPageState extends State<PopularBooksPage> {
  @override
  Widget build(BuildContext context) {
    final List<BookModel> booksList = [
      BookModel(
        name: "Book 1",
        authorName: "Author 1",
        image: "assets/camera.jpg",
        description: "Description of Book 1",
        pdfPath: "path/to/book1.pdf",
      ),
      BookModel(
        name: "Book 2",
        authorName: "Author 2",
        image: "assets/camera.jpg",
        description: "Description of Book 2",
        pdfPath: "path/to/book2.pdf",
      ),
      BookModel(
        name: "Book 3",
        authorName: "Author 3",
        image: "assets/camera.jpg",
        description: "Description of Book 3",
        pdfPath: "path/to/book3.pdf",
      ),
      // يمكنك إضافة المزيد من الكتب هنا
    ];

    return Scaffold(
      body: ListView.builder(
        itemCount: booksList.length,
        itemBuilder: (context, index) {
          final book = booksList[index];
          num averageRating = 2;
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

                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        size: 14,
                        color: (averageRating > 0)
                            ? const Color.fromRGBO(228, 178, 0, 1)
                            : const Color.fromRGBO(217, 217, 217, 1),
                      ),
                      Icon(
                        Icons.star,
                        size: 14,
                        color: (averageRating > 1)
                            ? const Color.fromRGBO(228, 178, 0, 1)
                            : const Color.fromRGBO(217, 217, 217, 1),
                      ),
                      Icon(
                        Icons.star,
                        size: 14,
                        color: (averageRating > 2)
                            ? const Color.fromRGBO(228, 178, 0, 1)
                            : const Color.fromRGBO(217, 217, 217, 1),
                      ),
                      Icon(
                        Icons.star,
                        size: 14,
                        color: (averageRating > 3)
                            ? const Color.fromRGBO(228, 178, 0, 1)
                            : const Color.fromRGBO(217, 217, 217, 1),
                      ),
                      Icon(
                        Icons.star,
                        size: 14,
                        color: (averageRating > 4)
                            ? const Color.fromRGBO(228, 178, 0, 1)
                            : const Color.fromRGBO(217, 217, 217, 1),
                      ),
                    ],
                  ),
                  //             Row(
                  //   mainAxisSize: MainAxisSize.min,
                  //   children: [
                  //     Icon(Icons.star, color: Colors.yellow),
                  //     Icon(Icons.star, color: Colors.yellow),
                  //     Icon(Icons.star, color: Colors.yellow),
                  //     Icon(Icons.star, color: Colors.yellow),
                  //     Icon(Icons.star, color: Colors.grey),
                  //   ],
                  // ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
