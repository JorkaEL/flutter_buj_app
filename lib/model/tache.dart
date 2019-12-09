import 'package:flutter_buj_app/model/key.dart';
import 'package:flutter_buj_app/model/tracker.dart';

class Tache {

  num id;
  String libelle;
  Key key;
  Tracker tracker;
  bool state;
  String date;

  Tache({this.id, this.libelle, this.key, this.tracker, this.state, this.date});

}