import 'dart:async';

import 'package:floodo/data/todo_data.dart';

var kTodos = <Todo> [
  const Todo(id: 1, title: "Grocery shop"),
  const Todo(id: 2, title: "Play games", done: true),
];

class MockTodoRepository implements TodoRepository {
  int nextId = 3;
  @override
  Future<List<Todo>> fetch() {
    return new Future.value(kTodos);
  }

  @override
  Future<Todo> create(Todo todo) {
    return new Future.value(new Todo(id: nextId++, title: todo.title));
  }

  @override
  Future markAsDone(Todo remove) {
    kTodos.removeWhere((todo) => todo.id == remove.id);
    return new Future.value();
  }
}