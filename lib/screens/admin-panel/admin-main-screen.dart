import 'package:flutter/material.dart';

class AdminMainScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin Panel'),
      // actions: [
      //   InkWell(
      //     onTap: () async{
      //       GoogleSignIn googleSignIn = GoogleSignIn();
      //       FirebaseAuth _auth = FirebaseAuth.instance;
      //       await _auth.signOut();
      //       await googleSignIn.signOut();
      //       Get.offAll(WelcomeScreen());
      //       },
      //       child: Padding(
      //         padding: const EdgeInsets.all(8.0),
      //         child: Icon(Icons.logout ,),
      //       ),
      //     )
      //   ],
      ),
    );
  }
}