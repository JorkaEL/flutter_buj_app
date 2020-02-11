

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_buj_app/ui/component/button_select_date.dart';

typedef DateCallBack(DateTime val);

class TaskHeader extends StatelessWidget {
  final DateCallBack callback;
  DateTime selectedDate;
  TaskHeader({this.callback, this.selectedDate});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Flexible(
          child: ButtonSelectDate(callback: callback, selectedDate: selectedDate)
        ),
        Flexible(child: RaisedButton(
          child: Text('Semaine'),
        )),
        Flexible( child: RaisedButton(
          child: Text('Mois'),
        )),
      ],
    );
  }
}