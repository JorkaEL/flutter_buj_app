import 'package:flutter/material.dart';
import 'package:i18n_localizations/i18n_localizations.dart';

class UndefinedView extends StatelessWidget {
  final String name;

  const UndefinedView({Key key, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Text(I18nLocalizations.translate(context,"error.task.list", params: {name: name})),
        ));
  }
}