import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_buj_app/model/habit.dart';
import 'package:flutter_buj_app/util/buj_service.dart';
import 'package:flutter_buj_app/util/listColor_service.dart';
import 'package:flutter_buj_app/util/routing_constants.dart';

class HabitAddPage extends StatefulWidget {

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
          title: Text('Ajout d\'un tracker'),
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
                  decoration: const InputDecoration(
                    hintText: 'Libéller du tracker',
                  ),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'SVP rentrer un libéller pour le tracker';
                    }
                    return null;
                  },
                ),
                DropdownButton<Color>(
                  hint: Text('Selectionné votre color'),
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
                        Navigator.pushNamed(context, TaskAddPageRoute);
                      }
                    },
                    child: Text('Valider'),
                  ),]
                ),
              ],
            )
          )// Build this out in the next steps.
      ),
    );
  }
}