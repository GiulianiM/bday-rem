import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../ausiliars/person.dart';
import '../../database/firestore_handler.dart';

class InputForm extends StatefulWidget {
  final Person? person;

  const InputForm({Key? key, this.person}) : super(key: key);

  @override
  State<InputForm> createState() => _InputFormState();
}

class _InputFormState extends State<InputForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _dateInput = TextEditingController();
  final TextEditingController _nameInput = TextEditingController();
  final TextEditingController _surnameInput = TextEditingController();
  final TextEditingController _nicknameInput = TextEditingController();
  bool _isEditing = false;

  @override
  void initState() {
    if (widget.person != null) {
      _isEditing = true;
      _dateInput.text = widget.person!.birth;
      _nameInput.text = widget.person!.name;
      _surnameInput.text = widget.person!.surname;
      //check the nullity of parameter
      widget.person!.nickname == null ? _nicknameInput.text == "" : _nicknameInput.text = widget.person!.nickname!;
    }
    print("isEditing : $_isEditing");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextFormField(
            controller: _nameInput,
            decoration: const InputDecoration(
              icon: Icon(Icons.person),
              labelText: 'Name',
            ),
            validator: (value) {
              return _isTextValid(value, false);
            },
          ),
          TextFormField(
            controller: _surnameInput,
            decoration: const InputDecoration(
              icon: Icon(Icons.person),
              labelText: 'Surname',
            ),
            validator: (value) {
              return _isTextValid(value, false);
            },
          ),
          TextFormField(
            controller: _nicknameInput,
            decoration: const InputDecoration(
              icon: Icon(Icons.person),
              labelText: 'Nickname',
            ),
            validator: (value) {
              return _isTextValid(value, true);
            },
          ),
          TextFormField(
            controller: _dateInput,
            decoration: const InputDecoration(
                icon: Icon(Icons.calendar_today), //icon of text field
                labelText: "Enter Date" //label text of field
                ),
            readOnly: true,
            onTap: () async {
              DateTime? pickDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1940),
                  lastDate: DateTime.now());

              if (pickDate != null) {
                String formattedDate = DateFormat.yMMMd().format(pickDate);
                setState(() {
                  _dateInput.text =
                      formattedDate; //set output date to TextField value.
                });
              }
            },
            validator: (value) {
              return _isDateValid(value);
            },
          ),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                // print(_dateInput.text);
                // print(_nameInput.text);
                // print(_surnameInput.text);
                // print(_nicknameInput.text);

                if (_isEditing) {
                  Person editPerson = Person.updateFromForm(
                    name: _nameInput.text,
                    surname: _surnameInput.text,
                    birth: _dateInput.text,
                    nickname: _nicknameInput.text,
                  );
                  await isBirthdayEdited(editPerson);
                  const snackBar = SnackBar(content: Text('Salvato!'));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  Navigator.pop(context);
                } else {
                  Person newPerson = Person(
                      name: _nameInput.text,
                      surname: _surnameInput.text,
                      birth: _dateInput.text,
                      nickname: _nicknameInput.text,
                      uid: FirebaseAuth.instance.currentUser!.uid);
                  await isBirthdayAdded(newPerson);
                  const snackBar = SnackBar(content: Text('Salvato!'));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  Navigator.pop(context);
                }
              }
            },
            child: const Text('Invia'),
          ),
        ],
      ),
    );
  }

  _isDateValid(value) {
    if (value == null || value.isEmpty) {
      return "Inserisci data!";
    }
    return null;
  }

  _isTextValid(value, notReq) {
    RegExp _numeric = RegExp(r'-?[0-9]+');

    if ((value == null || value.isEmpty) && !notReq) {
      return "Inserisci del testo!";
    }

    //this check have the problem of letters next to numbers
    // if(num.tryParse(value) != null){
    //   return "Non sono ammessi numeri!";
    // }

    if (_numeric.hasMatch(value)) {
      return "Non sono ammessi numeri!";
    }
    return null;
  }
}
