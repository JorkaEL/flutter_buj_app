import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_buj_app/model/habit.dart';
import 'package:flutter_buj_app/model/key_task.dart';
import 'package:flutter_buj_app/model/task.dart';
import 'package:flutter_buj_app/util/buj_service.dart';
import 'package:flutter_buj_app/util/date_service.dart';
import 'package:flutter_buj_app/util/routing_constants.dart';

class TaskAddBloc {
  final formKey = GlobalKey<FormState>();

  TextEditingController libellerController;

  DateTime selectedDate;

  /// clée d'une tâche
  KeyTask keyChoice;
  List<KeyTask> keyList;

  /// habitude d'une tâche
  Habit habitChoice;
  List<Habit> habitList;

  /// stream pour le libéler de la tâche
  final _libellerStateController = StreamController<TextEditingController>();

  StreamSink<TextEditingController> get _libeller =>
      _libellerStateController.sink;

  Stream<TextEditingController> get libellerStream =>
      _libellerStateController.stream;

  final _libellerEventController = StreamController<String>();

  Function(String) get libellerEventSink => _libellerEventController.sink.add;

  /// stream pour la clée de la tâche
  final _keyTaskStateController = StreamController<KeyTask>();

  StreamSink<KeyTask> get _keyChoice => _keyTaskStateController.sink;

  Stream<KeyTask> get keyChoiceStream => _keyTaskStateController.stream;

  final _keyTaskEventController = StreamController<KeyTask>();

  Sink<KeyTask> get keyTaskEventSink => _keyTaskEventController.sink;

  /// stream pour la clée de la tâche
  final _habitTaskStateController = StreamController<Habit>();

  StreamSink<Habit> get _habitChoice => _habitTaskStateController.sink;

  Stream<Habit> get habitChoiceStream => _habitTaskStateController.stream;

  final _habitTaskEventController = StreamController<Habit>();

  Sink<Habit> get habitTaskEventSink => _habitTaskEventController.sink;

  /// Stream pour la tâche
  final _taskStateController = StreamController<Task>();

  /// Stream pour la date de la tâche
  final _selectDateStateController = StreamController<DateTime>();

  StreamSink<DateTime> get _inSelectedDate => _selectDateStateController.sink;

  Stream<DateTime> get selectedDateStream => _selectDateStateController.stream;

  final _selectedDateEventController = StreamController<DateTime>();

  Sink<DateTime> get selectedDateEventSink => _selectedDateEventController.sink;

  TaskAddBloc() {
    _initBloc();
  }

  void addTask(BuildContext context) {
    if (formKey.currentState.validate() &&
        keyChoice != null &&
        habitChoice != null) {
      var t = Task(
          libelle: libellerController.text,
          date: selectedDate,
          id: 0,
          state: false,
          habit: habitChoice,
          key: keyChoice);
      BujService().addTask(t);
      Navigator.pushNamed(context, TaskPageRoute);
    }
  }

  void dispose() {
    _taskStateController.close();

    _libellerStateController.close();
    _libellerEventController.close();

    _selectDateStateController.close();
    _selectedDateEventController.close();

    _keyTaskStateController.close();
    _keyTaskEventController.close();

    _habitTaskStateController.close();
    _habitTaskEventController.close();
  }

  void _initBloc() {
    libellerController = TextEditingController();
    selectedDate = DateService().selectedDate;
    keyList = BujService().getKeyTask();
    habitList = BujService().getHabits();
    _updateLibeller('');
    _libellerEventController.stream.listen(_updateLibeller);
    _selectedDateEventController.stream.listen(_updateDay);
    _keyTaskEventController.stream.listen(_updateKeyChoice);
    _habitTaskEventController.stream.listen(_updateHabitChoice);
  }

  void _updateLibeller(String libeller) {
    libellerController.value = libellerController.value.copyWith(text: libeller,);

    _libeller.add(libellerController);
  }

  void _updateDay(DateTime day) {
    selectedDate = day;
    DateService().selectedDate = selectedDate;
    _inSelectedDate.add(selectedDate);
  }

  void _updateKeyChoice(KeyTask key) {
    keyChoice = key;

    _keyChoice.add(keyChoice);
  }

  void _updateHabitChoice(Habit habit) {
    habitChoice = habit;

    _habitChoice.add(habitChoice);
  }
}
