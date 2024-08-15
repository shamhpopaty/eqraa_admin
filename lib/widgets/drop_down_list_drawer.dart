import 'package:eqraa/core/app_export.dart';
import 'package:flutter/material.dart';

import '../core/constant/apptheme.dart';
import '../core/services/services.dart';

class DropDownList extends StatelessWidget {
   DropDownList({super.key,this.isThemeApp= false});
  bool isThemeApp =false;
  MyServices myServices = Get.find();
   Locale? language;

   ThemeData appTheme = themeEnglish;

   changeLang(String langcode) {
     Locale locale = Locale(langcode);
     myServices.sharedPreferences.setString("lang", langcode);
     appTheme = langcode == "en" ? themeEnglish : themeArabic;
     Get.updateLocale(locale);
     Get.changeTheme(appTheme);
   }
   @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(

      hint: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SizedBox(
            width: 400,
            child: Text(
              isThemeApp?"145".tr: "144".tr,
              // textAlign: TextAlign.left,
              style: const TextStyle(color: Colors.black),
            )),
      ),
      underline: const Divider(
        color: Colors.white10,
        thickness: 2,
      ),
      isExpanded: true,
      items:isThemeApp?[
        "light",
        "dart"
      ].map((e) => DropdownMenuItem<String>(
      value: e,
      child: Text(e),
    ))
         .toList(): [
        "Ar",
        "EN"
      ]
          .map((e) => DropdownMenuItem<String>(
        value: e,
        child: Text(e),
      ))
          .toList(),
      borderRadius: BorderRadius.circular(15), onChanged: (String? value) {
        if(!isThemeApp)
        {
          if(value == 'Ar'){
            changeLang('ar');
          }else {
            changeLang('en');
          }
        }else {

          if(value == 'light'){
            // changeLang('ar');
          }else {
            // changeLang('en');
          }
        }

    },
    );
  }
}
