import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../ausiliars/person.dart';

bool _itsOk = false;

addBirthday(Person person) {
  isBirthdayAdded(person);
  return _itsOk;
}

Future<void> isBirthdayAdded(Person person) async {
  CollectionReference _path = FirebaseFirestore.instance
      .collection('birthdays/${FirebaseAuth.instance.currentUser?.uid}/list');

  print(person.docHash);
  return _path.doc(person.docHash).set(
    {
      'name': person.name,
      'surname': person.surname,
      'nickname': person.nickname,
      'birth': person.birth,
      'docHash': person.docHash,
      'uid': person.uid,
    },
  ).then((value) {
    _itsOk = true;
  }).catchError((error) {
    _itsOk = false;
    print(error);
  });
}

editBirthday(Person person) {
  isBirthdayEdited(person);
  return _itsOk;
}

Future<void> isBirthdayEdited(Person person) async {
  CollectionReference _path = FirebaseFirestore.instance
      .collection('birthdays/${FirebaseAuth.instance.currentUser?.uid}/list');
  print(person.docHash);
  return _path.doc(person.docHash).update(
    {
      'name': person.name,
      'surname': person.surname,
      'nickname': person.nickname,
      'birth': person.birth,
    },
  ).then((value) {
    _itsOk = true;
  }).catchError((error) {
    _itsOk = false;
    print(error);
  });
}
