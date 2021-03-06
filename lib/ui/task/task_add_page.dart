import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_buj_app/model/habit.dart';
import 'package:flutter_buj_app/model/key_task.dart';
import 'package:flutter_buj_app/ui/component/button_select_date.dart';
import 'package:flutter_buj_app/ui/task/bloc/task_add_bloc.dart';
import 'package:flutter_buj_app/ui/task/component/task_add/task_add_dropdown.dart';
import 'package:flutter_buj_app/util/date_service.dart';
import 'package:flutter_buj_app/util/routing_constants.dart';
import 'package:i18n_localizations/i18n_localizations.dart';
import 'package:logger/logger.dart';

class TaskAddPage extends StatefulWidget {
  @override
  _TaskAddState createState() => _TaskAddState();
}

class _TaskAddState extends State<TaskAddPage> {
  final logger = Logger();
  final _bloc = TaskAddBloc();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pushNamed(context, TaskPageRoute)),
          backgroundColor: Colors.deepPurple,
          centerTitle: true,
          title: Text(I18nLocalizations.translate(context, 'task.add.title'))),
      body: Form(
          key: _bloc.formKey,
          child: Container(
              padding:
                  EdgeInsetsDirectional.only(start: 15.0, top: 5.0, end: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  StreamBuilder<TextEditingController>(
                    stream: _bloc.libellerStream,
                    builder: (context, snapshot) {
                      return TextFormField(
                        controller: snapshot.data,
                        onChanged: _bloc.libellerEventSink,
                        decoration: InputDecoration(
                          hintText: I18nLocalizations.translate(
                              context, 'task.add.libeler'),
                        ),
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value.isEmpty) {
                            return I18nLocalizations.translate(
                                context, 'error.task.add.libeler');
                          }
                          return null;
                        },
                      );
                    }
                  ),
                  StreamBuilder(
                      stream: _bloc.selectedDateStream,
                      initialData: _bloc.selectedDate,
                      builder: (context, snapshot) {
                        return ButtonSelectDate(
                          callback: (day) =>
                              _bloc.selectedDateEventSink.add(day),
                          selectedDate: snapshot.data,
                          defaultText: I18nLocalizations.translate(context, 'day'),
                          typeDate: snapshot.data.typeDate,
                          formatDate: I18nLocalizations.translate(
                              context, 'formatDate'),
                        );
                      }),
                  StreamBuilder<KeyTask>(
                      stream: _bloc.keyChoiceStream,
                      initialData: _bloc.keyChoice,
                      builder: (context, snapshot) {
                        return TaskAddDropdown(
                            _bloc.keyList,
                            snapshot.data,
                            I18nLocalizations.translate(
                                context, 'keyTask.dropdown'),
                            'keyTask',
                            (keyTask) => _bloc.keyTaskEventSink.add(keyTask));
                      }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      StreamBuilder<Habit>(
                          stream: _bloc.habitChoiceStream,
                          initialData: _bloc.habitChoice,
                          builder: (context, snapshot) {
                            return TaskAddDropdown(
                                _bloc.habitList,
                                snapshot.data,
                                I18nLocalizations.translate(
                                    context, 'habit.dropdown'),
                                'habit',
                                (hab) => _bloc.habitTaskEventSink.add(hab));
                          }),
                      IconButton(
                        icon: Icon(Icons.add_circle),
                        color: Colors.deepPurple,
                        onPressed: () {
                          Navigator.pushNamed(context, HabitAddPageRoute,
                              arguments: TaskAddPageRoute);
                        },
                      ),
                    ],
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RaisedButton(
                          color: Colors.deepPurple,
                          textColor: Colors.white,
                          onPressed: () {
                              // Process data
                              _bloc.addTask(context);
                          },
                          child: Text(I18nLocalizations.translate(
                              context, 'actions.validate')),
                        ),
                      ]),
                ],
              )) // Build this out in the next steps.
          ),
    );
  }
}
