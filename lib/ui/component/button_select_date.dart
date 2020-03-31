import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

typedef DateCallBack(DateTime val);

class ButtonSelectDate extends StatelessWidget {
  final DateCallBack callback;
  DateTime selectedDate;
  String formatDate;
  DateTime firstDate;
  DateTime lastDate;

  ButtonSelectDate({@required this.callback, @required this.selectedDate, this.firstDate, this.lastDate, this.formatDate });

  selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: this.selectedDate,
        firstDate: this.firstDate != null ? this.firstDate : DateTime(1900),
        lastDate: this.lastDate != null ? this.lastDate : DateTime(2100));
    if (picked != null) {
      selectedDate = DateTime(picked.year, picked.month, picked.day);
      callback(selectedDate);
    }
  }

  formatDateText() {
    final format = this.formatDate != null ? this.formatDate : 'yyyy-MM-dd';

    return DateFormat(format).format(selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    this.selectedDate = this.selectedDate != null ? this.selectedDate : DateTime.now();
    return RaisedButton(
      child: Text(formatDateText()),
      onPressed: () {
        selectDate(context);
      },
    );
  }
}
