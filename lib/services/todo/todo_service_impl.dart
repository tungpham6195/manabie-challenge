part of 'todo_service.dart';

class TodoServiceImpl implements TodoService {
  TodoServiceImpl._();

  @override
  Future<List<Todo>> getTodoList({ToDoStatus status}) async {
    return _data.values.toList()
      ..removeWhere(
          (element) => status == null ? false : status != element.status);
  }

  @override
  Future<bool> updateTodoStatus({Todo todo}) async {
    if (_data.containsKey(todo.id)) {
      _data[todo.id] = todo;
      return true;
    }
    return false;
  }

  @override
  Future<Todo> addTodo({Todo todo}) async {
    final id = _data.length;
    return _data.putIfAbsent(id, () => todo.copyWith(id: id));
  }

  @override
  Future<bool> deleteTodo({int todoId}) async {
    final result = _data.remove(todoId);
    if (result != null) return true;
    return false;
  }
}

final _data = Map.of(List<Todo>.generate(20,
        (index) => Todo(id: index, description: 'This is TODO ${index + 1}'))
    .asMap());
