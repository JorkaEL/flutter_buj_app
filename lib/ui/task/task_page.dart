import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_buj_app/model/task.dart';
import 'package:flutter_buj_app/ui/component/side_menu.component.dart';
import 'package:flutter_buj_app/util/buj_service.dart';
import 'package:flutter_buj_app/util/routing_constants.dart';

class TaskPage extends StatefulWidget {

  @override
  _TaskPageState createState() => _TaskPageState();
}


class _TaskPageState extends State {

  List<Task> myTask;

  @override
  void initState() {
    super.initState();
    this.myTask = BujService().getTask();
  }

  @override build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple,
          centerTitle: true,
          title: Text('Taches')
        ),
      drawer: SideMenu(),
      body: ListView.separated(
        itemCount: myTask.length,
        separatorBuilder: (context, index) => Divider(),
        itemBuilder: (context, index) => Text(myTask[index].libelle)
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, TaskAddPageRoute);
        },
        child: Icon(Icons.add),
      ),
    );
  }

}