import 'package:flutter/material.dart';

import '../../categories_book/view/categories_book.dart';

class CategoriesPage extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // عدد الأعمدة في الشبكة
          crossAxisSpacing: 10.0, // المسافة الأفقية بين الأعمدة
          mainAxisSpacing: 10.0, // المسافة الرأسية بين الصفوف
          childAspectRatio: 2/1, // نسبة العرض إلى الارتفاع للعناصر
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CategoryBooksPage(category: categories[index]),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xffFFEFCD),
                // border: Border.all(color: Color(0xff424530)),
                borderRadius: BorderRadius.circular(10.0), // تدوير الحواف
              ),
              child: Center(
                child: Text(
                  categories[index],
                  style: TextStyle(
                      color: Color(0xff424530),
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
