import 'package:flutter/material.dart';


abstract class Bloc {
  void dispose();
}

class BlocProvider<T extends Bloc> extends StatefulWidget {
  BlocProvider({
    Key key,
    @required this.child,
    @required this.bloc
  }): super(key: key);

  final Widget child;
  final T bloc;


  @override
  State createState() => _BlocProviderState();

  static T of<T extends Bloc>(BuildContext context){
    final BlocProvider<T> provider = context.findAncestorWidgetOfExactType();

    return provider?.bloc;
  }
}

class _BlocProviderState extends State<BlocProvider>{

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void dispose(){
    widget.bloc.dispose();
    super.dispose();
  }
}
