// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCHelxMWuEU2ZUmNSeu6pDvDP3e0uzWgI0',
    appId: '1:795736931932:web:29680c71aad820e2cb3099',
    messagingSenderId: '795736931932',
    projectId: 'ecomm-d3c12',
    authDomain: 'ecomm-d3c12.firebaseapp.com',
    storageBucket: 'ecomm-d3c12.appspot.com',
    measurementId: 'G-0BKC1ZNG8B',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCmg7U8DAcm_mykQZFeyjcnvAWW7JT9s-Y',
    appId: '1:795736931932:android:06ffbe90f0ab1800cb3099',
    messagingSenderId: '795736931932',
    projectId: 'ecomm-d3c12',
    storageBucket: 'ecomm-d3c12.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBpYGwK8zvIEMY923HuIePiZ6JSdPYYHwQ',
    appId: '1:795736931932:ios:edeaa336927bba7acb3099',
    messagingSenderId: '795736931932',
    projectId: 'ecomm-d3c12',
    storageBucket: 'ecomm-d3c12.appspot.com',
    iosBundleId: 'com.example.ecomm',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBpYGwK8zvIEMY923HuIePiZ6JSdPYYHwQ',
    appId: '1:795736931932:ios:d43527cb057d493ccb3099',
    messagingSenderId: '795736931932',
    projectId: 'ecomm-d3c12',
    storageBucket: 'ecomm-d3c12.appspot.com',
    iosBundleId: 'com.example.ecomm.RunnerTests',
  );
}