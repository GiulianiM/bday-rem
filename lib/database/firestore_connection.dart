import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> storeToken()async {
  var uid = FirebaseAuth.instance.currentUser?.uid;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  var token = await FirebaseMessaging.instance.getToken();

  users.add({"uid": uid.toString(), "token": token.toString()});
}