import 'package:floodo/data/todo_data.dart';
import 'package:floodo/injection/dependency_injection.dart';

abstract class TodoListViewContract {
  void onLoadTodosComplete(List<Todo> items);
  void onLoadTodosError();
}

class TodoListPresenter {
  TodoListViewContract _view;
  TodoRepository _repository;

  TodoListPresenter(this._view) {
    _repository = new Injector().todoRepository;
  }

  void load() {
    assert(_view != null);

    _repository.fetch().then(_view.onLoadTodosComplete).catchError((onError) {
      print(onError);
      _view.onLoadTodosError();
    });
  }

  void remove(Todo todo) {
    _repository.markAsDone(todo);
  }
}