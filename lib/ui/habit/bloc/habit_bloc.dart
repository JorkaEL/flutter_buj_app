import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_buj_app/model/habit.dart';
import 'package:flutter_buj_app/util/buj_service.dart';
import 'package:flutter_buj_app/util/listColor_service.dart';

class HabitBloc {
  final formKey = GlobalKey<FormState>();
  TextEditingController libellerController;

  List<Habit> _habitList;

  List<Color> colorList;
  Color selectedColor;

  /// stream pour le libéler de la tâche
  final _libellerStateController = StreamController<TextEditingController>();

  StreamSink<TextEditingController> get _libeller =>
      _libellerStateController.sink;

  Stream<TextEditingController> get libellerStream =>
      _libellerStateController.stream;

  final _libellerEventController = StreamController<String>();

  Function(String) get libellerEventSink => _libellerEventController.sink.add;


  /// Stream pour la couleur sélectionnée
  final _selectColorStateController = StreamController<Color>();

  StreamSink<Color> get _selectedColor => _selectColorStateController.sink;

  Stream<Color> get selectedColorStream => _selectColorStateController.stream;

  final _selectedColorEventController = StreamController<Color>();

  Function(Color) get selectedColorEventSink => _selectedColorEventController.sink.add;

  /// Stream pour la liste des habits
  final _listHabitStateController = StreamController<List<Habit>>();

  StreamSink<List<Habit>> get _inListHabit => _listHabitStateController.sink;

  Stream<List<Habit>> get habitListStream => _listHabitStateController.stream;

  HabitBloc() {
    _initBloc();
  }

  void updateList() {
    _habitList = BujService().getHabits();
    _inListHabit.add(_habitList);
  }

  void addHabit(BuildContext context, String routeToBack) {
    // Validate will return true if the form is valid, or false if
    // the form is invalid.
    if (formKey.currentState.validate() && selectedColor != null) {
      // Process data
      var habit = Habit(libelle: libellerController.text, color: selectedColor);
      BujService().addHabit(habit);
      Navigator.pushNamed(context, routeToBack);
    }
  }


  void dispose() {
    _listHabitStateController.close();
    _libellerStateController.close();
    _libellerEventController.close();
    _selectColorStateController.close();
    _selectedColorEventController.close();
  }

  void _initBloc() {
    libellerController = TextEditingController();
    colorList = ListColorService().getListColors();
    _selectedColorEventController.stream.listen(_updateColor);
    _updateLibeller('');
    _updateColor(selectedColor);
  }

  void _updateLibeller(String libeller) {
    libellerController.value = libellerController.value.copyWith(text: libeller,);

    _libeller.add(libellerController);
  }

  void _updateColor(Color color) {
    selectedColor = color;

    _selectedColor.add(selectedColor);
  }

}