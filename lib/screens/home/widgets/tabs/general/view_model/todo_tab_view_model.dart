import 'package:manabie_todo_app/models/models.dart';
import 'package:manabie_todo_app/repositories/repositories.dart';
import 'package:manabie_todo_app/screens/home/widgets/tabs/general/controller/todo_tab_controller.dart';
import 'package:manabie_todo_app/screens/home/widgets/tabs/general/redux/todo_tab_action.dart';
import 'package:redux/redux.dart';

part 'todo_tab_view_interaction.dart';

part 'todo_tab_view_model_impl.dart';

abstract class TodoTabViewModel {
  factory TodoTabViewModel.init({
    Store<TodoTabState> toDoTabStore,
    ToDoStatus status,
    TodoRepository todoRepository,
  }) =>
      TodoTabViewModelImpl._(
          toDoTabStore: toDoTabStore,
          status: status,
          todoRepository: todoRepository);

  void loadToDoList();

  void updateStatus({Todo todo});

  void updateList({Todo todo});

  void removeItem({Todo todo});

  TodoTabViewModel._();
}
