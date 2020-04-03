import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_buj_app/bloc/bloc_provider.dart';
import 'package:flutter_buj_app/ui/task/bloc/task_bloc.dart';
import 'package:i18n_localizations/i18n_localizations.dart';
import 'package:flutter_buj_app/ui/component/side_menu.component.dart';
import 'package:flutter_buj_app/util/routing_constants.dart';

import 'component/task_body.component.dart';

class TaskPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: TaskBloc(),
      child: Scaffold(
          appBar: AppBar(
              backgroundColor: Colors.deepPurple,
              centerTitle: true,
              title: Text(I18nLocalizations.translate(context, "task.title"))),
          drawer: SideMenu(),
          body: TaskBody(),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.deepPurple,
            onPressed: () {
              Navigator.pushNamed(context, TaskAddPageRoute);
            },
            child: Icon(Icons.add),
          )),
    );
  }
}
