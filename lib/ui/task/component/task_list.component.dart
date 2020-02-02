

import 'package:flutter/material.dart';
import 'package:flutter_buj_app/model/task.dart';
import 'package:flutter_buj_app/util/buj_service.dart';

class TaskList extends StatefulWidget {
  TaskList({
    Key key,
    @required this.listTasks
  }) : super(key: key);

  final Future<List<Task>> listTasks;
  var tasks = [];

  @override
  _TaskListState createState() {
    return new _TaskListState();
  }
}

class _TaskListState extends State<TaskList> {
  Widget build(BuildContext context) {
    return FutureBuilder<List<Task>>(
      future: widget.listTasks,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text('An error occurred'),
          );
        } else {
          widget.tasks = [];
          if(snapshot.hasData) {
            widget.tasks = snapshot.data;
          }
          return ListView.separated(
            scrollDirection: Axis.vertical,
            separatorBuilder: (context, index) => Divider(),
            itemCount: widget.tasks.length,
            itemBuilder: (context, index) => ListTile(
              leading: IconButton(
                icon: Icon(widget.tasks[index].state ? Icons.check_box : Icons.check_box_outline_blank),
                onPressed: () {
                  setState(() {
                    BujService().updatStateTask(widget.tasks[index].id);
                    widget.tasks[index].state = !widget.tasks[index].state;
                  });
                },
              ),
              title:  Text(widget.tasks[index].libelle),
              trailing: Icon(widget.tasks[index].key.icon, color: widget.tasks[index].habit.color),
            ),
          );
        }
      },
    );
  }
}