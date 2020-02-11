import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_buj_app/model/task.dart';
import 'package:flutter_buj_app/model/habit.dart';
import 'package:flutter_buj_app/model/key_task.dart';
import 'package:flutter_buj_app/ui/component/button_select_date.dart';
import 'package:flutter_buj_app/ui/task/component/task_add/task_add_dropdown.dart';
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

  static DateTime now = DateTime.now();
  DateTime _selectedDate = DateTime(now.year, now.month, now.day);


  final libelle = TextEditingController();

  KeyTask keyChoice;
  List<KeyTask> keyList;

  Habit habitChoice;
  List<Habit> habitList;

  changeDay(DateTime day) {
    setState(() {
      _selectedDate = day;
    });
  }

  changeKeyTask(KeyTask keyTask) {
    setState(() {
      keyChoice = keyTask;
    });
  }

  changeHabit(Habit hab) {
    setState(() {
      habitChoice = hab;
    });
  }

  @override
  void initState() {
    super.initState();
    this.habitList = BujService().getHabits();
    this.keyList = BujService().getKeyTask();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pushNamed(context, TaskPageRoute)
          ),
          backgroundColor: Colors.deepPurple,
          centerTitle: true,
          title: Text('Ajout de tache')
      ),
        body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsetsDirectional.only(start: 15.0, top: 5.0, end: 15.0),
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
              ButtonSelectDate(callback: (day) => changeDay(day), selectedDate: _selectedDate),
              TaskAddDropdown(keyList, keyChoice, 'Sélectionner votre clée', KeyTaskAddPageRoute, (keyTask) => changeKeyTask(keyTask)),
              TaskAddDropdown(habitList, habitChoice, 'Sélectionner votre habitude', HabitAddPageRoute, (hab) => changeHabit(hab)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    color: Colors.deepPurple,
                    textColor: Colors.white,
                    onPressed: () {
                      // Validate will return true if the form is valid, or false if
                      // the form is invalid.
                      if (_formKey.currentState.validate() && this.keyChoice != null && this.habitChoice != null) {
                        // Process data
                        var t = Task(libelle: this.libelle.text, date: this._selectedDate, id: 0, state: false, habit: this.habitChoice, key: this.keyChoice );
                        BujService().addTask(t);
                        Navigator.pushNamed(context, TaskPageRoute);
                      }
                    },
                    child: Text('Valider'),
                ),]
              ),
            ],
          )
        )// Build this out in the next steps.
      ),
    );
  }

}