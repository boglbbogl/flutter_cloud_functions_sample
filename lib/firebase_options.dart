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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB3pjfALSrHqwIhUIXVXUZEyzbMVjIBSTw',
    appId: '1:478486000886:android:067ef401b24dfe5a05a8d7',
    messagingSenderId: '478486000886',
    projectId: 'flutter-cloud-functions-sample',
    storageBucket: 'flutter-cloud-functions-sample.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDbb3xp4-gSZW7W4qmjKKbhDzDdZxU6foA',
    appId: '1:478486000886:ios:627ab7c1f9ac3c9005a8d7',
    messagingSenderId: '478486000886',
    projectId: 'flutter-cloud-functions-sample',
    storageBucket: 'flutter-cloud-functions-sample.appspot.com',
    iosClientId: '478486000886-22l64d5d4qhddv8jdm1fpd0skg3r346n.apps.googleusercontent.com',
    iosBundleId: 'com.tyger.cloudFunctionsSample',
  );
}
