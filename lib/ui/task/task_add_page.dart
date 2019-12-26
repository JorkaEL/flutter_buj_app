import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_buj_app/model/task.dart';
import 'package:flutter_buj_app/model/tracker.dart';
import 'package:flutter_buj_app/model/key_task.dart';
import 'package:flutter_buj_app/util/buj_service.dart';
import 'package:flutter_buj_app/util/routing_constants.dart';
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

  KeyTask keyChoice;
  List<KeyTask> keyList = BujService().getKeyTask();

  Tracker trackerChoice;
  List<Tracker> trackerList = BujService().getTrackers();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.purple,
          centerTitle: true,
          title: Text('Ajout de tache')
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
              decoration: InputDecoration(
                hintText: 'Date de la tache'
              ),
              format: format,
              controller: this.date,
              validator: (value) {
                // logger.v(value);
                if(value == null) {
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
            Flexible(
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    DropdownButton<KeyTask>(
                      hint: Text('Selectionné votre cléé'),
                      value: keyChoice,
                      onChanged: (KeyTask key) {
                        setState(() {
                          keyChoice = key;
                        });
                      },
                      items: keyList.map((KeyTask key) {
                        return new DropdownMenuItem<KeyTask>(
                          value: key,
                          child: Text(key.libelle),
                        );
                      }).toList(),
                    ),
                    IconButton(
                      icon: Icon(Icons.add_circle),
                      tooltip: 'Ajouter une clée',
                      onPressed: () {
                       Navigator.pushNamed(context, KeyTaskAddPageRoute);
                      },
                    ),
                  ],
              ),
            ),
            Flexible(
              child: Row(
                children: <Widget>[
                  DropdownButton<Tracker>(
                    hint: Text('Selectionné votre tracker'),
                    value: trackerChoice,
                    onChanged: (Tracker tra) {
                      setState(() {
                        trackerChoice = tra;
                      });
                    },
                    items: trackerList.map((Tracker tra) {
                      return new DropdownMenuItem<Tracker>(
                        value: tra,
                        child: Text(tra.libelle),
                      );
                    }).toList(),
                  ),
                  IconButton(
                    icon: Icon(Icons.add_circle),
                    tooltip: 'Ajouter un tracker',
                    onPressed: () {
                      Navigator.pushNamed(context, TrackerAddPageRoute);
                    },
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.all(16.0),
              child: RaisedButton(
                onPressed: () {
                  // Validate will return true if the form is valid, or false if
                  // the form is invalid.
                  if (_formKey.currentState.validate() && this.keyChoice != null && this.trackerChoice != null) {
                    // Process data
                    var t = Task(libelle: this.libelle.text, date: this.date.text, id: 0, state: false, tracker: this.trackerChoice, key: this.keyChoice );
                    BujService().addTask(t);
                    Navigator.pushNamed(context, TaskPageRoute);
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