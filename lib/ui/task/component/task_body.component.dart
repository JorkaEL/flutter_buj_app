import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_buj_app/model/task.dart';
import 'package:flutter_buj_app/ui/task/bloc/task_bloc.dart';
import 'package:flutter_buj_app/ui/task/component/task_header.component.dart';
import 'package:flutter_buj_app/ui/task/component/task_list.component.dart';
import 'package:i18n_localizations/i18n_localizations.dart';

class TaskBody extends StatefulWidget {
  TaskBody({Key key}) : super(key: key);

  @override
  _TaskBodyState createState() => _TaskBodyState();
}

class _TaskBodyState extends State<TaskBody> {
  final _bloc = TaskBloc();

  @override
  void initState() {
    super.initState();
    _bloc.updateList();
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Flexible(
          child: StreamBuilder(
              stream: _bloc.selectedDate,
              builder: (context, snapshot) {
                return TaskHeader(
                    callback: (val) => _bloc.selectedDateEventSink.add(val),
                    selectedDate: snapshot.data);
              })),
      Flexible(
          child: StreamBuilder<List<Task>>(
              stream: _bloc.listTask,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return TaskList(
                      listTasks: snapshot.data,
                      callback: (val) => _bloc.updateTaskEventSink.add(val));
                } else {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(I18nLocalizations.translate(
                          context, "error.task.list")),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }
              })),
    ]);
  }
}
