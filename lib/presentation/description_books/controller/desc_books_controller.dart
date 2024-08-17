import 'package:eqraa/presentation/description_books/view/desc_books.dart';
import 'package:get/get.dart';

import '../../../core/class/status_request.dart';
import '../../../core/functions/handling_data_controller.dart';
import '../../../core/services/services.dart';
import '../../../routes.dart';
import '../data/desc_books_data.dart';

abstract class DescriptionBooksController extends GetxController {
  Description_Books();
}


class DescriptionBooksControllerImp extends DescriptionBooksController {
  MyServices myServices = Get.find();
  DescriptionBooksData descriptionbookdata = DescriptionBooksData(Get.find());
  StatusRequest statusRequest = StatusRequest.none;
  int rating =0;
  String message='';
  List data = [];

  dynamic getData() async {
    statusRequest = StatusRequest.loading;
    var response = await descriptionbookdata.getData(); // getting the data
    statusRequest = handlingData(response); //TO handle the response status
    if (StatusRequest.success == statusRequest) {

      data.addAll(response['data']);}
    else {
      statusRequest = StatusRequest.failure;
    }

    update();
  }

  dynamic rateBook() async {
    statusRequest = StatusRequest.loading;
    var response = await descriptionbookdata.rateBook(rating.toString(),int.parse(myServices.getBookID())); // getting the data
    statusRequest = handlingData(response); //TO handle the response status
    if (StatusRequest.success == statusRequest) {

      message = response['message'];
    Get.snackbar("success", message);
    }
    else {
      statusRequest = StatusRequest.failure;
      Get.snackbar("success", message);
    }
    update();
  }

  @override
  void onInit() {
    getData();
    super.onInit();
  }


  @override
  Description_Books() {
    Get.toNamed(AppRoutes.descriptionbook);

  }
}
