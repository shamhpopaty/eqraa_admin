// ignore_for_file: avoid_print


import '../../../../core/class/crud.dart';

import '../../../../linkapi.dart';

class MyProfileData {
  Crud crud;
  MyProfileData(this.crud);

  getData()
  async {

  var response = await crud.postData(AppLink.test, {});
  return response.fold((l) => l, (r) => r);
  }
  }




