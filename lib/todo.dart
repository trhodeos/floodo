import 'dart:async';
import 'package:sqflite/sqflite.dart';


final String tableTodo = "todo";
final String columnId = "_id";
final String columnTitle = "title";
final String columnEnteredTime = "entered_time_ms";
final String columnCompletionTime = "finished_time_ms";

class Todo {
  int id;
  String title;
  DateTime enteredTime;
  // If completionTime is not null, task is finished
  DateTime completionTime;

  Map toMap() {
    Map map = {};
    map[columnTitle] = title;
    map[columnEnteredTime] = enteredTime.millisecondsSinceEpoch;
    if (completionTime != null) {
      map[columnCompletionTime] = completionTime.millisecondsSinceEpoch;
    }
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  Todo(this.title, this.enteredTime);

  Todo.fromMap(Map map) {
    id = map[columnId];
    title = map[columnTitle];
    enteredTime = new DateTime.fromMillisecondsSinceEpoch(map[columnEnteredTime]);
    if (map.containsKey(columnCompletionTime) && map[columnCompletionTime] != null) {
      completionTime = new DateTime.fromMillisecondsSinceEpoch(map[columnCompletionTime]);
    }
  }
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
    todo.id = await db.insert(tableTodo, todo.toMap());
    return todo;
  }

  Future<Todo> getTodo(int id) async {
    List<Map> maps = await db.query(tableTodo,
        columns: [columnId, columnEnteredTime, columnCompletionTime, columnTitle],
        where: "$columnId = ?",
        whereArgs: [id]);
    if (maps.length > 0) {
      return new Todo.fromMap(maps.first);
    }
    return null;
  }

  Future<Iterable<Todo>> getUnfinishedTodos() async {
    List<Map> maps = await db.query(tableTodo,
        columns: [columnId, columnEnteredTime, columnCompletionTime, columnTitle],
        where: "$columnCompletionTime IS NULL");
    return maps.map((m) => new Todo.fromMap(m));
  }

  Future<int> deleteTodo(int id) async {
    return await db.delete(tableTodo, where: "$columnId = ?", whereArgs: [id]);
  }

  Future<int> update(Todo todo) async {
    return await db.update(tableTodo, todo.toMap(),
        where: "$columnId = ?", whereArgs: [todo.id]);
  }

  Future close() async => db.close();
}