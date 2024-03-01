import 'package:ecomm/controllers/google-sign-in-controller.dart';
import 'package:ecomm/screens/auth-ui/sign-in-screen.dart';
import 'package:ecomm/utils/app-constent.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({super.key});
  final GoogleSignInController _googleSignInController = 
    Get.put(GoogleSignInController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppConstant.appSecondoryColor,
        title: const Text('Welcome to my app',style: TextStyle(color: AppConstant.appStatusBarColor),),
      ),
      body: Container(
        child: Column(
          children: [
            Container(color: AppConstant.appSecondoryColor,
              child: Lottie.asset('assets/Anim1.json'),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: const Text(
                'Happy Shopping',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              )
            ),
            SizedBox(height: Get.height / 12),
//    Google Sign IN Start
            Material(
              child: Container(
                decoration: BoxDecoration(
                  color: AppConstant.appSecondoryColor,
                  borderRadius: BorderRadius.circular(20)
                ),
                width: Get.width / 1.2,
                height: Get.height / 12,
                child: TextButton.icon(
                  onPressed: (){
                    _googleSignInController.signInWithGoogle();
                  },
                  icon: Image.asset(
                    'assets/google.png' ,
                    width : Get.width / 12 ,
                    height: Get.height / 1.2,
                  ),
                  label: const Text(
                    'Sign in with Google',
                    style: TextStyle(
                      color: AppConstant.appTextColor
                    ),
                  ),
                  onLongPress: (){},
                ),
              ),
            ),
//    Google Sign IN End
            SizedBox(height: Get.height / 50),
//    email Sign IN Start
            Material(
              child: Container(
                decoration: BoxDecoration(
                  color: AppConstant.appSecondoryColor,
                  borderRadius: BorderRadius.circular(20)
                ),
                width: Get.width / 1.2,
                height: Get.height / 12,
                child: TextButton.icon(
                  onPressed: (){
                    Get.to(()=>SignInScreen());
                    // _googleSignInController.signInWithGoogle();
                  },
                  icon:Icon(Icons.mail),
                  label: const Text(
                    'Sign in with email',
                    style: TextStyle(
                      color: AppConstant.appTextColor
                    ),
                  ),
                  onLongPress: (){},
                ),
              ),
            )
//    email Sign IN End
          ],
        ),
      ),
    );
  }
}