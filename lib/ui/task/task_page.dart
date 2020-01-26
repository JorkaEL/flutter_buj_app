import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_buj_app/model/task.dart';
import 'package:flutter_buj_app/ui/component/side_menu.component.dart';
import 'package:flutter_buj_app/util/buj_service.dart';
import 'package:flutter_buj_app/util/routing_constants.dart';
import 'package:logger/logger.dart';

class TaskPage extends StatefulWidget {

  @override
  _TaskPageState createState() => _TaskPageState();
}


class _TaskPageState extends State {

  Future<List<Task>> myTask;
  var tasks = [];
  final logger = Logger();
  final format = DateFormat("yyyy-MM-dd");

  @override
  void initState() {
    super.initState();
    this.myTask = BujService().getTaskByDay(DateTime.now());
  }

  @override build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          centerTitle: true,
          title: Text('Taches')
        ),
      drawer: SideMenu(),
      body: Column(
        children: <Widget>[
          Flexible(
            child:
          Row(
            children: <Widget>[
              Flexible(
            child:
              RaisedButton(
                child: DateTimeField(
                    decoration: InputDecoration(
                        hintText: 'Jour'
                    ),
                    onChanged: (date) {
                      setState(() {
                        this.myTask = BujService().getTaskByDay(date);
                      });
                    },
                    format: format,
                    onShowPicker: (context, currentValue) async {
                      final date = await showDatePicker(
                          context: context,
                          firstDate: DateTime(1900),
                          initialDate: currentValue ?? DateTime.now(),
                          lastDate: DateTime(2100));

                      return date;
                    },
                  ),
                ),
              ),
              Text('test 2'),
              Text('Test 3')
            ],
          ),
    ),
          Flexible(
            child: FutureBuilder<List<Task>>(
              future: myTask,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('An error occurred'),
                  );
                } else {
                  tasks = [];
                  if(snapshot.hasData) {
                     tasks = snapshot.data;
                  }
                  return ListView.separated(
                    scrollDirection: Axis.vertical,
                    separatorBuilder: (context, index) => Divider(),
                    itemCount: tasks.length,
                    itemBuilder: (context, index) => ListTile(
                      leading: IconButton(
                        icon: Icon(tasks[index].state ? Icons.check_box : Icons.check_box_outline_blank),
                        onPressed: () {
                          setState(() {
                            BujService().updatStateTask(tasks[index].id);
                            tasks[index].state = !tasks[index].state;
                          });
                        },
                      ),
                      title:  Text(tasks[index].libelle),
                      trailing: Icon(tasks[index].key.icon, color: tasks[index].habit.color),
                    ),
                  );
                }
              },
            )
          ),

        ]),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        onPressed: () {
          Navigator.pushNamed(context, TaskAddPageRoute);
        },
        child: Icon(Icons.add),
      )
    );
  }

}