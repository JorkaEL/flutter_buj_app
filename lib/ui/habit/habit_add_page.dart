import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_buj_app/model/habit.dart';
import 'package:flutter_buj_app/util/buj_service.dart';
import 'package:flutter_buj_app/util/listColor_service.dart';
import 'package:i18n_localizations/i18n_localizations.dart';

class HabitAddPage extends StatefulWidget {
  final String routeToBack;

  HabitAddPage({Key key, this.routeToBack}) : super(key: key);

  @override
  _HabitAddState createState() => _HabitAddState();

}

class _HabitAddState extends State<HabitAddPage> {

  final _formKey = GlobalKey<FormState>();

  final libelle = TextEditingController();

  var selectedColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          centerTitle: true,
          title: Text(I18nLocalizations.translate(context,"habit.add.title")),
      ),
      body: Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsetsDirectional.only(start: 15.0, top: 5.0, end: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  controller: this.libelle,
                  decoration: InputDecoration(
                    hintText: I18nLocalizations.translate(context,"habit.add.libeler")
                  ),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value.isEmpty) {
                      return I18nLocalizations.translate(context,"error.habit.add.libeler");
                    }
                    return null;
                  },
                ),
                DropdownButton<Color>(
                  hint: Text(I18nLocalizations.translate(context,"habit.add.dropdown")),
                  value: selectedColor,
                  onChanged: (Color color) {
                    setState(() {
                      selectedColor = color;
                    });
                  },
                  items: ListColorService().getListColors().map((color) => DropdownMenuItem<Color>(
                      value: color,
                      child: Container(
                          color: color,
                        height: 50,
                        width: 50,
                      ),
                    )
                  ).toList(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[ RaisedButton(
                    color: Colors.deepPurple,
                    textColor: Colors.white,
                    onPressed: () {
                      // Validate will return true if the form is valid, or false if
                      // the form is invalid.
                      if (_formKey.currentState.validate() && selectedColor != null) {
                        // Process data
                        var tracker = Habit(libelle: this.libelle.text, color: selectedColor);
                        BujService().addHabit(tracker);
                        Navigator.pushNamed(context, widget.routeToBack);
                      }
                    },
                    child: Text(I18nLocalizations.translate(context,"actions.validate")),
                  ),]
                ),
              ],
            )
          )// Build this out in the next steps.
      ),
    );
  }
}