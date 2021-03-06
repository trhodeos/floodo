import 'dart:async';

class Todo {
  final int id;
  final String title;
  final bool done;

  const Todo({this.id, this.title, this.done=false});
}

abstract class TodoRepository {
  Future<List<Todo>> fetch();
  Future<Todo> create(Todo push);
  Future markAsDone(Todo remove);
}

class FetchTodoException implements Exception {
  String _message;
  FetchTodoException(this._message);

  String toString() {
    return "Exception: $_message";
  }
}
