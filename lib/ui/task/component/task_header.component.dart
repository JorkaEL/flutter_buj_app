

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef DateCallBack(DateTime val);

class TaskHeader extends StatelessWidget {
  final DateCallBack callback;
  DateTime selectedDate;
  TaskHeader({this.callback, this.selectedDate});



  selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1900),
        lastDate: DateTime(2100)
    );

    if(picked != null) {
      selectedDate = DateTime(picked.year,picked.month, picked.day);
      callback(selectedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Flexible(
          child: RaisedButton(
            child:Text('${selectedDate.day}-${selectedDate.month}-${selectedDate.year}'),
            onPressed: () {
              selectDate(context);
            },
          ),
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