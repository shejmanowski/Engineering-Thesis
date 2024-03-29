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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyC85H-BD-TuRXQNfBh6v__-GzpPVMaR7_Y',
    appId: '1:948729763405:web:6ee38ab36e9f8edb05ae04',
    messagingSenderId: '948729763405',
    projectId: 'good-mentality',
    authDomain: 'good-mentality.firebaseapp.com',
    storageBucket: 'good-mentality.appspot.com',
    measurementId: 'G-0C2KJ2QS8W',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCtheNiEXXgnV69KBVvsrhIxyW5NZoaD3g',
    appId: '1:948729763405:android:cfdb53e1ebac195805ae04',
    messagingSenderId: '948729763405',
    projectId: 'good-mentality',
    storageBucket: 'good-mentality.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBf76MfhbtcLiZ6677u2AEVaoyAcAM7i9Q',
    appId: '1:948729763405:ios:1cd9e4d74328e92905ae04',
    messagingSenderId: '948729763405',
    projectId: 'good-mentality',
    storageBucket: 'good-mentality.appspot.com',
    iosBundleId: 'com.example.goodMentality',
  );
}
