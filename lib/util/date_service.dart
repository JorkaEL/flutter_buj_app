import 'package:flutter_buj_app/model/button_select_date.dart';
import 'package:intl/intl.dart';

enum typeDate {
  day,
  week,
  month
}

class DateService {
  DateService._internal();

  static final DateService _dateService = DateService._internal();

  factory DateService() {
    return _dateService;
  }

  static DateTime _now = DateTime.now();
  final int firstDayWeek = 1;
  final int lastDayWeek = 7;
  ButtonSelectDateModel _selectedDate = ButtonSelectDateModel(date: DateTime(_now.year, _now.month, _now.day), typeDate: typeDate.day);

  ButtonSelectDateModel get selectedDate => _selectedDate;


  set selectedDate(ButtonSelectDateModel date) {
    _selectedDate = date;
  }


  List<DateTime> datesWeek(DateTime date) {
    DateTime monday = date.subtract(Duration(days: date.weekday - 1));
    List<DateTime> week = [monday];

    for(int i=firstDayWeek; i < lastDayWeek; i++) {
      week.add(monday.add(Duration(days: i)));
    }

    return week;
  }

  formatDateText(DateTime date, String formatDate) {
    return DateFormat(formatDate).format(date);
  }
}