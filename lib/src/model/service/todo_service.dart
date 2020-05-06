import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class TodoService {
  Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory();

    return File("${directory.path}/data.json");
  }

  Future<File> persist(todos) async {
    String data = json.encode(todos);

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
}
