import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_buj_app/ui/component/side_menu.component.dart';
import 'package:flutter_buj_app/util/routing_constants.dart';

class TaskPage extends StatefulWidget {

  @override
  _TaskPageState createState() => _TaskPageState();
}


class _TaskPageState extends State {

  @override
  void initState() {
    super.initState();
  }

  @override build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple,
          centerTitle: true,
          title: Text('Taches')
        ),
      drawer: SideMenu(),
      body: Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, TaskAddPageRoute);
        },
        child: Icon(Icons.add),
      ),
    );
  }

}