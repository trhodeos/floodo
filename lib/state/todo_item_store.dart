import 'dart:async';

import 'package:floodo/entities/todo_item.dart';
import 'package:floodo/fake/db.dart';
import 'package:floodo/state/store.dart';
import 'package:floodo/state/todo_item_mutator.dart';


class TodoItemListParam {
  final bool done;
  final int limit;

  TodoItemListParam({this.done: false, this.limit: 50});

  @override
  operator ==(Object other) =>
      other is TodoItemListParam ? done == other.done && limit == other.limit : false;

  @override
  int get hashCode => done ? 5000 : -5000 + limit;

}

class TodoItemStore extends Store<TodoItemListParam, List<TodoItem>> {

  @override
  Stream<List<TodoItem>> load(TodoItemListParam params) async* {
    yield [];
  }
}

class FakeTodoItemStore extends Store<TodoItemListParam, List<TodoItem>> implements TodoItemStore {

  final TodoItemMutator todoItemMutator;
  FakeTodoItemStore(this.todoItemMutator) {
    todoItemMutator.subscribe(this, () {
      notify();
    });
  }

  @override
  Stream<List<TodoItem>> load(TodoItemListParam params) async* {
    yield todoItems.values.where((t) => t.done == params.done).toList();
  }
}