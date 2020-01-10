import 'package:flutter_buj_app/model/key_task.dart';
import 'package:flutter_buj_app/model/habit.dart';

class Task {

  num id;
  String libelle;
  KeyTask key;
  Habit habit;
  bool state;
  String date;

  Task({this.id, this.libelle, this.key, this.habit, this.state, this.date});

}