import 'dart:io';
import 'package:path_provider/path_provider.dart';

import 'package:floodo/todo.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Floodo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new FloodoList(title: 'Floodo'),
    );
  }
}

class FloodoList extends StatefulWidget {
  FloodoList({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _FloodoListState createState() => new _FloodoListState();
}

class _FloodoListState extends State<FloodoList> {
  List<Todo> items = [];
  TodoProvider dbProvider;

  @override
  void initState() {
    super.initState();
    dbProvider = new TodoProvider();
    initData();
  }

  initData() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "todo.db");
    await dbProvider.open(path);
    print('Opening db at $path');
    Iterable<Todo> todos = await dbProvider.getUnfinishedTodos();
    setState(() {
      items.clear();
      items.addAll(todos);
    });
  }

  Widget buildItem(Todo item) {
    return new Dismissible(
        onDismissed: (d) {
          setState(() {
            item.completionTime = new DateTime.now();
            dbProvider.update(item);
            items.remove(item);
          });
        },
        child: new ListTile(title: new Text(item.title)),
        key: new ObjectKey(item));
  }

  addItem(String text) async {
    var enteredTime = new DateTime.now();
    Todo todo = new Todo(text, enteredTime);
    setState(() {
      items.add(todo);
    });
    return dbProvider.insert(todo);
  }

  removeItem(int id) async {}

  @override
  Widget build(BuildContext context) {
    var itemWidgets = items.map(buildItem).toList();
    itemWidgets.add(
        new TextField(onSubmitted: (text) =>
            setState(() => addItem(text))));
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Column(children: itemWidgets),
    );
  }
}
