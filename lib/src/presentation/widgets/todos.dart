import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todo_list/src/model/dto/todo.dart';
import 'package:todo_list/src/presentation/widgets/todo.dart';

class Todos extends StatelessWidget{
  final List<TodoDTO> items;
  final void Function(bool, int) onChanged;

  Todos(this.items, this.onChanged);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) => Todo(
          items[index].title,
          items[index].checked,
          (newValue) => this.onChanged(newValue, index)
        ),
        padding: EdgeInsets.only(top: 10),
        itemCount: this.items.length,
      )
    );
  }
}
