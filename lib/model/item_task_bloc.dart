
import 'package:flutter_buj_app/model/day_week.dart';
import 'package:flutter_buj_app/model/task.dart';

class ItemTaskBloc {
  bool isWeek;

  List<Task> dayTask;

  List<DayWeek> weekTask;

  ItemTaskBloc();
}