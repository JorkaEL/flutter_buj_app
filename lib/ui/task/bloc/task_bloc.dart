import 'dart:async';

import 'package:flutter_buj_app/bloc/bloc_provider.dart';
import 'package:flutter_buj_app/model/task.dart';
import 'package:flutter_buj_app/util/buj_service.dart';

class TaskBloc implements Bloc {
  List<Task> _listTask;
  DateTime _selectedDate;

  final _taskStateController = StreamController<Task>();

  /// Stream pour la date du filtre
  final _selectDateStateController = StreamController<DateTime>();

  StreamSink<DateTime> get _inSelectedDate => _selectDateStateController.sink;

  Stream<DateTime> get selectedDate => _selectDateStateController.stream;

  final _selectedDateEventController = StreamController<DateTime>();

  Sink<DateTime> get selectedDateEventSink => _selectedDateEventController.sink;

  /// Stream pour la list des task
  final _listTaskStateController = StreamController<List<Task>>();

  StreamSink<List<Task>> get _inListTask => _listTaskStateController.sink;

  Stream<List<Task>> get listTask => _listTaskStateController.stream;

  final _updateTaskEventController = StreamController<num>();

  Sink<num> get updateTaskEventSink => _updateTaskEventController.sink;

  TaskBloc() {
    final now = DateTime.now();
    _selectedDate = DateTime(now.year, now.month, now.day);
    _selectedDateEventController.stream.listen(_filterDay);
    _updateTaskEventController.stream.listen(_updateTask);
    updateList();
  }

  void _filterDay(DateTime day) {
    _selectedDate = day;
    _inSelectedDate.add(_selectedDate);
    updateList();
  }

  void _updateTask(num id) {
    BujService().updatStateTask(id);
    updateList();
  }

  void updateList() {
    _listTask = BujService().getTaskByDay(_selectedDate);
    _inListTask.add(_listTask);
  }

  @override
  void dispose() {
    _taskStateController.close();
    _selectDateStateController.close();
    _selectedDateEventController.close();
    _listTaskStateController.close();
    _updateTaskEventController.close();
  }
}
