

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef DateCallBack(DateTime val);

class ButtonSelectDate extends StatelessWidget {
  final DateCallBack callback;
  DateTime selectedDate;

  ButtonSelectDate({this.callback, this.selectedDate});

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

  formatDateText() {
     String month = selectedDate.month > 9 ? selectedDate.month : '0${selectedDate.month}';

     return '${selectedDate.day}-$month-${selectedDate.year}';
  }

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child:Text(formatDateText()),
      onPressed: () {
        selectDate(context);
      },
    );
  }
}