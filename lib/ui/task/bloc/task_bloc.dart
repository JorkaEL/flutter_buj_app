import 'dart:async';

import 'package:flutter_buj_app/model/task.dart';
import 'package:flutter_buj_app/util/buj_service.dart';
import 'package:flutter_buj_app/util/date_service.dart';

class TaskBloc {

  DateTime selectedDate;

  List<Task> _listTask;


  /// Stream pour la date du filtre
  final _selectDateStateController = StreamController<DateTime>();

  StreamSink<DateTime> get _inSelectedDate => _selectDateStateController.sink;

  Stream<DateTime> get selectedDateStream => _selectDateStateController.stream;

  final _selectedDateEventController = StreamController<DateTime>();

  Sink<DateTime> get selectedDateEventSink => _selectedDateEventController.sink;

  /// Stream pour la list des task
  final _listTaskStateController = StreamController<List<Task>>();

  StreamSink<List<Task>> get _inListTask => _listTaskStateController.sink;

  Stream<List<Task>> get listTask => _listTaskStateController.stream;

  final _updateTaskEventController = StreamController<num>();

  Sink<num> get updateTaskEventSink => _updateTaskEventController.sink;

  TaskBloc() {
    _initBloc();
  }

  void updateList() {
    _listTask = BujService().getTaskByDay(selectedDate);
    _inListTask.add(_listTask);
  }

  void dispose() {
    _selectDateStateController.close();
    _selectedDateEventController.close();
    _listTaskStateController.close();
    _updateTaskEventController.close();
  }

  void _initBloc() {
    selectedDate = DateService().selectedDate;
    _selectedDateEventController.stream.listen(_filterDay);
    _updateTaskEventController.stream.listen(_updateTask);
    updateList();
  }

  void _filterDay(DateTime day) {
    selectedDate = day;
    DateService().selectedDate = selectedDate;
    _inSelectedDate.add(selectedDate);
    updateList();
  }

  void _updateTask(num id) {
    BujService().updatStateTask(id);
    updateList();
  }
}
