import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:floodo/data/todo_data.dart';

import 'package:path_provider/path_provider.dart';

final String tableTodo = "todo";
final String columnId = "_id";
final String columnTitle = "title";
final String columnEnteredTime = "entered_time_ms";
final String columnDone = "done";


Map _toSqlMap(Todo todo) {
  Map map = {};
  map[columnTitle] = todo.title;
  if (todo.id != null) {
    map[columnId] = todo.id;
  }
  map[columnEnteredTime] = new DateTime.now().millisecondsSinceEpoch;
  map[columnDone] = todo.done ? 1 : 0;
  return map;
}

Todo _fromSqlMap(Map map) {
  return new Todo(
    id: map[columnId],
    title: map[columnTitle],
    done: map[columnDone] == 1 ? true : false,
  );
}

class SqliteTodoRepository implements TodoRepository {
  Future<Database> db;

  SqliteTodoRepository() {
    Future<Directory> documentsDirectory = getApplicationDocumentsDirectory();
    Future<String> path = documentsDirectory.then((d) => join(d.path, "todo.db"));
    db = path.then((p) => openDatabase(p, version: 1,
        onCreate: (Database db, int version) async {
          await db.execute('''
create table $tableTodo ( 
  $columnId integer primary key autoincrement, 
  $columnTitle text not null,
  $columnEnteredTime integer not null,
  $columnDone integer not null)
''');
        }));
  }

  @override
  Future<Todo> create(Todo todo) async {
    var id = await db.then((d) => d.insert(tableTodo, _toSqlMap(todo)));
    return new Todo(id: id, title: todo.title);
  }

  @override
  Future<List<Todo>> fetch() async {
    List<Map> maps = await db.then((d) => d.query(tableTodo,
        columns: [columnId, columnEnteredTime, columnDone, columnTitle],
        where: "$columnDone == 0"));
    return new Future.value(maps.map((m) => _fromSqlMap(m)).toList());
  }

  @override
  Future markAsDone(Todo remove) async {
    Todo newTodo = new Todo(id: remove.id, title: remove.title, done: true);
    return db.then((d) {
      d.update(
          tableTodo,
          _toSqlMap(newTodo),
          where: "$columnId = ?",
          whereArgs: [newTodo.id]);
    });
  }
}
