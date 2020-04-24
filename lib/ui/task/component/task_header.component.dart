

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_buj_app/model/button_select_date.dart';
import 'package:flutter_buj_app/util/date_service.dart';
import 'package:i18n_localizations/i18n_localizations.dart';
import 'package:flutter_buj_app/ui/component/button_select_date.dart';

typedef DateCallBack(ButtonSelectDateModel val);

class TaskHeader extends StatelessWidget {
  final DateCallBack callback;
  ButtonSelectDateModel selectedDate;
  TaskHeader({this.callback, this.selectedDate});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          ButtonSelectDate(
              callback: callback,
              selectedDate: selectedDate,
              defaultText: I18nLocalizations.translate(context, 'day'),
              typeDate: typeDate.day,
              formatDate: I18nLocalizations.translate(context, 'formatDate'),
          ),
          ButtonSelectDate(
            callback: callback,
            selectedDate: selectedDate,
            defaultText: I18nLocalizations.translate(context, 'week'),
            typeDate: typeDate.week,
            formatDate: I18nLocalizations.translate(context, 'formatDate'),
          ),
          ButtonSelectDate(
            callback: callback,
            selectedDate: selectedDate,
            defaultText: I18nLocalizations.translate(context, 'month'),
            typeDate: typeDate.month,
            formatDate: I18nLocalizations.translate(context, 'formatDate'),
          ),
        ],
      ),
    );
  }
}