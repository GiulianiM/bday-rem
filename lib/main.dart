import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'package:bday/auth/sign_in.dart';
import 'package:bday/activities/homepage.dart';

import 'notification/notification.dart';

FirebaseAppCheck appCheck = FirebaseAppCheck.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instance.activate(
    webRecaptchaSiteKey: 'recaptcha-v3-site-key',
  );

  //set-up notification
  //if is new, store the FCM token to the Firestore Database
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  signIn();
  setupNotification();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: BirthdaysList());
  }
}
