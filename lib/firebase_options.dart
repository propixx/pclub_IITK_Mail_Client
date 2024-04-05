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
    apiKey: 'AIzaSyB9Tnr8PcM-IPeFPThfPW2g8X74eJN47ds',
    appId: '1:50778652393:web:243a10ec197669a7c97a78',
    messagingSenderId: '50778652393',
    projectId: 'email-mobile-application',
    authDomain: 'email-mobile-application.firebaseapp.com',
    storageBucket: 'email-mobile-application.appspot.com',
    measurementId: 'G-690VTFMBZM',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAtjaiJoKdWQHtGH7xkDuSmhFPvE6NczeQ',
    appId: '1:50778652393:android:5ef53e0d821b8a09c97a78',
    messagingSenderId: '50778652393',
    projectId: 'email-mobile-application',
    storageBucket: 'email-mobile-application.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDXGjPwXU5KgF5HD7Ocm6HprXVIgCBN7yg',
    appId: '1:50778652393:ios:2db52deeafb4d552c97a78',
    messagingSenderId: '50778652393',
    projectId: 'email-mobile-application',
    storageBucket: 'email-mobile-application.appspot.com',
    iosClientId: '50778652393-2f1s2pj382o9vqt7h4tfq285bharrmkd.apps.googleusercontent.com',
    iosBundleId: 'com.example.emailMobileApplication',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDXGjPwXU5KgF5HD7Ocm6HprXVIgCBN7yg',
    appId: '1:50778652393:ios:04fa0b7fa4d33488c97a78',
    messagingSenderId: '50778652393',
    projectId: 'email-mobile-application',
    storageBucket: 'email-mobile-application.appspot.com',
    iosClientId: '50778652393-c2tm5ooke0idtbgeitn0p7bf4riqmalb.apps.googleusercontent.com',
    iosBundleId: 'com.example.emailMobileApplication.RunnerTests',
  );
}