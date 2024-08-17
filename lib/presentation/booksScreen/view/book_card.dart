import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import '../../../core/constant/imageassets.dart';
import '../../../linkapi.dart';
import '../../../models/book_model.dart';
import '../model/books_model.dart';

class BookCard extends StatelessWidget {
  final Book book;

  final VoidCallback onDelete;
  final DateTime? selectedTime;
  final Function(DateTime? pickedTime) onTimePicked;
  final bool isDark;
  void Function()? onTap;

  BookCard({
    required this.book,

    required this.onDelete,
    required this.selectedTime,
    required this.onTimePicked,
    required this.isDark,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    book.rating == -1 ? 0.0:book.rating;
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: isDark ? Colors.grey : Colors.white,
        elevation: 5,
        child: Column(
          children: [
            Image.network(
              "${AppLink.baseServer}/storage/${book.cover!}",
              fit: BoxFit.cover,
              height: 80,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(
                    height: 80, AppImageAssets.camera, fit: BoxFit.cover);
              },
            ),

            Text(book.title ?? ''),
            const SizedBox(height: 1),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(Icons.alarm),
                  onPressed: () async {
                    TimeOfDay? timeOfDay = await showDialog(
                      context: context,
                      builder: (context) {
                        return TimePickerDialog(
                          initialTime: TimeOfDay.fromDateTime(DateTime.now()),
                          confirmText: "ok",
                          cancelText: "cancel",
                        );
                      },
                    );

                    if (timeOfDay != null) {
                      DateTime now = DateTime.now();
                      DateTime pickedTime = DateTime(
                        now.year,
                        now.month,
                        now.day,
                        timeOfDay.hour,
                        timeOfDay.minute,
                      );
                      onTimePicked(pickedTime);
                    } else {
                      onTimePicked(null);
                    }
                  },
                ),
                IconButton(
                  icon: const Icon(
                 Icons.delete,
                    color:Colors.red
                  ),
                  onPressed: onDelete,
                ),

              ],
            ),
            RatingBar.builder(
              textDirection: TextDirection.ltr,
              initialRating: book.rating??0.0,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              tapOnlyMode: true,
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ), onRatingUpdate: (double value) {  },

            ),
          ],
        ),
      ),
    );
  }
}
