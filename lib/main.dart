
import 'package:floodo/injection/dependency_injection.dart';
import 'package:floodo/modules/todo/todo_view.dart';

import 'package:flutter/material.dart';

void main() {
  Injector.configure(Flavor.mock);

  runApp(new FloodoApp());
}

class FloodoApp extends StatelessWidget {
  FloodoApp();

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Floodo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new TodoPage()
    );
  }
}
