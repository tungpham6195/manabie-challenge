part of 'todo_repository.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoService todoService;

  TodoRepositoryImpl._({this.todoService});

  @override
  Future<List<Todo>> getToDoList({ToDoStatus status}) {
    return todoService.getTodoList(status: status);
  }

  @override
  Future<bool> changeTodoStatus({Todo todo, ToDoStatus status}) {
    return todoService.updateTodoStatus(
        todo: todo.copyWith(
      status: status,
    ));
  }

  @override
  Future<Todo> addTodo({Todo todo}) {
    if (todo == null) return null;
    if (todo.description == null || todo.description.isEmpty) return null;
    return todoService.addTodo(todo: todo);
  }

  @override
  Future<bool> deleteTodo({Todo todo}) {
    return todoService.deleteTodo(todoId: todo?.id);
  }
}
