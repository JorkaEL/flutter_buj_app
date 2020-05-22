import 'package:flutter/material.dart';
import 'package:flutter_buj_app/model/day_week.dart';
import 'package:flutter_buj_app/ui/task/component/task_day_week.component.dart';

typedef NumCallBack(num id);

class TaskDayWeekList extends StatelessWidget {
  final NumCallBack callback;
  final List<DayWeek> listDayWeek;

  TaskDayWeekList({this.callback, this.listDayWeek});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        separatorBuilder: (context, index) => Divider(),
        itemCount: listDayWeek.length,
        itemBuilder: (context, index) =>
            TaskDayWeek(callback: callback, day: listDayWeek[index])
    );
  }
}
