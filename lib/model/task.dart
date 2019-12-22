import 'package:flutter_buj_app/model/key.dart';
import 'package:flutter_buj_app/model/tracker.dart';

class Task {

  num id;
  String libelle;
  Key key;
  Tracker tracker;
  bool state;
  String date;

  Task({this.id, this.libelle, this.key, this.tracker, this.state, this.date});

}