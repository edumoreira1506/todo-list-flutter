import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Todo extends StatelessWidget{
  final String title;
  final bool checked;

  Todo(this.title, this.checked);

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(this.title),
      value: this.checked,
      secondary: CircleAvatar(
        child: Icon(
          this.checked ? Icons.check : Icons.error
        )
      ),
      onChanged: (newValue) { },
    );
  }
}
