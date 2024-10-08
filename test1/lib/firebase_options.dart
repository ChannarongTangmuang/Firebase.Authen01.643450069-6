// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyCmDOV3IlWC5ADds0_0Gm92IiroS6YkX90',
    appId: '1:522337227285:web:59c95808028759748d741c',
    messagingSenderId: '522337227285',
    projectId: 'flutter-to-do-lap',
    authDomain: 'flutter-to-do-lap.firebaseapp.com',
    storageBucket: 'flutter-to-do-lap.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDz4MMpTqaxBuQnmPZYm8NMaXiR_mHJChA',
    appId: '1:522337227285:android:b835cc825355eda18d741c',
    messagingSenderId: '522337227285',
    projectId: 'flutter-to-do-lap',
    storageBucket: 'flutter-to-do-lap.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCC97UeDLHyaJjk1kA5-rRYTKSqbUuSFeo',
    appId: '1:522337227285:ios:521fcd4d1c0537638d741c',
    messagingSenderId: '522337227285',
    projectId: 'flutter-to-do-lap',
    storageBucket: 'flutter-to-do-lap.appspot.com',
    iosBundleId: 'com.example.test1',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCC97UeDLHyaJjk1kA5-rRYTKSqbUuSFeo',
    appId: '1:522337227285:ios:521fcd4d1c0537638d741c',
    messagingSenderId: '522337227285',
    projectId: 'flutter-to-do-lap',
    storageBucket: 'flutter-to-do-lap.appspot.com',
    iosBundleId: 'com.example.test1',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCmDOV3IlWC5ADds0_0Gm92IiroS6YkX90',
    appId: '1:522337227285:web:ffc629c0356d9d908d741c',
    messagingSenderId: '522337227285',
    projectId: 'flutter-to-do-lap',
    authDomain: 'flutter-to-do-lap.firebaseapp.com',
    storageBucket: 'flutter-to-do-lap.appspot.com',
  );
}
