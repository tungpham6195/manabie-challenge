import 'package:manabie_todo_app/models/models.dart';
import 'package:manabie_todo_app/repositories/repositories.dart';
import 'package:manabie_todo_app/screens/home/widgets/tabs/all/controller/all_todo_tab_controller.dart';
import 'package:manabie_todo_app/screens/home/widgets/tabs/all/redux/all_todo_tab_action.dart';
import 'package:redux/redux.dart';

part 'all_todo_tab_view_interaction.dart';

part 'all_todo_tab_view_model_impl.dart';

abstract class AllTodoTabViewModel {
  factory AllTodoTabViewModel.init({
    Store<AllTodoTabState> store,
    TodoRepository todoRepository,
  }) =>
      TodoTabViewModelImpl._(
          allTodoTabStore: store, todoRepository: todoRepository);

  void loadToDoList();

  void updateStatus({Todo todo});

  void reloadTodoListWithUpdatedItem({Todo todo});

  void addTodo({Todo todo});

  void removeTodo({Todo todo});

  AllTodoTabViewModel._();
}
