import 'package:bday/database/firestore_connection.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth = FirebaseAuth.instance;

 signIn() {
  FirebaseAuth.instance.authStateChanges().listen((User? user) async {

    //if the user is new
    if (user == null) {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInAnonymously();
      storeToken();
      print("New User UID: ${userCredential.user?.uid}");

    //if the user is already registered
    } else {
      print('User Not New');
    }

  });
}
