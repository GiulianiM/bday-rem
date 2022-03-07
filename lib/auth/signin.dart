import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

void userSigniIn() {
  FirebaseAuth.instance
      .authStateChanges()
      .listen((User? user) async {
    if (user == null) {
      if (kDebugMode) {
        print('User is currently signed out!');
        await FirebaseAuth.instance.signInAnonymously();
      }
      if (kDebugMode) {
        print("User UID: ${user?.uid}");
      }
    } else {
      if (kDebugMode) {
        print('User is signed in!');
      }
      if (kDebugMode) {
        print("User UID: ${user.uid}");
      }
    }
  });
}
