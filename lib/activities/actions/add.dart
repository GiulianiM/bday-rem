import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../gui/input_form.dart';

class AddBirth extends StatefulWidget {
  const AddBirth({Key? key}) : super(key: key);

  @override
  State<AddBirth> createState() => _AddBirthState();
}

class _AddBirthState extends State<AddBirth> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Nuovo Compleanno"),
      ),
      body: const InputForm(),
    );
  }
}
