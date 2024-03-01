import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomm/controllers/get-device-token-controller.dart';
import 'package:ecomm/models/user_model.dart';
import 'package:ecomm/screens/user-panel/main-screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInController extends GetxController
{
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void>signInWithGoogle()async
  {
    GetDeviceTokenController getDeviceTokenController = Get.put(GetDeviceTokenController());
    try{
      final GoogleSignInAccount? googleSignInAccount = 
        await googleSignIn.signIn();

        if(googleSignInAccount!=null)
        {
          EasyLoading.show(status: 'Please Wait...');
          final GoogleSignInAuthentication googleSignInAuthentication = 
            await googleSignInAccount.authentication;

            final AuthCredential credential = GoogleAuthProvider.credential(
              accessToken: googleSignInAuthentication.accessToken,
              idToken: googleSignInAuthentication.idToken,
            );
            final UserCredential userCredential = 
              await _auth.signInWithCredential(credential);
            final User? user = userCredential.user;

            if(user!=null)
            {
              UserModel userModel = UserModel(
                uId: user.uid, 
                username: user.displayName.toString(),
                email: user.email.toString(), 
                phone: user.phoneNumber.toString(),
                userimg: user.photoURL.toString(),
                userDeviceToken: getDeviceTokenController.deviceToken.toString(),
                country: '',
                userAddress: '',
                street: '',
                isAdmin: false,
                isActive: true, 
                createdOn: DateTime.now(),
                city: '',
              );
              await FirebaseFirestore.instance
                .collection('users')
                .doc(user.uid)
                .set(userModel.toMap());
              EasyLoading.dismiss();
              Get.offAll(MainScreen());
            }

        }
//
    }catch(e)
    {
      EasyLoading.dismiss();
      print('Error...$e....');
    }
  }

}
// keytool -list -v -keystore C:\Users\Dell\.android\debug.keystore -alias androiddebugkey -storepass android -keypass android
