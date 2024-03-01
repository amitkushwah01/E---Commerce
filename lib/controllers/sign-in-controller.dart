import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomm/utils/app-constent.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class SignInController extends GetxController
{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // ignore: unused_field
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // for password visibility

  var isPasswordVisible = false.obs;

  Future<UserCredential?> signInMethod( String userEmail , String userPass ) async
  {
    try{
      EasyLoading.show(status: "Please Wait");
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: userEmail,
        password: userPass,
      );

      EasyLoading.dismiss();

      return userCredential;

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