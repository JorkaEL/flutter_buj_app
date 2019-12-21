import 'dart:developer';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

class TaskAddPage extends StatefulWidget {

  @override
  _TaskAddState createState() => _TaskAddState();
}


class _TaskAddState extends State<TaskAddPage> {


  final logger = Logger();
  final _formKey = GlobalKey<FormState>();
  final format = DateFormat("yyyy-MM-dd");

  final libelle = TextEditingController();
  final date = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.purple,
          centerTitle: true,
          title: Text('Taches')
      ),
        body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
              TextFormField(
                controller: this.libelle,
                decoration: const InputDecoration(
                  hintText: 'Libéller de la tache',
                ),
              // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value.isEmpty) {
                    return 'SVP rentrer un libéller pour la tache';
                  }
                  return null;
                },
              ),
            DateTimeField(
              format: format,
              controller: this.date,
              validator: (value) {
                if(value != null) {
                  return 'SVP choisiez une date';
                }
                return null;
              },
              onShowPicker: (context, currentValue) async {
                final date = await showDatePicker(
                    context: context,
                    firstDate: DateTime(1900),
                    initialDate: currentValue ?? DateTime.now(),
                    lastDate: DateTime(2100));

                return date;
              },
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: RaisedButton(
                onPressed: () {
                  // Validate will return true if the form is valid, or false if
                  // the form is invalid.
                  logger.v('value = ' + this.libelle.text + ' date = '+ this.date.text);
                  if (_formKey.currentState.validate()) {
                    // Process data
                  }
                },
                child: Text('Valider'),
              ),
            ),
          ],
        )// Build this out in the next steps.
      ),
    );
  }

}