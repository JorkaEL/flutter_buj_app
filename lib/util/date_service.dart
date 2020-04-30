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
  DateTime _selectedDate = DateTime(_now.year, _now.month, _now.day);

  DateTime get selectedDate => _selectedDate;


  set selectedDate(DateTime date) {
    _selectedDate = date;
  }


  List<DateTime> datesWeek(DateTime date) {
    int nbDay = date.weekday;
    List<DateTime> week = [date];

    for(int i=nbDay; i > firstDayWeek; i--) {
      week.add(date.subtract(Duration(days: nbDay - i + firstDayWeek)));
    }

    for(int i=nbDay; i < lastDayWeek; i++) {
      week.add(date.add(Duration(days: i - nbDay + firstDayWeek)));
    }

    week.sort((a,b) => a.weekday - b .weekday);

    return week;
  }

  formatDateText(DateTime date, String formatDate) {
    return DateFormat(formatDate).format(date);
  }
}