import 'package:flutter/material.dart';

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

class TodoItem {
  String text;

  TodoItem(this.text);
}

class FloodoList extends StatefulWidget {
  FloodoList({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _FloodoListState createState() => new _FloodoListState();
}

class _FloodoListState extends State<FloodoList> {
  var items = [];

  Widget buildItem(item) {
    return new Dismissible(onDismissed: (d) {
      setState(() {
        items.remove(item);
      });
    },
        child: new ListTile(title: new Text(item.text)),
        key: new ObjectKey(item));
  }

  @override
  Widget build(BuildContext context) {
    var itemWidgets = items.map(buildItem).toList();
    itemWidgets.add(
        new TextField(onSubmitted: (text) =>
            setState(() => items.add(new TodoItem(text)))));
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Column(children: itemWidgets),
    );
  }
}
