import 'package:flutter/material.dart';
import 'package:flutter_buj_app/model/habit.dart';

class HabitList extends StatelessWidget {
  final List<Habit> listHabit;

  HabitList({this.listHabit});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.vertical,
      separatorBuilder: (context, index) => Divider(),
      itemCount: listHabit.length,
      itemBuilder: (context, index) => ListTile(
        title: Text(listHabit[index].libelle),
        trailing: Icon(Icons.brightness_1,
            color: listHabit[index].color),
      ),
    );
  }

}