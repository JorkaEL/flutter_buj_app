

import 'package:flutter/cupertino.dart';
import 'package:flutter_buj_app/model/task.dart';
import 'package:flutter_buj_app/ui/task/component/task_header.component.dart';
import 'package:flutter_buj_app/ui/task/component/task_list.component.dart';
import 'package:flutter_buj_app/util/buj_service.dart';

class TaskBody extends StatefulWidget {
  TaskBody({
    Key key
}) : super(key: key);

  @override
  _TaskBodyState createState() => _TaskBodyState();
}

class _TaskBodyState extends State {

  Future<List<Task>> myTask;
  var tasks = [];
  static DateTime now = DateTime.now();
  DateTime _selectedDate = DateTime(now.year, now.month, now.day);

  filterDay(DateTime day) {
    setState(() {
      _selectedDate = day;
      this.myTask = BujService().getTaskByDay(day);
    });
  }

  @override
  void initState() {
    super.initState();
    this.myTask = BujService().getTaskByDay(_selectedDate);
  }

  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
          Flexible(
              child: TaskHeader(
                  callback: (val) => filterDay(val),
                  selectedDate: _selectedDate
              )
          ),
          Flexible(
              child: TaskList(listTasks: myTask)
          ),
        ]);
  }
}