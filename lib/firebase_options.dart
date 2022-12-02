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
    apiKey: 'AIzaSyA6qCJAK4qe3wzzE0pCYdckC3xYNb7AtGo',
    appId: '1:206110671703:web:ca0f5d6c4449833bf93412',
    messagingSenderId: '206110671703',
    projectId: 'ditonton-tv',
    authDomain: 'ditonton-tv.firebaseapp.com',
    databaseURL: 'https://ditonton-tv-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'ditonton-tv.appspot.com',
    measurementId: 'G-11GE2VY5ND',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDU2rpOELhKjr7YS0KpAFIYZeulTw-q3YA',
    appId: '1:206110671703:android:490ef9ceb27257b6f93412',
    messagingSenderId: '206110671703',
    projectId: 'ditonton-tv',
    databaseURL: 'https://ditonton-tv-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'ditonton-tv.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD_iLMdsBvdKQOVBleMvdELU33vZWGVRfc',
    appId: '1:206110671703:ios:fa39d8c9e5a88a68f93412',
    messagingSenderId: '206110671703',
    projectId: 'ditonton-tv',
    databaseURL: 'https://ditonton-tv-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'ditonton-tv.appspot.com',
    iosClientId: '206110671703-sjfev189j1q9b0ere5jsn69badp9rfst.apps.googleusercontent.com',
    iosBundleId: 'com.dicoding.ditonton',
  );
}