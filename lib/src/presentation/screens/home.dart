import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todo_list/src/model/dto/todo.dart';
import 'package:todo_list/src/presentation/widgets/form.dart';
import 'package:todo_list/src/presentation/widgets/header.dart';
import 'package:todo_list/src/presentation/widgets/todos.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _toDoController = TextEditingController();

  List<TodoDTO> _toDoList = [ ];

  void _addTodo() {
    setState(() {
      TodoDTO newToDo = TodoDTO(title: _toDoController.text, checked: false);

      _toDoController.text = '';

      _toDoList.add(newToDo);
    });
  }

  void _changeTodo(newValue, index) {
    setState(() {
      _toDoList[index].checked = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(),
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          FormTodo(_toDoController, _addTodo),
          Todos(this._toDoList, this._changeTodo)
        ]
      )
    );
  }
}
