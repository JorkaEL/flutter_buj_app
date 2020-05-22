import 'package:flutter/material.dart';
import 'package:flutter_buj_app/model/day_week.dart';
import 'package:flutter_buj_app/util/date_service.dart';
import 'package:i18n_localizations/i18n_localizations.dart';

typedef NumCallBack(num id);

class TaskDayWeek extends StatelessWidget {
  final NumCallBack callback;
  final DayWeek day;

  TaskDayWeek({this.callback, this.day});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(I18nLocalizations.translate(
              context, 'numberDay.${day.date.weekday}',
              params: {
                'date': DateService().formatDateText(day.date,
                    I18nLocalizations.translate(context, 'formatDate'))
              })),
        ),
        ListView.separated(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: day.tasks.length,
          physics: PageScrollPhysics(),
          separatorBuilder: (context, index) => Divider(),
          itemBuilder: (context, index) => ListTile(
            leading: IconButton(
              icon: Icon(day.tasks[index].state
                  ? Icons.check_box
                  : Icons.check_box_outline_blank),
              onPressed: () {
                callback(day.tasks[index].id);
              },
            ),
            title: Text(day.tasks[index].libelle),
            trailing: Icon(day.tasks[index].key.icon,
                color: day.tasks[index].habit.color),
            onTap: () {
              callback(day.tasks[index].id);
            },
          ),
        ),
      ],
    );
  }
}
