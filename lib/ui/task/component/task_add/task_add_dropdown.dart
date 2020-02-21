import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_buj_app/ui/task/component/task_add/task_add_habit_menu_item.dart';
import 'package:flutter_buj_app/ui/task/component/task_add/task_add_key_task_menu_item.dart';

typedef TaskAddCallBack(add);

class TaskAddDropdown extends StatefulWidget {
  TaskAddDropdown(list, choice, libelle, widgetKey, callback)
      : this.list = list,
        this.choice = choice,
        this.libelle = libelle,
        this.widgetKey = widgetKey,
        this.callback = callback;

  List<dynamic> list;
  dynamic choice;
  String libelle;
  String widgetKey;
  TaskAddCallBack callback;

  @override
  _TaskAddDropdown createState() => _TaskAddDropdown();
}

class _TaskAddDropdown extends State<TaskAddDropdown> {
  Widget build(BuildContext context) {
    return DropdownButton(
      hint: Padding(
        padding: EdgeInsets.only(left: 10.0),
        child: Text(widget.libelle),
      ),
      value: widget.choice,
      onChanged: (val) {
        widget.callback(val);
      },
      items: widget.list.map((el) {
        return new DropdownMenuItem(
          value: el,
          child: _menuItemWidget(widget.widgetKey, el),
        );
      }).toList(),
    );
  }
}


Widget _menuItemWidget(String key, dynamic element) {
  switch(key) {
    case 'habit': return TaskAddHabitMenuItem(habit: element);
    break;
    case 'keyTask': return TaskAddKeyTaskMenuItem(keyTask: element);
  }
}
