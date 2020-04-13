import 'dart:async';

import 'package:flutter_buj_app/model/habit.dart';
import 'package:flutter_buj_app/model/key_task.dart';
import 'package:flutter_buj_app/model/task.dart';
import 'package:flutter_buj_app/util/buj_service.dart';
import 'package:flutter_buj_app/util/date_service.dart';

class TaskAddBloc {

  DateTime selectedDate;

  /// clée d'une tâche
  KeyTask keyChoice;
  List<KeyTask> keyList;

  /// habitude d'une tâche
  Habit habitChoice;
  List<Habit> habitList;

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

  void addTask(String libelle) {
    var t = Task(
        libelle: libelle,
        date: selectedDate,
        id: 0,
        state: false,
        habit: habitChoice,
        key: keyChoice);
    BujService().addTask(t);
  }

  void dispose() {
    _taskStateController.close();
    _selectDateStateController.close();
    _selectedDateEventController.close();
    _keyTaskStateController.close();
    _keyTaskEventController.close();
    _habitTaskStateController.close();
    _habitTaskEventController.close();
  }

  void _initBloc() {
    selectedDate = DateService().selectedDate;
    keyList = BujService().getKeyTask();
    habitList = BujService().getHabits();
    _selectedDateEventController.stream.listen(_updateDay);
    _keyTaskEventController.stream.listen(_updateKeyChoice);
    _habitTaskEventController.stream.listen(_updateHabitChoice);
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
