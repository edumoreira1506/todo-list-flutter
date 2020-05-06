import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todo_list/src/model/dto/todo.dart';
import 'package:todo_list/src/widgets/todo.dart';

class Todos extends StatelessWidget{
  final List<TodoDTO> items;

  Todos(this.items);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) => Todo(
          items[index].title,
          items[index].checked
        ),
        padding: EdgeInsets.only(top: 10),
        itemCount: this.items.length,
      )
    );
  }
}
