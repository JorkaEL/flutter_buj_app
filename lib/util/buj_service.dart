import 'package:flutter/material.dart';
import 'package:flutter_buj_app/model/key_task.dart';
import 'package:flutter_buj_app/model/task.dart';
import 'package:flutter_buj_app/model/tracker.dart';

class BujService {
  BujService._internal();

  static final BujService _bujService = BujService._internal();

  factory BujService() {
    return _bujService;
  }

  final List<Task> listTask = [];
  final List<KeyTask> listKeyTask = [];
  final List<Tracker> listTracker = [Tracker(id: 0, color: Colors.purple, libelle: 'aucun')];

  addTask(Task t) {
    listTask.add(t);
  }

  List<Task> getTask() {
    return listTask;
  }

  List<Tracker> getTrackers() {
    return listTracker;
  }

  List<KeyTask> getKeyTask() {
    return listKeyTask;
  }

  addKeyTask(KeyTask k) {
    listKeyTask.add(k);
  }

  addTracker(Tracker t) {
    listTracker.add(t);
  }

}