import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_buj_app/model/habit.dart';
import 'package:flutter_buj_app/ui/component/side_menu.component.dart';
import 'package:flutter_buj_app/ui/habit/bloc/habit_bloc.dart';
import 'package:flutter_buj_app/ui/habit/component/habit_list.component.dart';
import 'package:flutter_buj_app/util/routing_constants.dart';
import 'package:i18n_localizations/i18n_localizations.dart';

class HabitPage extends StatefulWidget {
  @override
  _HabitPageState createState() => _HabitPageState();
}

class _HabitPageState extends State {
  final _bloc = HabitBloc();

  @override
  void initState() {
    super.initState();
    _bloc.updateList();
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.deepPurple,
            centerTitle: true,
            title: Text(I18nLocalizations.translate(context, "habit.title"))),
        drawer: SideMenu(),
        body: StreamBuilder<List<Habit>>(
            stream: _bloc.habitListStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return HabitList(
                  listHabit: snapshot.data
                );
              } else {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(I18nLocalizations.translate(
                        context, "error.habit.list")),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }
            }),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.deepPurple,
          onPressed: () {
            Navigator.pushNamed(context, HabitAddPageRoute,
                arguments: HabitPageRoute);
          },
          child: Icon(Icons.add),
        ));
  }
}
