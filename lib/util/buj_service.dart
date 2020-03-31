import 'dart:async';

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

  final List<KeyTask> listKeyTask = [
    KeyTask(id: 0, libelle: 'TODO', icon: Icons.mode_edit),
    KeyTask(id: 0, libelle: 'Urgent', icon: Icons.priority_high),
    KeyTask(id: 0, libelle: 'Evenement', icon: Icons.insert_invitation),
    KeyTask(id: 0, libelle: 'Anniversaire', icon: Icons.cake),
    KeyTask(id: 0, libelle: 'Réunion', icon: Icons.business_center),
    KeyTask(id: 0, libelle: 'Déjeuner', icon: Icons.restaurant),
    KeyTask(id: 0, libelle: 'Sortie', icon: Icons.nature_people)
  ];
  final List<Habit> listTracker = [
    Habit(id: 0, color: Colors.grey, libelle: 'Aucune')
  ];
  final List<Task> listTask = [];

  addTask(Task t) {
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

  updatStateTask(id) {
    final index = listTask.indexWhere((element) => element.id == id);

    listTask[index].state = !listTask[index].state;
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