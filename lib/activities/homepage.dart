import 'package:bday/activities/actions/edit.dart';
import 'package:bday/ausiliars/person.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'actions/add.dart';

class BirthdaysList extends StatefulWidget {
  const BirthdaysList({Key? key}) : super(key: key);

  @override
  State<BirthdaysList> createState() => _BirthdaysListState();
}

class _BirthdaysListState extends State<BirthdaysList> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Birthdays"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddBirth()),
          )
        },
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection(
                'birthdays/${FirebaseAuth.instance.currentUser?.uid}/list')
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView(
            shrinkWrap: true,
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Person person = Person.fromDocSnap(doc: document);
              return Card(
                child: InkWell(
                  splashColor: Colors.blue.withAlpha(30),
                  child: Column(children: <Widget>[
                    ListTile(
                      title: Text(person.name),
                    ),
                  ]),
                  onTap: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditBirth(person: person)),
                    )
                  },
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
