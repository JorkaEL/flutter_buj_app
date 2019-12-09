import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_buj_app/ui/component/side_menu.component.dart';

class HabitPage extends StatefulWidget {

  @override
  _HabitPageState createState() => _HabitPageState();
}


class _HabitPageState extends State {

  @override
  void initState() {
    super.initState();
  }

  @override build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.purple,
            centerTitle: true,
            title: Text('Habitudes')
        ),
        drawer: SideMenu(),
      body: Container(
        color: Colors.red,
        height: 50,
        width: 50,
      ),
    );
  }

}