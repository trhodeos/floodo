import 'package:floodo/data/todo_data.dart';
import 'package:floodo/modules/todo/todo_presenter.dart';
import 'package:flutter/material.dart';

class TodoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          title: new Text("Todos")
      ),
      body: new TodoList(),
    );
  }
}

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
  }
}

class TodoList extends StatefulWidget {
  TodoList({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState()  => new _TodoListState();
}

class _TodoListState extends State<TodoList> implements TodoListViewContract {

  TodoListPresenter _presenter;

  List<Todo> _todos = [];

  _TodoListState() {
    _presenter = new TodoListPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    _presenter.load();
  }

  @override
  void onLoadTodosComplete(List<Todo> items) {
    setState(() {
      _todos = items;
    });
  }

  @override
  void onLoadTodosError() {
    // TODO: implement onLoadTodosError
  }

  _removeItem(Todo todo) {
    setState(() {
      _todos.remove(todo);
      _presenter.remove(todo);
    });
  }

  _buildTodoList() {
    return _todos.map((t) => new Dismissible(
        key: new ObjectKey(t),
        onDismissed: (d) => _removeItem(t),
        child: new _TodoListItem(t))).toList();
  }

  @override
  Widget build(BuildContext context) {
    return new ListView(
        padding: new EdgeInsets.symmetric(vertical: 8.0),
        children: _buildTodoList());
  }
}

