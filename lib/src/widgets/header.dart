import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Header extends StatelessWidget with PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('Todo List!'),
      centerTitle: true,
      backgroundColor: Colors.lightBlue
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
