import 'package:floodo/entities/todo_item.dart';
import 'package:floodo/module/module.dart';
import 'package:floodo/state/subscribing_state.dart';
import 'package:floodo/state/todo_item_mutator.dart';
import 'package:floodo/state/todo_item_store.dart';
import 'package:flutter/material.dart';

class TodoListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _TodoListPageState();
}

class _TodoListPageState extends SubscribingState<TodoListPage> {
  final TodoItemStore todoItemStore = serviceLocator.todoItemStore;
  final TodoItemMutator todoItemMutator = serviceLocator.todoItemMutator;

  _TodoListPageState() : super([serviceLocator.todoItemStore]);

  @override
  Widget build(BuildContext context) {
    var items = todoItemStore.get(new TodoItemListParam())?.toList() ??
        const [];
    print('Todos: ${items.length}');
    return new Scaffold(
      appBar: new AppBar(title: new Text('Todos')),
      body: new Container(
        color: new Color.fromRGBO(0, 0, 0, 0.08),
        child: new ListView(
          children: items.map(_buildItem).toList(),
          reverse: true,
        ),
      ),
    );
  }

  Widget _buildItem(TodoItem todoItem) {
    var textTheme = Theme
        .of(context)
        .textTheme;
    var textAlign = TextAlign.left;

    return new Dismissible(
      key: new ObjectKey(todoItem),
      onDismissed: (d) {
        TodoItem done = new TodoItem(
            id: todoItem.id, title: todoItem.title, done: true);
        todoItemMutator.submit(done);
      },
      child: new Card(
        elevation: 2.0,
        child: new Container(
          constraints: const BoxConstraints(maxWidth: 240.0, minWidth: 60.0),
          margin: const EdgeInsets.all(8.0),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              new Text(
                todoItem.title,
                style: textTheme.body1.copyWith(color: Colors.black38),
                textAlign: textAlign,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

