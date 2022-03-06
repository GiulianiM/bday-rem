import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth = FirebaseAuth.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );


  //check if user is already signed-in
  userSigniIn();




  runApp(const MyApp());
}

void userSigniIn() {
  FirebaseAuth.instance
      .authStateChanges()
      .listen((User? user) async {
    if (user == null) {
      if (kDebugMode) {
        print('User is currently signed out!');
      }
      UserCredential userCredential = await FirebaseAuth.instance.signInAnonymously();
      if (kDebugMode) {
        print(user?.uid);
      }
    } else {
      if (kDebugMode) {
        print('User is signed in!');
      }
      if (kDebugMode) {
        print(user.uid);
      }
    }
  });
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}


