import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
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
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: new Text(widget.title),
      ),
      body: new ListView(children: items.map(buildItem).toList(),),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
