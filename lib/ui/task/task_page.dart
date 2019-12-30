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
          backgroundColor: Colors.deepPurple,
          centerTitle: true,
          title: Text('Taches')
        ),
      drawer: SideMenu(),
      body: ListView.separated(
        itemCount: myTask.length,
        separatorBuilder: (context, index) => Divider(),
        itemBuilder: (context, index) => ListTile(
            leading: IconButton(
              icon: Icon(myTask[index].state ? Icons.check_box : Icons.check_box_outline_blank),
              onPressed: () {
                setState(() {
                  myTask[index].state = !myTask[index].state;
                });
              },
            ),
            title:  Text(myTask[index].libelle),
            trailing: Icon(myTask[index].key.icon, color: myTask[index].tracker.color),
          ),
        ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        onPressed: () {
          Navigator.pushNamed(context, TaskAddPageRoute);
        },
        child: Icon(Icons.add),
      ),
    );
  }

}