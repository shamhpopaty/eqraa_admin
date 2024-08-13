// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class UserComplaints extends StatefulWidget {
  const UserComplaints({super.key});

  @override
  State<UserComplaints> createState() => _UserComplaintsState();
}

class _UserComplaintsState extends State<UserComplaints> {
  @override
  Widget build(BuildContext context) {
    final List<UserModel> userList = [
      UserModel(userName: 'Sham', userComplaints: 'userComplaints يعني المشكلة تبع اليوزر'),
      UserModel(userName: 'Youmna', userComplaints: 'userComplaints يعني المشكلة تبع اليوزر'),
      UserModel(userName: 'Rama', userComplaints: 'userComplaints يعني المشكلة تبع اليوزر')

    ];

    return Scaffold(
      body: ListView.builder(
        itemCount: userList.length,
        itemBuilder: (context, index) {
          final user = userList[index];

          return Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Row(
              children: [

                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(user.userName,style: TextStyle(
                        color: Color(0xffA68E74),
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                    ),),
                    Text(user.userComplaints),

                  ],
                ),


              ],
            ),
          );
        },
      ),
    );
  }
}

class UserModel {
  String userName;
  String userComplaints;
  UserModel({
    required this.userName,
    required this.userComplaints,
  });

}
