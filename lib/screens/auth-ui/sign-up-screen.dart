import 'package:ecomm/controllers/sign-up-controller.dart';
import 'package:ecomm/screens/auth-ui/sign-in-screen.dart';
import 'package:ecomm/utils/app-constent.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final SignUpController signUpController = Get.put(SignUpController());
  TextEditingController userName = TextEditingController();
  TextEditingController userEmail = TextEditingController();
  TextEditingController userPhone = TextEditingController();
  TextEditingController userPass = TextEditingController();
  TextEditingController userCity = TextEditingController();

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
            title: const Text('Sign Up ',style: TextStyle(color: AppConstant.appTextColor),),
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              child: Column(
                children: [
                  SizedBox(height: Get.height/20,),
                  Text('Welcome to my App ',style: TextStyle(fontSize: 16 , color: AppConstant.appSecondoryColor , fontWeight: FontWeight.bold),),
                  SizedBox(height: Get.height/20,),
            //    Email TextField Start
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    width: Get.width,
                    child:Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        cursorColor: AppConstant.appSecondoryColor,
                        keyboardType: TextInputType.emailAddress,
                        controller: userEmail,
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
            //    UserName TextField Start
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    width: Get.width,
                    child:Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        cursorColor: AppConstant.appSecondoryColor,
                        keyboardType: TextInputType.name,
                        controller: userName,
                        decoration: InputDecoration(
                          hintText: 'UserName',
                          contentPadding: EdgeInsets.only(top: 2.0 , left: 8.0),
                          prefixIcon: Icon(Icons.person),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                          )
                        ),
                      ),
                    )
                  ),
            //    UserName TextField End
            //    Phone Call TextField Start
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    width: Get.width,
                    child:Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        cursorColor: AppConstant.appSecondoryColor,
                        keyboardType: TextInputType.phone,
                        controller: userPhone,
                        decoration: InputDecoration(
                          hintText: 'Phone',
                          contentPadding: EdgeInsets.only(top: 2.0 , left: 8.0),
                          prefixIcon: Icon(Icons.call),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                          )
                        ),
                      ),
                    )
                  ),
            //    Phone Call TextField End
            //    Location TextField Start
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    width: Get.width,
                    child:Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        cursorColor: AppConstant.appSecondoryColor,
                        keyboardType: TextInputType.name,
                        controller: userCity,
                        decoration: InputDecoration(
                          hintText: 'City',
                          contentPadding: EdgeInsets.only(top: 2.0 , left: 8.0),
                          prefixIcon: Icon(Icons.location_pin),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                          )
                        ),
                      ),
                    )
                  ),
            //    Location TextField End            
            //    Password TextField Start
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    width: Get.width,
                    child:Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:
                      Obx(() =>
                        TextFormField(
                          controller: userPass,
                          obscureText: signUpController.isPasswordVisible.value,
                          cursorColor: AppConstant.appSecondoryColor,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            contentPadding: EdgeInsets.only(top: 2.0 , left: 8.0),
                            prefixIcon: Icon(Icons.password),
                            suffixIcon: 
                            InkWell(
                              onTap: () {
                                signUpController.isPasswordVisible.toggle();
                              },
                              child: signUpController.isPasswordVisible.value
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
                  SizedBox(height: Get.width/20,),
            //    Google Sign UP Start
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
                          // String name = userName.text.trim();
                          // String email = userEmail.text.trim();
                          // String phone = userPhone.text.trim();
                          // String city = userCity.text.trim();
                          // String password = userPass.text.trim();
                          String name = userName.text.toString();
                          String email = userEmail.text.toString();
                          String phone = userPhone.text.toString();
                          String city = userCity.text.toString();
                          String password = userPass.text.toString();
                          String userDeviceToken = '';

                          if( name.isEmpty || email.isEmpty || phone.isEmpty
                           || city.isEmpty || password.isEmpty)
                           {
                            Get.snackbar(
                              'Error', 'Please Enter Full Details',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: const Color.fromARGB(255, 240, 93, 80),
                              colorText: AppConstant.appTextColor,
                            );
                           }
                           else
                           {
                            UserCredential? userCredential = await signUpController.signUpMethod(
                              name,
                              email,
                              phone,
                              city,
                              password,
                              userDeviceToken
                            );
                            if(userCredential!=null)
                            {
                              Get.snackbar(
                                'Verification email sent',
                                'Please check your email',
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: AppConstant.appSecondoryColor,
                                colorText: AppConstant.appTextColor,
                              );
                              FirebaseAuth.instance.signOut();
                              Get.offAll(()=>SignInScreen());
                            }
                           }
                        },
                        child:const Text(
                          'SIGN UP',
                          style: TextStyle(
                            color: AppConstant.appTextColor
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: Get.width/20,),
            //    Google Sign UP End
                  Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account?" , style: TextStyle(color: AppConstant.appSecondoryColor),),
                      InkWell(
                        onTap: ()=>Get.offAll(SignInScreen()),
                        child: const Text(
                          " SIGN IN" , 
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
          ),
        );
      }
    );
  }
}