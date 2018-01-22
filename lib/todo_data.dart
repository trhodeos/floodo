class Todo {
  final int id;
  final String title;
  final bool done;

  const Todo({this.id, this.title, this.done=false});
}

const kTodos = const <Todo> [
  const Todo(id: 1, title: "Grocery shop"),
  const Todo(id: 2, title: "Play games", done: true),
];
