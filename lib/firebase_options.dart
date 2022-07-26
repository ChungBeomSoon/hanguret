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
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAza9oWFjZ7pSY53zu3vUTLIAAG436dhWg',
    appId: '1:344369404333:android:eed5c465c4dfc339fde924',
    messagingSenderId: '344369404333',
    projectId: 'hangeureut',
    storageBucket: 'hangeureut.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAsypGRfp7FsC2h2ukjULSFCv1-EN9wMeA',
    appId: '1:344369404333:ios:69abbd9264233eb5fde924',
    messagingSenderId: '344369404333',
    projectId: 'hangeureut',
    storageBucket: 'hangeureut.appspot.com',
    iosClientId: '344369404333-rfihdf8qmmg6sd5401mrjk1kpe6t7qpi.apps.googleusercontent.com',
    iosBundleId: 'com.hangeureut.hangeureut',
  );
}