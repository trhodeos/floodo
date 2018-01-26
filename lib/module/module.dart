import 'package:floodo/state/todo_item_mutator.dart';
import 'package:floodo/state/todo_item_store.dart';


class ServiceLocator {
  final TodoItemStore todoItemStore;

  final TodoItemMutator todoItemMutator;

  ServiceLocator._(this.todoItemStore, this.todoItemMutator);

  factory ServiceLocator.fake() {
    var todoItemMutator = new FakeTodoItemMutator();
    var todoItemStore = new FakeTodoItemStore(todoItemMutator);
    return new ServiceLocator._(todoItemStore, todoItemMutator);
  }
}

ServiceLocator serviceLocator;