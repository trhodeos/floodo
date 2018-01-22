import 'package:floodo/todo_data.dart';
import 'package:flutter/material.dart';

class _TodoListItem extends StatelessWidget {
  final Todo _item;

  _TodoListItem(this._item);

  @override
  Widget build(BuildContext context) {
    return new Dismissible(
        key: new ObjectKey(_item.id),
        child: new ListTile(
            title: new Text(_item.title),
        ),
    );
    // TODO: implement build
  }
}

class TodoList extends StatelessWidget {
  final List<Todo> _todos;

  TodoList(this._todos);

  @override
  Widget build(BuildContext context) {
    return new ListView(
      children: _buildTodoList()
    );
  }

  List<_TodoListItem> _buildTodoList() {
    return _todos.map((t) => new _TodoListItem(t)).toList();
  }

}

class TodoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Todo")
      ),
      body: new TodoList(kTodos),
    );
  }
}

