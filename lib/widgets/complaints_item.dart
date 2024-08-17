import 'package:eqraa/core/app_export.dart';
import 'package:eqraa/core/constant/color.dart';
import 'package:eqraa/models/complaints_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/localization/changelocal.dart';
import '../presentation/user_complaints/controller/user_complaints_controller.dart';

class ComplaintsItem extends StatelessWidget {
  final Complaints_Model complaint;
  final ComplaintsController complaintsController;

  ComplaintsItem({super.key, required this.complaint, required this.complaintsController});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: AppColor.fourthColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          ListTile(
            trailing: Text("Created At:${complaint.createdAt.toString()}"),
            title: Text(
              complaint.userId.toString(), // عرض اسم الملاحظة
              style: TextStyle(
                color: (Colors.black),
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text(
                complaint.content ?? "No Notes", // عرض النص الكامل للملاحظة
                style: TextStyle(
                  color: Colors.black.withOpacity(0.6),
                  fontSize: 18,
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
