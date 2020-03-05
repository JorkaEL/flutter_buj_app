

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_buj_app/i18n_localizations.dart';
import 'package:flutter_buj_app/ui/component/button_select_date.dart';

typedef DateCallBack(DateTime val);

class TaskHeader extends StatelessWidget {
  final DateCallBack callback;
  DateTime selectedDate;
  TaskHeader({this.callback, this.selectedDate});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          ButtonSelectDate(callback: callback, selectedDate: selectedDate),
          RaisedButton(
            child: Text(I18nLocalizations.translate(context, 'task.week')),
          ),
          RaisedButton(
            child: Text(I18nLocalizations.translate(context, 'task.month')),
          ),
        ],
      ),
    );
  }
}