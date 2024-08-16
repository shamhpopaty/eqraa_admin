import 'dart:convert';

import 'package:get/get.dart';

import '../../../core/class/status_request.dart';
import '../../../core/functions/handling_data_controller.dart';
import '../../../data/token_manager.dart';
import '../../../models/complaints_model.dart';
import '../data/user_complaints_data.dart';
import 'package:http/http.dart'as http;


class ComplaintsController extends GetxController {
  List<Complaints_Model> complaints = []; // تعديل نوع القائمة إلى Notes_Model
  ComplaintsData complaintsData = ComplaintsData(Get.find());
  StatusRequest statusRequest = StatusRequest.none;
  //List data = [];

  // getData() async {
  //   statusRequest = StatusRequest.loading;
  //   var response = await complaintsData.getData(); // getting the data
  //   statusRequest = handlingData(response); //TO handle the response status
  //   if (StatusRequest.success == statusRequest) {
  //
  //     data.addAll(response['data']);}
  //   else {
  //     statusRequest = StatusRequest.failure;
  //   }
  //
  //   update();
  // }

  @override
  void onInit() {
    getComplaints();
    super.onInit();
  }
  Future<void> getComplaints() async {
    String accessToken = await TokenManager().accessToken;

    var response = await http.get(
      Uri.parse('http://127.0.0.1:8000/api/bookmarks'),
      headers: {
        "Accept": "application/json",
        'Authorization': 'Bearer $accessToken',
      },
    );

    print(response.statusCode);
    if (response.statusCode == 200) {
      List temp = jsonDecode(response.body);
      complaints = temp.map((item) => Complaints_Model.fromJson(item)).toList();
      statusRequest = StatusRequest.success; // تغيير حالة الطلب إلى success
    } else {
      Get.snackbar('notSuccess', jsonDecode(response.body).toString());
      statusRequest = StatusRequest.failure; // تغيير حالة الطلب إلى failure في حالة الفشل
    }

    update(); // تحديث الـ UI بعد جلب البيانات
  }
}
