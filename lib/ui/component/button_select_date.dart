import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_buj_app/model/button_select_date.dart';
import 'package:intl/intl.dart';

typedef DateCallBack(ButtonSelectDateModel val);

class ButtonSelectDate extends StatelessWidget {
  final DateCallBack callback;
  ButtonSelectDateModel selectedDate = ButtonSelectDateModel();
  String formatDate;
  DateTime firstDate;
  DateTime lastDate;

  String defaultText;
  var typeDate;

  ButtonSelectDateModel responseBack;

  ButtonSelectDate({@required this.callback, @required this.selectedDate, @required this.defaultText, @required this.typeDate, this.firstDate, this.lastDate, this.formatDate });

  selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: this.selectedDate.date,
        firstDate: this.firstDate != null ? this.firstDate : DateTime(1900),
        lastDate: this.lastDate != null ? this.lastDate : DateTime(2100));
    if (picked != null) {
      selectedDate.date = DateTime(picked.year, picked.month, picked.day);
      selectedDate.typeDate = typeDate;
      callback(selectedDate);
    }
  }


  displayText() {
    if(typeDate == selectedDate.typeDate) {
      return formatDateText();
    }

    return defaultText;
  }

  formatDateText() {
    final format = this.formatDate != null ? this.formatDate : 'yyyy-MM-dd';

    return DateFormat(format).format(selectedDate.date);
  }

  @override
  Widget build(BuildContext context) {
    this.selectedDate.date = this.selectedDate.date != null ? this.selectedDate.date : DateTime.now();
    return RaisedButton(
      child: Text(displayText()),
      onPressed: () {
        selectDate(context);
      },
    );
  }
}
