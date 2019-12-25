import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_buj_app/util/routing_constants.dart';

class SideMenu extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Center(child: Text('BUJ')),
              decoration: BoxDecoration(
                color: Colors.purple,
              ),
            ),
            ListTile(
              title: Center(child:Text('Taches')),
              onTap: () => _goToTask(context),
            ),
            ListTile(
              title: Center(child:Text('Habitudes')),
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