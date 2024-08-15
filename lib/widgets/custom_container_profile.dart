import 'package:flutter/material.dart';

import '../core/constant/color.dart';

Widget container_profile(IconData icon, String containerName, IconData endicon,)=>
  SizedBox(
    height: 50,
    width: 400,
    child: Row(
      children: [
        Icon(icon),
        const SizedBox(width: 10,),
        Text(containerName,
          style: const TextStyle(
              color: AppColor.black,
              fontWeight: FontWeight.bold
          ),),
        const SizedBox(width: 230,),
        IconButton(onPressed: (){},
            icon: Icon(endicon))
      ],
    ),
  );


Widget container_profile2(IconData icon, String containerName, int number)=>
    SizedBox(
      height: 50,
      width: 400,
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(width: 10,),
          Text(containerName,
            style: const TextStyle(
                color: AppColor.black,
                fontWeight: FontWeight.bold
            ),),
          const SizedBox(width:180 ),
         Text("$number"),
        ],
      ),
    );

Widget container_profile3(IconData icon, String containerName, int number)=>
    SizedBox(
      height: 50,
      width: 400,
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(width: 10,),
          Text(containerName,
            style: const TextStyle(
                color: AppColor.black,
                fontWeight: FontWeight.bold
            ),),
          const SizedBox(width:125 ),
          Text("$number"),
        ],
      ),
    );

Widget container_profile4(IconData icon, String containerName, IconData endicon,)=>
    SizedBox(
      height: 50,
      width: 400,
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(width: 10,),
          Text(containerName,
            style: const TextStyle(
                color: AppColor.black,
                fontWeight: FontWeight.bold
            ),),
          const SizedBox(width: 220,),
          IconButton(onPressed: (){},
              icon: Icon(endicon))
        ],
      ),
    );
