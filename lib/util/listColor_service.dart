import 'package:flutter/material.dart';

class ListColorService {
  ListColorService._internal();

  static final ListColorService _listColorService = ListColorService._internal();

  factory ListColorService() {
    return _listColorService;
  }

  final List<Color>  listColors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.cyan,
    Colors.indigo,
    Colors.purple,
    Colors.pink,
    Colors.orange,
    Colors.yellow,
    Colors.brown,
    Colors.grey,
    Colors.black
  ];


  List<Color> getListColors() {
    return this.listColors;
  }

}