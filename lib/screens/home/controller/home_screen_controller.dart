import 'package:manabie_todo_app/models/models.dart';
import 'package:manabie_todo_app/repositories/repositories.dart';
import 'package:manabie_todo_app/screens/home/view_model/home_screen_view_model.dart';

class HomeScreenController {
  final HomeScreenViewInteraction view;
  final TodoRepository todoRepository;

  HomeScreenController({this.view, this.todoRepository});

  void addNewItem({String description}) async {
    final newTodo = Todo(description: description);
    final result = await todoRepository.addTodo(todo: newTodo);
    if (result != null) {
      return view.addedTodo(todo: result);
    }
    view.addTodoFailed();
  }
}
