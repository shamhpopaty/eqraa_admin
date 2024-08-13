import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/constant/color.dart';
import '../../presentation/homeScreens/homescreen_controller.dart';

class CustomAppBarHome extends GetView<HomeScreenControllerImp>
    implements PreferredSizeWidget {
  const CustomAppBarHome({super.key});

  @override
  Size get preferredSize => AppBar().preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColor.primaryColor,
/*title: Shimmer.fromColors(
  baseColor: AppColor.white,
  highlightColor: AppColor.black,
  child:
  Text('التصنيفات',
    textDirection: TextDirection.ltr,),
),*/
    );
  }
}
