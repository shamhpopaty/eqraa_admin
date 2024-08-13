import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

import '../../add_book/view/add_book.dart';
import '../../categories/view/categories.dart';
import '../../popular_books/view/popular_books.dart';
import '../../user_complaints/view/user_complaints.dart';

class BookManagerPage extends StatefulWidget {
  @override
  _BookManagerPageState createState() => _BookManagerPageState();
}

class _BookManagerPageState extends State<BookManagerPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Eqraa_Admin', style: TextStyle(color: Color(0xff424530))),
          bottom: TabBar(
            indicatorColor: Color(0xffE09132), // لون المؤشر عند التحديد
            labelColor: Color(0xffE09132), // لون النص عند التحديد
            unselectedLabelColor: Colors.grey, // لون النص عند عدم التحديد
            tabs: [
              Tab(text: 'Categories'),
              Tab(text: 'Add Book'),
              Tab(text: 'Popular Books'),
              Tab(text: 'User Complaints'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            CategoriesPage(),
            AddBookPage(),
            PopularBooksPage(),
            UserComplaints(),

          ],
        ),
      ),
    );
  }
}

class Book {
  final String name;
  final String author;
  final String description;
  final String pdfPath;
  final String imagePath;

  Book(this.name, this.author, this.description, this.pdfPath, this.imagePath);
}


