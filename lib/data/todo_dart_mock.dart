import 'dart:async';

import 'package:floodo/data/todo_data.dart';

const kTodos = const <Todo> [
  const Todo(id: 1, title: "Grocery shop"),
  const Todo(id: 2, title: "Play games", done: true),
];

class MockTodoRepository implements TodoRepository {
  @override
  Future<List<Todo>> fetch() {
    return new Future.value(kTodos);
  }
}