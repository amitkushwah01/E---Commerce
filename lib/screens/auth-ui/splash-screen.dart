import 'dart:async';
import 'package:ecomm/controllers/get-user-data-controller.dart';
import 'package:ecomm/screens/admin-panel/admin-main-screen.dart';
import 'package:ecomm/screens/auth-ui/welcome-screen.dart';
import 'package:ecomm/screens/user-panel/main-screen.dart';
import 'package:ecomm/utils/app-constent.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 3), () {
        loggedIn();
      }
    );
  }

  Future<void> loggedIn()async
  {
    if(user!=null)
    {
      GetUserDataController getUserDataController = Get.put(GetUserDataController());
      var userData = await getUserDataController.getUserData(user!.uid);
      if(userData[0]['isAdmin']==true)
      {
        Get.offAll(AdminMainScreen());
      }
      else{
        Get.offAll(MainScreen());
      }
    }
    else
    {
      Get.to(WelcomeScreen());
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstant.appSecondoryColor,
      appBar: AppBar(
        backgroundColor: AppConstant.appSecondoryColor,
        elevation: 0, 
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: Get.width,
                alignment: Alignment.center,
                child: Lottie.asset('assets/Anim1.json'),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20.0),
              width: Get.width,
              alignment: Alignment.center,
              child: Text(
                AppConstant.appPoweredBy,
                style: const TextStyle(
                  color: AppConstant.appTextColor,
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
