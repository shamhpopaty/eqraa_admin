// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:flutter/material.dart';
//
// class UserComplaints extends StatefulWidget {
//   const UserComplaints({super.key});
//
//   @override
//   State<UserComplaints> createState() => _UserComplaintsState();
// }
//
// class _UserComplaintsState extends State<UserComplaints> {
//   @override
//   Widget build(BuildContext context) {
//     final List<UserModel> userList = [
//       UserModel(userName: 'Sham', userComplaints: 'userComplaints يعني المشكلة تبع اليوزر'),
//       UserModel(userName: 'Youmna', userComplaints: 'userComplaints يعني المشكلة تبع اليوزر'),
//       UserModel(userName: 'Rama', userComplaints: 'userComplaints يعني المشكلة تبع اليوزر')
//
//     ];
//
//     return Scaffold(
//       body: ListView.builder(
//         itemCount: userList.length,
//         itemBuilder: (context, index) {
//           final user = userList[index];
//
//           return Container(
//             margin: const EdgeInsets.all(10),
//             padding: const EdgeInsets.all(10),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//               color: Colors.white,
//             ),
//             child: Row(
//               children: [
//
//                 const SizedBox(width: 10),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(user.userName,style: const TextStyle(
//                         color: Color(0xffA68E74),
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold
//                     ),),
//                     Text(user.userComplaints),
//
//                   ],
//                 ),
//
//
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
//
// class UserModel {
//   String userName;
//   String userComplaints;
//   UserModel({
//     required this.userName,
//     required this.userComplaints,
//   });
//
// }


import 'package:eqraa/core/app_export.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../core/class/handlingdataview.dart';
import '../../../widgets/complaints_item.dart';
import '../controller/user_complaints_controller.dart';

class Complaints_Screen extends StatefulWidget {
  const Complaints_Screen({super.key});

  @override
  State<Complaints_Screen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<Complaints_Screen> {
  @override
  Widget build(BuildContext context) {
    final ComplaintsController complaintsController = Get.put(ComplaintsController());

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: SingleChildScrollView(
          child: Column(
            children: [
              GetBuilder<ComplaintsController>(builder: (complaintsController) {
                return HandlingDataView(
                  statusRequest: complaintsController.statusRequest,
                  widget: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(), // لجعل القائمة تعمل بسلاسة داخل ScrollView
                    itemCount: complaintsController.complaints.length,
                    itemBuilder: (context, index) {
                      final complaint = complaintsController.complaints[index];
                      return Column(
                        children: [
                          ComplaintsItem(complaint: complaint, complaintsController: complaintsController,),
                          SizedBox(height: 20,)
                        ],
                      ); // تمرير البيانات إلى الـ NoteItem
                    },
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
