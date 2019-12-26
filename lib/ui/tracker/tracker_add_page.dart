import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_buj_app/model/tracker.dart';
import 'package:flutter_buj_app/util/buj_service.dart';
import 'package:flutter_buj_app/util/routing_constants.dart';

class TrackerAddPage extends StatefulWidget {

  @override
  _TrackerAddState createState() => _TrackerAddState();

}

class _TrackerAddState extends State<TrackerAddPage> {

  final _formKey = GlobalKey<FormState>();

  final libelle = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.purple,
          centerTitle: true,
          title: Text('Ajout d\'un tracker'),
      ),
      body: Form(
          key: _formKey,
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
              Padding(
                padding: EdgeInsets.all(16.0),
                child: RaisedButton(
                  onPressed: () {
                    // Validate will return true if the form is valid, or false if
                    // the form is invalid.
                    if (_formKey.currentState.validate()) {
                      // Process data
                      // TODO select color
                      var tracker = Tracker(libelle: this.libelle.text, color: Colors.red );
                      BujService().addTracker(tracker);
                      Navigator.pushNamed(context, TaskAddPageRoute);
                    }
                  },
                  child: Text('Valider'),
                ),
              ),
            ],
          )// Build this out in the next steps.
      ),
    );
  }
}