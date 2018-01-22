import 'package:floodo/data/todo_data_impl.dart';
import 'package:floodo/data/todo_data_mock.dart';
import 'package:floodo/data/todo_data.dart';


enum Flavor {
  mock,
  prod
}

class Injector {
  static final Injector _singleton = new Injector._internal();
  static Flavor _flavor;

  static void configure(Flavor flavor) {
    _flavor = flavor;
  }

  factory Injector() {
    return _singleton;
  }

  Injector._internal();

  TodoRepository get todoRepository {
    switch(_flavor) {
      case Flavor.prod:
        return new SqliteTodoRepository();
      default: return new MockTodoRepository();
    }
  }
}