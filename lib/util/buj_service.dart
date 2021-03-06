import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_buj_app/model/day_week.dart';
import 'package:flutter_buj_app/model/key_task.dart';
import 'package:flutter_buj_app/model/task.dart';
import 'package:flutter_buj_app/model/habit.dart';
import 'package:flutter_buj_app/util/date_service.dart';

class BujService {
  BujService._internal();

  static final BujService _bujService = BujService._internal();

  factory BujService() {
    return _bujService;
  }

  final List<KeyTask> listKeyTask = [
    KeyTask(id: 0, libelle: 'keyTask.key.todo', icon: Icons.mode_edit),
    KeyTask(id: 0, libelle: 'keyTask.key.urgent', icon: Icons.priority_high),
    KeyTask(id: 0, libelle: 'keyTask.key.event', icon: Icons.insert_invitation),
    KeyTask(id: 0, libelle: 'keyTask.key.birthDay', icon: Icons.cake),
    KeyTask(id: 0, libelle: 'keyTask.key.meeting', icon: Icons.business_center),
    KeyTask(id: 0, libelle: 'keyTask.key.lunch', icon: Icons.restaurant),
    KeyTask(id: 0, libelle: 'keyTask.key.goOut', icon: Icons.nature_people)
  ];
  final List<Habit> listTracker = [
    Habit(id: 0, color: Colors.grey, libelle: 'Aucune')
  ];
  final List<Task> listTask = [];

  void addTask(Task t) {
    listTask.add(t);
  }

  Future<List<Task>> getTask() {
    var completer = Completer<List<Task>>();

    completer.complete(this.listTask);
    return completer.future;
  }

  List<Task> getTaskByDay(DateTime date) {
    List<Task> tasks = [];
    for (var t in listTask) {
      if (date != null && t.date.isAtSameMomentAs(date)) {
        tasks.add(t);
      }
    }

    return tasks;
  }

  List<DayWeek> getTasksByWeek(DateTime date) {
    List<DateTime> listDate = DateService().datesWeek(date);
    List<DayWeek> weekTasks = [];

    for (var d in listDate) {
      weekTasks.add(new DayWeek(date: d, tasks: getTaskByDay(d)));
    }

    return weekTasks;
  }

  void updatStateTask(id) {
    final index = listTask.indexWhere((element) => element.id == id);

    listTask[index].state = !listTask[index].state;
  }

  List<Habit> getHabits() {
    return listTracker;
  }

  List<KeyTask> getKeyTask() {
    return listKeyTask;
  }

  void addKeyTask(KeyTask k) {
    listKeyTask.add(k);
  }

  void addHabit(Habit h) {
    listTracker.add(h);
  }
}