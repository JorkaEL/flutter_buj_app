import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
          title: Text('Home')
        ),
      drawer: Drawer(
        child: ListView(
            children: <Widget>[
              DrawerHeader(
                child: Center(child: Text('WIP')),
                decoration: BoxDecoration(
                  color: Colors.purple,
                ),
              ),
              ListTile(
                title: Center(child:Text('Home')),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                title: Center(child:Text('Habitudes')),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
            ]
        ),
      ),
    );
  }

}