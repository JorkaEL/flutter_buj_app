

import 'package:flutter/material.dart';
import 'package:flutter_buj_app/model/habit.dart';

class TaskAddHabitMenuItem extends StatelessWidget {
  Habit habit;

  TaskAddHabitMenuItem({this.habit});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(5.0),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget> [
              Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(habit.libelle)),
              Container(
                color: habit.color,
                height: 20,
                width: 60,
              ),
            ]));
  }



}