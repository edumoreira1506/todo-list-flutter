import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todo_list/src/model/dto/todo.dart';
import 'package:todo_list/src/model/service/todo_service.dart';
import 'package:todo_list/src/presentation/widgets/form.dart';
import 'package:todo_list/src/presentation/widgets/header.dart';
import 'package:todo_list/src/presentation/widgets/todos.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _toDoController = TextEditingController();
  final _todoService = TodoService();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<TodoDTO> _toDoList = [ ];

  TodoDTO _lastRemoved;
  int _lastRemovedPosition;

  @override
  void initState() {
    super.initState();

    _todoService.all().then((data) {
      setState(() {
        List<TodoDTO> list = _todoService.unserializeTodos(data);

        _toDoList = list;
      });
    });
  }

  void _addTodo() {
    if (_formKey.currentState.validate()) {
      setState(() {
        TodoDTO newToDo = TodoDTO(title: _toDoController.text, checked: false);

        _toDoController.text = '';
        _formKey = GlobalKey<FormState>();

        _toDoList.add(newToDo);
        _todoService.persist(_toDoList);
      }); 
    }
  }

  void _changeTodo(newValue, index) {
    setState(() {
      _toDoList[index].checked = newValue;

      _todoService.persist(_toDoList);
    });
  }

  void _deleteTodo(index) {
    setState(() {
      _lastRemoved = _toDoList[index];
      _lastRemovedPosition = index;
      _toDoList.removeAt(index);

      _todoService.persist(_toDoList);
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
          Todos(this._toDoList, this._changeTodo, this._deleteTodo)
        ]
      )
    );
  }
}
