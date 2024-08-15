import 'package:eqraa/presentation/Auth/view/signup.dart';
import 'package:eqraa/presentation/My_Profile/view/my_profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/services/services.dart';


abstract class HomeScreenController extends GetxController {
  changePage(int i);
}

class HomeScreenControllerImp extends HomeScreenController {
  int currentPage = 0;
  late PageController pageController;
  String? username;
  String? id, phone;
  String? lang;
  MyServices myServices = Get.find();

  List<Widget> listPage = [


    const SignUp(),
    const MyProfile(),

  ];

  List bottomAppBar = [
    {
      "title": "43".tr,
      "icon": Icons.home,
    },
    {
      "title": "45".tr,
      "icon": Icons.favorite,
    },
    {
      "title": "46".tr,
      "icon": Icons.person,
    },
    {
      "title": "143".tr,
      "icon": Icons.chat,
    },

  ];
  initialData() {
    lang = myServices.sharedPreferences.getString("lang");
    username = myServices.sharedPreferences.getString("username");
    id = myServices.sharedPreferences.getString("id");
    phone = myServices.sharedPreferences.getString("phone");
  }

  @override
  void onInit() {
    pageController = PageController(initialPage: currentPage);
    initialData();
    super.onInit();
  }

  @override
  changePage(int i) {
    currentPage = i;

    update();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
