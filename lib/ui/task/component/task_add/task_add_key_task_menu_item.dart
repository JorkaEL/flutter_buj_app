

import 'package:flutter/material.dart';
import 'package:flutter_buj_app/model/key_task.dart';

class TaskAddKeyTaskMenuItem extends StatelessWidget {
  KeyTask keyTask;

  TaskAddKeyTaskMenuItem({@required this.keyTask});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(5.0),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget> [
              Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(keyTask.libelle)),
              Container(
                height: 20,
                width: 60,
                child: Icon(keyTask.icon),
              ),
            ]));
  }



}