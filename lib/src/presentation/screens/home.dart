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

  void _recoveryTodo() {
    setState(() {
      _toDoList.insert(_lastRemovedPosition, _lastRemoved);
      _todoService.persist(_toDoList);
    });
  }

  void _deleteTodo(index, context) {
    setState(() {
      _lastRemoved = _toDoList[index];
      _lastRemovedPosition = index;
      _toDoList.removeAt(index);

      _todoService.persist(_toDoList);

      final snack = SnackBar(
        content: Text("Task '${_lastRemoved.title}' deleted"),
        action: SnackBarAction(
          label: 'Cancel',
          onPressed: _recoveryTodo
        ),
        duration: Duration(seconds: 2),
      );

      Scaffold.of(context).removeCurrentSnackBar();
      Scaffold.of(context).showSnackBar(snack);
    });
  }

  Future<Null>_onSort() async {
    await Future.delayed(Duration(seconds: 1));

    setState(() {
      _toDoList.sort((a, b) {
        if (a.checked && !b.checked) return 1;
        else if (!a.checked && b.checked) return -1;
        return 0;
      });

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
          Todos(this._toDoList, this._changeTodo, this._deleteTodo, this._onSort)
        ]
      )
    );
  }
}
