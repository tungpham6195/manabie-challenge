import 'package:manabie_todo_app/models/models.dart';
import 'package:manabie_todo_app/services/todo/todo_service.dart';

part 'todo_repository_impl.dart';

abstract class TodoRepository {
  factory TodoRepository.init() =>
      TodoRepositoryImpl._(todoService: TodoService.init());

  Future<List<Todo>> getToDoList({ToDoStatus status});

  Future<bool> changeTodoStatus({Todo todo, ToDoStatus status});

  Future<Todo> addTodo({Todo todo});

  Future<bool> deleteTodo({Todo todo});

  TodoRepository._();
}
