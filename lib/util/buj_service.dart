import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_buj_app/model/key_task.dart';
import 'package:flutter_buj_app/model/task.dart';
import 'package:flutter_buj_app/model/habit.dart';
import 'package:logger/logger.dart';

class BujService {
  BujService._internal();

  static final BujService _bujService = BujService._internal();

  factory BujService() {
    return _bujService;
  }

  final logger = Logger();
  final List<Task> listTask = [];
  final List<KeyTask> listKeyTask = [];
  final List<Habit> listTracker = [Habit(id: 0, color: Colors.grey, libelle: 'aucun')];

  addTask(Task t) {
    listTask.add(t);
  }

  Future<List<Task>> getTask() {
    var completer = Completer<List<Task>>();

    completer.complete(this.listTask);
    return completer.future;
  }

  Future<List<Task>> getTaskByDay(DateTime date) {
    List<Task> tasks = [];
    var completer = Completer<List<Task>>();

    for(var t in listTask) {
      if (date != null && t.date.isAtSameMomentAs(date)) {
        tasks.add(t);
      }
    }
    completer.complete(tasks);
    return completer.future;
  }

  updatStateTask(id) {
    logger.i(id);
  }

  List<Habit> getHabits() {
    return listTracker;
  }

  List<KeyTask> getKeyTask() {
    return listKeyTask;
  }

  addKeyTask(KeyTask k) {
    listKeyTask.add(k);
  }

  addHabit(Habit h) {
    listTracker.add(h);
  }

}