import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_buj_app/model/habit.dart';
import 'package:flutter_buj_app/ui/component/side_menu.component.dart';
import 'package:flutter_buj_app/util/buj_service.dart';
import 'package:flutter_buj_app/util/routing_constants.dart';

class HabitPage extends StatefulWidget {

  @override
  _HabitPageState createState() => _HabitPageState();
}


class _HabitPageState extends State {

  List<Habit> habitList;

  @override
  void initState() {
    super.initState();
    this.habitList = BujService().getHabits();
  }

  @override build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.deepPurple,
            centerTitle: true,
            title: Text('Habitudes')
        ),
        drawer: SideMenu(),
        body: ListView.separated(
          scrollDirection: Axis.vertical,
          separatorBuilder: (context, index) => Divider(),
          itemCount: habitList.length,
          itemBuilder: (context, index) => ListTile(
            title:  Text(habitList[index].libelle),
            trailing: Icon(Icons.brightness_1, color: habitList[index].color),
          ),
        ),
        floatingActionButton: FloatingActionButton(
      backgroundColor: Colors.deepPurple,
      onPressed: () {
        Navigator.pushNamed(context, HabitAddPageRoute);
      },
      child: Icon(Icons.add),
    )
    );
  }

}