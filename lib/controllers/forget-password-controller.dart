import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomm/utils/app-constent.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class ForgetPassController extends GetxController
{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // ignore: unused_field
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // for password visibility

  Future<void> ForgetPassInMethod( String userEmail) async
  {
    try{
      EasyLoading.show(status: "Please Wait");

      await _auth.sendPasswordResetEmail(email: userEmail);
      Get.snackbar(
        'Request Sent Succesfully',
        "Password Reste Link Sent to $userEmail",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppConstant.appSecondoryColor,
        colorText: AppConstant.appTextColor,
      );
      EasyLoading.dismiss();
    }
    on FirebaseAuthException catch(e){
      EasyLoading.dismiss();
      Get.snackbar(
        'Error',
        "$e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppConstant.appSecondoryColor,
        colorText: AppConstant.appTextColor,
      );
    }
//    it can be remove does not effect
    return null;
//    it can be remove does not effect
  }
}