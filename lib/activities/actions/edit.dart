import 'package:bday/ausiliars/person.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../gui/input_form.dart';

class EditBirth extends StatefulWidget {
  final Person person;
  const EditBirth({Key? key, required this.person}) : super(key: key);

  @override
  State<EditBirth> createState() => _EditBirthState();
}

class _EditBirthState extends State<EditBirth> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("${widget.person.name} ${widget.person.surname}"),
      ),
      body: InputForm(person: widget.person),
    );
  }
}


