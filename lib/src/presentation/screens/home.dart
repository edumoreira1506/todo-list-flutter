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

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<TodoDTO> _toDoList = [ ];

  void _addTodo() {
    if (_formKey.currentState.validate()) {
      setState(() {
        TodoDTO newToDo = TodoDTO(title: _toDoController.text, checked: false);

        _toDoController.text = '';
        _formKey = GlobalKey<FormState>();

        _toDoList.add(newToDo);
      }); 
    }
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
          Form(
            key: _formKey,
            child: FormTodo(this._toDoController, this._addTodo),
          ),
          Todos(this._toDoList, this._changeTodo)
        ]
      )
    );
  }
}
