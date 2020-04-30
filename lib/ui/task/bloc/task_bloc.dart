import 'dart:async';

import 'package:flutter_buj_app/model/button_select_date.dart';
import 'package:flutter_buj_app/model/item_task_bloc.dart';
import 'package:flutter_buj_app/util/buj_service.dart';
import 'package:flutter_buj_app/util/date_service.dart';

class TaskBloc {

  ButtonSelectDateModel selectedDate = ButtonSelectDateModel();

  ItemTaskBloc itemBloc;


  /// Stream pour la date du filtre
  final _selectDateStateController = StreamController<ButtonSelectDateModel>();

  StreamSink<ButtonSelectDateModel> get _inSelectedDate => _selectDateStateController.sink;

  Stream<ButtonSelectDateModel> get selectedDateStream => _selectDateStateController.stream;

  final _selectedDateEventController = StreamController<ButtonSelectDateModel>();

  Sink<ButtonSelectDateModel> get selectedDateEventSink => _selectedDateEventController.sink;

  /// Stream pour la list des task
  final _listTaskStateController = StreamController<ItemTaskBloc>();

  StreamSink<ItemTaskBloc> get _inListTask => _listTaskStateController.sink;

  Stream<ItemTaskBloc> get listTask => _listTaskStateController.stream;

  final _updateTaskEventController = StreamController<num>();

  Sink<num> get updateTaskEventSink => _updateTaskEventController.sink;

  TaskBloc() {
    _initBloc();
  }

  void updateList() {

    if(selectedDate.typeDate == typeDate.day) {
      itemBloc.isWeek = false;
      itemBloc.dayTask = BujService().getTaskByDay(selectedDate.date);
    } else if(selectedDate.typeDate == typeDate.week) {
      itemBloc.isWeek = true;
      itemBloc.weekTask = BujService().getTasksByWeek(selectedDate.date);
    }
    _inListTask.add(itemBloc);
  }

  void dispose() {
    _selectDateStateController.close();
    _selectedDateEventController.close();
    _listTaskStateController.close();
    _updateTaskEventController.close();
  }

  void _initBloc() {
    selectedDate.date = DateService().selectedDate;
    itemBloc = new ItemTaskBloc();
    selectedDate.typeDate = typeDate.day;
    _selectedDateEventController.stream.listen(_filterDay);
    _updateTaskEventController.stream.listen(_updateTask);
    updateList();
  }

  void _filterDay(ButtonSelectDateModel obj) {
    selectedDate = obj;
    DateService().selectedDate = selectedDate.date;

    _inSelectedDate.add(selectedDate);
    updateList();
  }

  void _updateTask(num id) {
    BujService().updatStateTask(id);
    updateList();
  }
}
