import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Todo extends StatelessWidget{
  final String title;
  final bool checked;
  final void Function(bool) onChanged;
  final void Function(DismissDirection) onDelete;

  Todo(this.title, this.checked, this.onChanged, this.onDelete);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      onDismissed: this.onDelete,
      key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
      background: Container(
        color: Colors.red,
        child: Align(
          alignment: Alignment(-0.9, 0),
          child: Icon(
            Icons.delete,
            color: Colors.white
          )
        ),
      ),
      direction: DismissDirection.startToEnd,
      child: CheckboxListTile(
        title: Text(this.title),
        value: this.checked,
        secondary: CircleAvatar(
          child: Icon(
            this.checked ? Icons.check : Icons.error
          )
        ),
        onChanged: (newValue) => this.onChanged(newValue),
      )
    );
  }
}
