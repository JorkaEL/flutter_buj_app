import 'package:flutter_buj_app/ui/task/component/task_header.component.dart';
import 'package:flutter_buj_app/ui/task/component/task_list.component.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_buj_app/model/task.dart';
import 'package:flutter_buj_app/ui/component/side_menu.component.dart';
import 'package:flutter_buj_app/util/buj_service.dart';
import 'package:flutter_buj_app/util/routing_constants.dart';
import 'package:logger/logger.dart';

class TaskPage extends StatefulWidget {

  @override
  _TaskPageState createState() => _TaskPageState();
}


class _TaskPageState extends State {

  Future<List<Task>> myTask;
  var tasks = [];
  static DateTime now = DateTime.now();
  DateTime _selectedDate = DateTime(now.year, now.month, now.day);

  final logger = Logger();

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

  @override build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          centerTitle: true,
          title: Text('Taches')
        ),
      drawer: SideMenu(),
      body: Column(
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

        ]),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        onPressed: () {
          Navigator.pushNamed(context, TaskAddPageRoute);
        },
        child: Icon(Icons.add),
      )
    );
  }
}