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
    apiKey: 'AIzaSyDbCB1JMS2mi_IhmqDs32a8-it_S2Oiras',
    appId: '1:994739621101:web:15a7a8c98b6832d0fd50e4',
    messagingSenderId: '994739621101',
    projectId: 'wedding-time-72b19',
    authDomain: 'wedding-time-72b19.firebaseapp.com',
    storageBucket: 'wedding-time-72b19.appspot.com',
    measurementId: 'G-YP3V3HHFFX',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAobaDhZBvrPojjoZd8nfw900fWYpE97DE',
    appId: '1:994739621101:android:59089c191bdb14dffd50e4',
    messagingSenderId: '994739621101',
    projectId: 'wedding-time-72b19',
    storageBucket: 'wedding-time-72b19.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAZWjsxU_yg6qViXpMmYscB4Hjd2U-XCU0',
    appId: '1:994739621101:ios:866a5bcfeebd64f3fd50e4',
    messagingSenderId: '994739621101',
    projectId: 'wedding-time-72b19',
    storageBucket: 'wedding-time-72b19.appspot.com',
    iosClientId: '994739621101-91ss2nf3kttev4od2a1m609d0ka4nm76.apps.googleusercontent.com',
    iosBundleId: 'com.example.weddingTime',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAZWjsxU_yg6qViXpMmYscB4Hjd2U-XCU0',
    appId: '1:994739621101:ios:866a5bcfeebd64f3fd50e4',
    messagingSenderId: '994739621101',
    projectId: 'wedding-time-72b19',
    storageBucket: 'wedding-time-72b19.appspot.com',
    iosClientId: '994739621101-91ss2nf3kttev4od2a1m609d0ka4nm76.apps.googleusercontent.com',
    iosBundleId: 'com.example.weddingTime',
  );
}