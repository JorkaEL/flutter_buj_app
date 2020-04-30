import 'package:flutter/material.dart';
import 'package:flutter_buj_app/model/task.dart';

typedef NumCallBack(num id);

class TaskList extends StatelessWidget {
  final NumCallBack callback;
  final List<Task> listTasks;

  TaskList({this.callback, this.listTasks});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      separatorBuilder: (context, index) => Divider(),
      itemCount: listTasks.length,
      itemBuilder: (context, index) => ListTile(
        leading: IconButton(
          icon: Icon(listTasks[index].state
              ? Icons.check_box
              : Icons.check_box_outline_blank),
          onPressed: () {
            callback(listTasks[index].id);
          },
        ),
        title: Text(listTasks[index].libelle),
        trailing: Icon(listTasks[index].key.icon, color: listTasks[index].habit.color),
        onTap: () {
          callback(listTasks[index].id);
        },
      ),
    );
  }
}
