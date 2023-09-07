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
    apiKey: 'AIzaSyAI0sjdIrcXU90GkrwpUIljrh6jMtBuYzU',
    appId: '1:410792468487:web:b7e2bec645c755f44dcaa2',
    messagingSenderId: '410792468487',
    projectId: 'taxi-getgo',
    authDomain: 'taxi-getgo.firebaseapp.com',
    databaseURL: 'https://taxi-getgo-default-rtdb.firebaseio.com',
    storageBucket: 'taxi-getgo.appspot.com',
    measurementId: 'G-07Y2JH5N4Q',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCzEHzXnfWZWbbygrpf69RMTaiBIbo9bRA',
    appId: '1:410792468487:android:228af4f7041602d54dcaa2',
    messagingSenderId: '410792468487',
    projectId: 'taxi-getgo',
    databaseURL: 'https://taxi-getgo-default-rtdb.firebaseio.com',
    storageBucket: 'taxi-getgo.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyARdqHIO0tBroxEU1XpT0VrrizWc8-pCSE',
    appId: '1:410792468487:ios:5bd132b900b194a14dcaa2',
    messagingSenderId: '410792468487',
    projectId: 'taxi-getgo',
    databaseURL: 'https://taxi-getgo-default-rtdb.firebaseio.com',
    storageBucket: 'taxi-getgo.appspot.com',
    androidClientId: '410792468487-d7gem8hkpdibdtksckmbkc6rrtgjqruk.apps.googleusercontent.com',
    iosClientId: '410792468487-247t6kptfiahsn1lpptf1itvak15r7kf.apps.googleusercontent.com',
    iosBundleId: 'com.example.clientappTaxiGetgo',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyARdqHIO0tBroxEU1XpT0VrrizWc8-pCSE',
    appId: '1:410792468487:ios:5bd132b900b194a14dcaa2',
    messagingSenderId: '410792468487',
    projectId: 'taxi-getgo',
    databaseURL: 'https://taxi-getgo-default-rtdb.firebaseio.com',
    storageBucket: 'taxi-getgo.appspot.com',
    androidClientId: '410792468487-d7gem8hkpdibdtksckmbkc6rrtgjqruk.apps.googleusercontent.com',
    iosClientId: '410792468487-247t6kptfiahsn1lpptf1itvak15r7kf.apps.googleusercontent.com',
    iosBundleId: 'com.example.clientappTaxiGetgo',
  );
}
