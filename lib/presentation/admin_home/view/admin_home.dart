import 'package:eqraa/core/constant/apptheme.dart';
import 'package:eqraa/core/constant/color.dart';
import 'package:flutter/material.dart';

import '../../add_book/view/add_book.dart';
import '../../categories/view/categories.dart';
import '../../popular_books/view/popular_books.dart';
import '../../user_complaints/view/user_complaints.dart';

class BookManagerPage extends StatefulWidget {
  const BookManagerPage({super.key});

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
          title: Center(
            child: Text(
              'Eqraa Admin',
              style: MyTextStyle.title.copyWith(color: AppColor.white),
            ),
          ),
          bottom: TabBar(
            indicatorColor: AppColor.secondColor, // لون المؤشر عند التحديد
            labelColor: AppColor.secondColor, // لون النص عند التحديد
            unselectedLabelColor: AppColor.gray, // لون النص عند عدم التحديد
            tabs: [
              Tab(
                child: Text(
                  "Categories",
                  style: MyTextStyle.bodySmall.copyWith(color: AppColor.white),
                ),
              ),
              Tab(
                child: Text(
                  "Add Book",
                  style: MyTextStyle.bodySmall.copyWith(color: AppColor.white),
                ),
              ),
              Tab(
                child: Text(
                  "Popular Books",
                  style: MyTextStyle.bodySmall.copyWith(color: AppColor.white),
                ),
              ),
              Tab(
                child: Text(
                  "User Complaints",
                  style: MyTextStyle.bodySmall.copyWith(color: AppColor.white),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            CategoriesPage(),
            const AddBookPage(),
            const PopularBooksPage(),
            const Complaints_Screen(),
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
