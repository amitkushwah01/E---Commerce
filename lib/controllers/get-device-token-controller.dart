import 'package:ecomm/utils/app-constent.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

class GetDeviceTokenController extends GetxController
{
  String? deviceToken;

  void onInit()
  {
    super.onInit();
    getDeviceTokenMethod();
  }
  Future<void> getDeviceTokenMethod()async
  {
    try{
      String? token = await FirebaseMessaging.instance.getToken();
      if(token!=null)
      {
        deviceToken = token;
        update();
      }
    }
    catch(e){
      Get.snackbar(
        'Error',
        "$e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppConstant.appSecondoryColor,
        colorText: AppConstant.appTextColor,
      );
    }
  }
}