import 'package:ecomm/controllers/forget-password-controller.dart';
import 'package:ecomm/screens/auth-ui/sign-in-screen.dart';
import 'package:ecomm/utils/app-constent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class ForgetPassScreen extends StatefulWidget {
  const ForgetPassScreen({super.key});

  @override
  State<ForgetPassScreen> createState() => _ForgetPassScreenState();
}

class _ForgetPassScreenState extends State<ForgetPassScreen> {
  final ForgetPassController forgetPassController = Get.put(ForgetPassController());
  TextEditingController userEmail = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return
    KeyboardVisibilityBuilder(
      builder: (context , iskeyboardVisible)
      {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: AppConstant.appSecondoryColor,
            title: const Text('Sign In ',style: TextStyle(color: AppConstant.appTextColor),),
          ),
          body: Container(
            child: Column(
              children: [
                iskeyboardVisible ? const Padding(
                  padding:EdgeInsets.only(top: 10),
                  child: Text('Welcome to my App'),
                ):
                Column(
                  children: [
                    Container(color: AppConstant.appSecondoryColor,
                      child: LottieBuilder.asset('assets/Anim1.json')
                    )
                  ],
                ),
                SizedBox(height: Get.height/20,),
//    Email TextField Start
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  width: Get.width,
                  child:Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: userEmail,
                      cursorColor: AppConstant.appSecondoryColor,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        contentPadding: EdgeInsets.only(top: 2.0 , left: 8.0),
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                        )
                      ),
                    ),
                  )
                ),
//    Email TextField End
                SizedBox(height: Get.width/20,),

              Material(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppConstant.appSecondoryColor,
                    borderRadius: BorderRadius.circular(20)
                    ),
                    width: Get.width / 2,
                    height: Get.height / 18,
                    child: TextButton(
                      onPressed: ()async{
                        String email = userEmail.text.toString();
                        if( email.isEmpty )
                        {
                          Get.snackbar('Error', 'Please enter all details ',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: AppConstant.appSecondoryColor,
                          colorText: AppConstant.appTextColor,
                          );
                        }
                        else
                        {
                          String email = userEmail.text.toString();
                          forgetPassController.ForgetPassInMethod(email);
                          Get.to(SignInScreen());
                        }
                      },
                      child:const Text(
                        'Forget Password',
                        style: TextStyle(
                          color: AppConstant.appTextColor
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: Get.width/20,),
              ],
            ),
          ),
        );
      }
    );
  }
}