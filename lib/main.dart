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

class FloodoList extends StatefulWidget {
  FloodoList({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _FloodoListState createState() => new _FloodoListState();
}

class _FloodoListState extends State<FloodoList> {
  var items = ['test', 'two', 'three'];

  Widget buildItem(name) {
    return new Dismissible(onDismissed: (DismissDirection d) {
      setState(() {
        items.remove(name);
      });
    }, child: new ListTile(title: new Text(name)), key: new ObjectKey(name));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new ListView(children: items.map(buildItem).toList(),),
    );
  }
}
