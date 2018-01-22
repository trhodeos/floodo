import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:floodo/todo_data.dart';

final String tableTodo = "todo";
final String columnId = "_id";
final String columnTitle = "title";
final String columnEnteredTime = "entered_time_ms";
final String columnCompletionTime = "finished_time_ms";


Map _toMap(Todo todo) {
  Map map = {};
  map[columnTitle] = todo.title;
  if (todo.id != null) {
    map[columnId] = todo.id;
  }
  return map;
}

Todo _fromMap(Map map) {
  return new Todo(
    id: map[columnId],
    title: map[columnTitle],
  );
}

class TodoProvider {
  Database db;

  Future open(String path) async {
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          await db.execute('''
create table $tableTodo ( 
  $columnId integer primary key autoincrement, 
  $columnTitle text not null,
  $columnEnteredTime integer not null,
  $columnCompletionTime integer)
''');
        });
  }

  Future<Todo> insert(Todo todo) async {
    var id = await db.insert(tableTodo, _toMap(todo));
    return new Todo(id: id, title: todo.title);
  }

  Future<Todo> getTodo(int id) async {
    List<Map> maps = await db.query(tableTodo,
        columns: [columnId, columnEnteredTime, columnCompletionTime, columnTitle],
        where: "$columnId = ?",
        whereArgs: [id]);
    if (maps.length > 0) {
      return _fromMap(maps.first);
    }
    return null;
  }

  Future<Iterable<Todo>> getUnfinishedTodos() async {
    List<Map> maps = await db.query(tableTodo,
        columns: [columnId, columnEnteredTime, columnCompletionTime, columnTitle],
        where: "$columnCompletionTime IS NULL");
    return maps.map((m) => _fromMap(m));
  }

  Future<int> deleteTodo(int id) async {
    return await db.delete(tableTodo, where: "$columnId = ?", whereArgs: [id]);
  }

  Future<int> update(Todo todo) async {
    return await db.update(tableTodo, _toMap(todo),
        where: "$columnId = ?", whereArgs: [todo.id]);
  }

  Future close() async => db.close();
}