import 'package:ecomm/controllers/get-user-data-controller.dart';
import 'package:ecomm/controllers/sign-in-controller.dart';
import 'package:ecomm/screens/admin-panel/admin-main-screen.dart';
import 'package:ecomm/screens/auth-ui/forget-pass-screen.dart';
import 'package:ecomm/screens/auth-ui/sign-up-screen.dart';
import 'package:ecomm/screens/user-panel/main-screen.dart';
import 'package:ecomm/utils/app-constent.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final SignInController signInController = Get.put(SignInController());
  final GetUserDataController getUserDataController = Get.put(GetUserDataController());
  TextEditingController userEmail = TextEditingController();
  TextEditingController userPass = TextEditingController();
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
//    Password TextField Start
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  width: Get.width,
                  child:Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Obx(() =>
                      TextFormField(
                        obscureText: signInController.isPasswordVisible.value,
                        cursorColor: AppConstant.appSecondoryColor,
                        keyboardType: TextInputType.visiblePassword,
                        controller: userPass,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          contentPadding: EdgeInsets.only(top: 2.0 , left: 8.0),
                          prefixIcon: Icon(Icons.password),
                            suffixIcon: 
                            InkWell(
                              onTap: () {
                                signInController.isPasswordVisible.toggle();
                              },
                              child: signInController.isPasswordVisible.value
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility),
                            ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                          )
                        ),
                      ),
                    ),
                  )
                ),
//    Password TextField End
                Container(
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: InkWell(
                    onTap: () {
                      Get.to(ForgetPassScreen());
                    },
                    child: const Text(
                      'Forgot Password?',
                      style:TextStyle(
                        color: AppConstant.appSecondoryColor,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
//    Forgot Password
                SizedBox(height: Get.width/20,),
//    Google Sign IN Start
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
                        String Pass = userPass.text.toString();
                        if( email.isEmpty || Pass.isEmpty )
                        {
                          Get.snackbar('Error', 'Please enter all details ',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: AppConstant.appSecondoryColor,
                          colorText: AppConstant.appTextColor,
                          );
                        }
                        else
                        {
                          UserCredential? userCredential = await signInController.signInMethod(email, Pass);

                          var userData = await getUserDataController.getUserData(userCredential!.user!.uid);

                          // ignore: unnecessary_null_comparison
                          if(userCredential!=null)
                          {
                            if(userCredential.user!.emailVerified)
                            {

                              if(userData[0]['isAdmin']==true)
                              {
                                Get.offAll(()=>AdminMainScreen());
                                Get.snackbar( 'Success Login Admin' , 'Login Successfully! ',
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: AppConstant.appSecondoryColor,
                                colorText: AppConstant.appTextColor,
                                );

                              }
                              else
                              {
                                Get.offAll(()=>MainScreen());
                                Get.snackbar( 'Success User Login' , 'Login Successfully! ',
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: AppConstant.appSecondoryColor,
                                colorText: AppConstant.appTextColor,
                                );

                              }

                            }else
                            {
                              Get.snackbar( 'Error' , 'Please Verify your email before login ',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: AppConstant.appSecondoryColor,
                              colorText: AppConstant.appTextColor,
                              );
                            }
                          }else
                          {
                            Get.snackbar( 'Error' , 'Please try Again ',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: AppConstant.appSecondoryColor,
                            colorText: AppConstant.appTextColor,
                            );
                          }
                        }
                      },
                      child:const Text(
                        'SIGN IN',
                        style: TextStyle(
                          color: AppConstant.appTextColor
                        ),
                      ),
                      onLongPress: ()async{},
                    ),
                  ),
                ),
                SizedBox(height: Get.width/20,),
//    Google Sign IN End
                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?" , style: TextStyle(color: AppConstant.appSecondoryColor),),
                    InkWell(
                      onTap: ()=>Get.offAll(SignUpScreen()),
                      child: const Text(
                        " Sign Up" , 
                        style:TextStyle(
                          color: AppConstant.appSecondoryColor , fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      }
    );
  }
}