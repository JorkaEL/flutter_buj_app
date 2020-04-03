import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_buj_app/bloc/bloc_provider.dart';
import 'package:flutter_buj_app/model/task.dart';
import 'package:flutter_buj_app/ui/task/bloc/task_bloc.dart';
import 'package:flutter_buj_app/ui/task/component/task_header.component.dart';
import 'package:flutter_buj_app/ui/task/component/task_list.component.dart';
import 'package:i18n_localizations/i18n_localizations.dart';

class TaskBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Flexible(
          child: StreamBuilder(
              stream: BlocProvider.of<TaskBloc>(context).selectedDate,
              builder: (context, snapshot) {
                return TaskHeader(
                    callback: (val) => BlocProvider.of<TaskBloc>(context)
                        .selectedDateEventSink
                        .add(val),
                    selectedDate: snapshot.data);
              })),
      Flexible(
          child: StreamBuilder<List<Task>>(
              stream: BlocProvider.of<TaskBloc>(context).listTask,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return TaskList(
                      listTasks: snapshot.data,
                      callback: (val) => BlocProvider.of<TaskBloc>(context)
                          .updateTaskEventSink
                          .add(val));
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
