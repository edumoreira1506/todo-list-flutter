import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todo_list/src/widgets/form.dart';
import 'package:todo_list/src/widgets/header.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List _toDoList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(),
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          FormTodo()
        ]
      )
    );
  }
}
