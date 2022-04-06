import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class Person {
  String name;
  String surname;
  String? nickname;
  String birth;
  String? docHash;
  String? uid;

  Person({
    required this.name,
    required this.surname,
    required this.birth,
    this.nickname,
    required this.uid,
  }) {
    docHash = _genHash();
  }

  Person.updateFromForm({
    required this.name,
    required this.surname,
    required this.birth,
    this.nickname,
  });

  Person.fromDocSnap({required DocumentSnapshot doc})
      : name = doc.get("name"),
        surname = doc.get("surname"),
        birth = doc.get("birth"),
        nickname = doc.get("nickname"),
        docHash = doc.get("docHash"),
        uid = doc.get("uid");

  @override
  String toString() {
    return 'Person{name: $name, surname: $surname, nickname: $nickname, birth: $birth, docHash: $docHash, uid: $uid}';
  }

  _genHash() {
    return const Uuid().v1();
  }
}
