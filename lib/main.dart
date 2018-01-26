
import 'package:floodo/module/module.dart';
import 'package:floodo/ui/todo_list.dart';

import 'package:flutter/material.dart';

void main() {
  serviceLocator = new ServiceLocator.fake();

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
      home: new TodoListPage()
    );
  }
}
