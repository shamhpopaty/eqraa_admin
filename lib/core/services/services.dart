import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyServices extends GetxService {
  late SharedPreferences sharedPreferences;

  Future<MyServices> init() async {
    ///todo : FIREBASE INITIALIZING
    // await Firebase.initializeApp(
    //   options: const FirebaseOptions(
    //     apiKey: "", // paste your api key here
    //     appId: "", //paste your app id here
    //     messagingSenderId: "", //paste your messagingSenderId here
    //     projectId: "", //paste your project id here
    //   ),
    // );
    sharedPreferences = await SharedPreferences.getInstance();
    return this;
  }

  setUserID(String id){
    return sharedPreferences.setString("id", id);

  }
  getUserID(){
   return sharedPreferences.getString("id");

  }
  getBookID(){
    return sharedPreferences.getString("bookID");

  }
getToken(){
  return sharedPreferences.getString("token");
}
}

initialServices() async {
  await Get.putAsync(() => MyServices().init());
}
