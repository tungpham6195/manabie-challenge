import 'package:manabie_todo_app/models/models.dart';

part 'todo_service_impl.dart';

abstract class TodoService {
  factory TodoService.init() => TodoServiceImpl._();

  Future<List<Todo>> getTodoList({ToDoStatus status});

  Future<bool> updateTodoStatus({Todo todo});

  Future<Todo> addTodo({Todo todo});

  Future<bool> deleteTodo({int todoId});

  TodoService._();
}
