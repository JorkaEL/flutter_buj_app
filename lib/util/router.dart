import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_buj_app/ui/home/home_page.dart';
import 'package:flutter_buj_app/ui/undefined/undefined_view.dart';
import 'package:flutter_buj_app/util/routing_constants.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch(settings.name) {
    case HomePageRoute:
      return MaterialPageRoute(builder: (context) => HomePage());
    default:
      return MaterialPageRoute(builder: (context) =>  UndefinedView(name: settings.name));
  }
}