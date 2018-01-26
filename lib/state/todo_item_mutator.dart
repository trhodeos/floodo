import 'dart:async';

import 'package:floodo/entities/todo_item.dart';
import 'package:floodo/fake/db.dart';
import 'package:floodo/state/mutator.dart';


class TodoItemMutator extends Mutator<TodoItem> {

  TodoItemMutator();

  @override
  Future<Error> submit(TodoItem newEntity) async {
    notify();
    return null;
  }
}

class FakeTodoItemMutator extends Mutator<TodoItem> implements TodoItemMutator {

  @override
  Future<Error> submit(TodoItem newEntity) async {
    todoItems[newEntity.id] = newEntity;
    notify();
    return null;
  }
}