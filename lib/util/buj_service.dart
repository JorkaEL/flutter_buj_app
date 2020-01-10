import 'package:flutter/material.dart';
import 'package:flutter_buj_app/model/key_task.dart';
import 'package:flutter_buj_app/model/task.dart';
import 'package:flutter_buj_app/model/habit.dart';

class BujService {
  BujService._internal();

  static final BujService _bujService = BujService._internal();

  factory BujService() {
    return _bujService;
  }

  final List<Task> listTask = [];
  final List<KeyTask> listKeyTask = [];
  final List<Habit> listTracker = [Habit(id: 0, color: Colors.grey, libelle: 'aucun')];

  addTask(Task t) {
    listTask.add(t);
  }

  List<Task> getTask() {
    return listTask;
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