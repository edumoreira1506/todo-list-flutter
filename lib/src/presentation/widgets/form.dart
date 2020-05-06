import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FormTodo extends StatelessWidget{
  final TextEditingController controller;
  final void Function() onSubmit;

  FormTodo(this.controller, this.onSubmit);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(17, 1, 17, 1),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: this.controller,
              decoration: InputDecoration(
                labelText: "Nova Tarefa",
                labelStyle: TextStyle(
                  color: Colors.lightBlue
                )
              ),
            )
          ),
          RaisedButton(
            color: Colors.lightBlue,
            child: Text("ADD"),
            textColor: Colors.white,
            onPressed: this.onSubmit,
          )
        ],
      )
    );
  }
}