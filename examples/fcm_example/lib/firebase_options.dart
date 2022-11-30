// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members

import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;
import 'package:v_chat_firebase_fcm/v_chat_firebase_fcm.dart';

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
    apiKey: 'AIzaSyDqYkVdzjKcDE8l_PuSKFGcMlTRaS4IZS8',
    appId: '1:706118575283:web:3154d5b41efc5a2fb8bcc6',
    messagingSenderId: '706118575283',
    projectId: 'v-chat-sdk-v2',
    authDomain: 'v-chat-sdk-v2.firebaseapp.com',
    storageBucket: 'v-chat-sdk-v2.appspot.com',
    measurementId: 'G-19SPJVFG4G',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBFRPlt74bHykCcSukkeAU5gLRiASR6mTk',
    appId: '1:706118575283:android:ed003642e230f592b8bcc6',
    messagingSenderId: '706118575283',
    projectId: 'v-chat-sdk-v2',
    storageBucket: 'v-chat-sdk-v2.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAPF9x4otICpjEYAOdGeHJWyxiZHlSExpI',
    appId: '1:706118575283:ios:74f725e3cf625ab5b8bcc6',
    messagingSenderId: '706118575283',
    projectId: 'v-chat-sdk-v2',
    storageBucket: 'v-chat-sdk-v2.appspot.com',
    iosClientId:
        '706118575283-hkf122thbcipbvcmcvng3gmglr0toorc.apps.googleusercontent.com',
    iosBundleId: 'com.example.fcmExample',
  );
}
