import 'package:flutter/material.dart';
import 'package:flutter_buj_app/util/router.dart' as router;
import 'package:flutter_buj_app/util/routing_constants.dart';

void main() => runApp(BujApp());


class BujApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'BUJ',
        onGenerateRoute: router.generateRoute,
        debugShowCheckedModeBanner: false,
        initialRoute: HomePageRoute);
  }
}
