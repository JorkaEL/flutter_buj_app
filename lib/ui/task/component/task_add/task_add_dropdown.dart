import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_buj_app/util/routing_constants.dart';

typedef TaskAddCallBack(add);

class TaskAddDropdown extends StatefulWidget {
  TaskAddDropdown(
      list,
      choice,
      libelle,
      route,
      callback) :
        this.list = list,
        this.choice = choice,
        this.libelle = libelle,
        this.route = route,
        this.callback = callback;

  List<dynamic> list;
  dynamic choice;
  String libelle;
  String route;
  TaskAddCallBack callback;


  @override
  _TaskAddDropdown createState() => _TaskAddDropdown();
}


class _TaskAddDropdown extends State<TaskAddDropdown> {
  Widget build(BuildContext context) {
    return Flexible(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          DropdownButton (
             hint: Text(widget.libelle),
            value: widget.choice,
            onChanged: (val) {
              widget.callback(val);
            },
            items: widget.list.map((el) {
              return new DropdownMenuItem(
                  value: el,
                  child: Text(el.libelle),
              );
            }).toList(),
          ),
          IconButton(
            icon: Icon(Icons.add_circle),
            color: Colors.deepPurple,
            onPressed: () {
              Navigator.pushNamed(context, widget.route, arguments: TaskAddPageRoute);
            },
          ),
        ],
      ),
    );
  }
}