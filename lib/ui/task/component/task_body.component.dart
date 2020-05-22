import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_buj_app/model/item_task_bloc.dart';
import 'package:flutter_buj_app/ui/task/bloc/task_bloc.dart';
import 'package:flutter_buj_app/ui/task/component/task_day_week_list.component.dart';
import 'package:flutter_buj_app/ui/task/component/task_header.component.dart';
import 'package:flutter_buj_app/ui/task/component/task_list.component.dart';
import 'package:i18n_localizations/i18n_localizations.dart';

class TaskBody extends StatefulWidget {
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
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
      SizedBox(
        height: 50.0,
          child: StreamBuilder(
              stream: _bloc.selectedDateStream,
              initialData: _bloc.selectedDate,
              builder: (context, snapshot) {
                return TaskHeader(
                    callback: (val) => _bloc.selectedDateEventSink.add(val),
                    selectedDate: snapshot.data);
              })),
      Expanded(
        child: StreamBuilder<ItemTaskBloc>(
            stream: _bloc.listTask,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.isWeek) {
                  return TaskDayWeekList(
                    listDayWeek: snapshot.data.weekTask,
                    callback: (val) => _bloc.updateTaskEventSink.add(val),
                  );
                } else {
                  return TaskList(
                      listTasks: snapshot.data.dayTask,
                      callback: (val) => _bloc.updateTaskEventSink.add(val));
                }
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
            }),
      ),
    ]);
  }
}
