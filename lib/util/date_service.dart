
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
  DateTime _selectedDate = DateTime(_now.year, _now.month, _now.day);

  DateTime get selectedDate => _selectedDate;


  set selectedDate(DateTime date) {
    _selectedDate = date;
  }
}