import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_buj_app/model/key_task.dart';
import 'package:flutter_buj_app/util/buj_service.dart';
import 'package:flutter_buj_app/util/listIcon_service.dart';
import 'package:flutter_buj_app/util/routing_constants.dart';

class KeyTaskAddPage extends StatefulWidget {

  @override
  _KeyTaskAddState createState() => _KeyTaskAddState();

}

class _KeyTaskAddState extends State<KeyTaskAddPage> {

  final _formKey = GlobalKey<FormState>();

  final libelle = TextEditingController();
  var selectedIcon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          centerTitle: true,
          title: Text('Ajout de clée')
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
                    hintText: 'Libéller de la clée',
                  ),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'SVP rentrer un libéller pour la clée';
                    }
                    return null;
                  },
                ),
                DropdownButton<IconData>(
                  hint: Text('Selectionné votre icon'),
                  value: selectedIcon,
                  onChanged: (IconData icon) {
                    setState(() {
                      selectedIcon = icon;
                    });
                  },
                  items: ListIconService().getListIcons().map((IconData icon) {
                    return new DropdownMenuItem<IconData>(
                      value: icon,
                      child: Icon(icon),
                    );
                  }).toList(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[RaisedButton(
                    color: Colors.deepPurple,
                    textColor: Colors.white,
                    onPressed: () {
                      // Validate will return true if the form is valid, or false if
                      // the form is invalid.
                      if (_formKey.currentState.validate() && this.selectedIcon != null) {
                        // Process data
                        var key = KeyTask(libelle: this.libelle.text, icon: selectedIcon);
                        BujService().addKeyTask(key);
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