import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:todo_list/src/model/dto/todo.dart';

class TodoService {
  String _serializeTodos(List<TodoDTO> todos) {
    List<Map<String, dynamic>> todosMap = todos.map((todo) {
      Map<String, dynamic> map = new Map();

      map['checked'] = todo.checked;
      map['title'] = todo.title;

      return map;
    }).toList();

    return json.encode(todosMap);
  }

  Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory();

    return File("${directory.path}/data.json");
  }

  Future<File> persist(List<TodoDTO> todos) async {
    String data = _serializeTodos(todos);

    final file = await _getFile();

    return file.writeAsString(data);
  }

  Future<String> all() async {
    try {
      final file = await _getFile();

      return file.readAsString();
    } catch (e) {
      return null;
    }
  }

  List<TodoDTO> unserializeTodos(String data) {
    List todosMap = json.decode(data);

    return todosMap.map((todo) => TodoDTO(checked: todo['checked'], title: todo['title'])).toList();
  }
}
