import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_buj_app/i18n_localizations.dart';
import 'package:flutter_buj_app/util/routing_constants.dart';

class SideMenu extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Center(child: Text(I18nLocalizations.translate(context,"menu.title"))),
              decoration: BoxDecoration(
                color: Colors.deepPurple,
              ),
            ),
            ListTile(
              title: Center(child:Text(I18nLocalizations.translate(context,"menu.task"))),
              onTap: () => _goToTask(context),
            ),
            ListTile(
              title: Center(child:Text(I18nLocalizations.translate(context,"menu.habit"))),
              onTap: () => _goToHabit(context),
            ),
          ]
      ),
    );
  }
}

_goToTask(BuildContext context) {
  Navigator.pushNamed(context, TaskPageRoute);
}

_goToHabit(BuildContext context) {
  Navigator.pushNamed(context, HabitPageRoute);
}