import 'package:manabie_todo_app/models/models.dart';
import 'package:manabie_todo_app/repositories/repositories.dart';
import 'package:manabie_todo_app/screens/home/widgets/tabs/all/view_model/all_todo_tab_view_model.dart';

class AllTodoTabController {
  final TodoRepository todoRepository;
  final AllTodoTabViewInteraction view;

  AllTodoTabController({this.todoRepository, this.view});

  List<Todo> items = [];

  void loadToDoList() async {
    view.loadingData();
    final response = await todoRepository.getToDoList();
    items = response;
    view.loadedData(items: items);
  }

  void updateStatus({Todo todo}) async {
    view.changingStatus();
    ToDoStatus status;
    if (todo.status == ToDoStatus.incomplete) {
      status = ToDoStatus.completed;
    } else {
      status = ToDoStatus.incomplete;
    }
    final response =
        await todoRepository.changeTodoStatus(todo: todo, status: status);
    todo = todo.copyWith(status: status);
    if (response) {
      _updateItemInList(todo: todo);
      view.changedStatus(items: items, todo: todo);
      return;
    }
    view.doNothing();
  }

  void reloadTodoListWithUpdatedItem({Todo todo}) {
    _updateItemInList(todo: todo);
    view.loadedData(items: items);
  }

  void _updateItemInList({Todo todo}) {
    final index = items.indexWhere((element) => element.id == todo.id);
    if (index >= 0) {
      items[index] = todo;
    }
  }

  void addItem({Todo todo}) {
    view.addingItem();
    items.add(todo);
    view.loadedData(items: items);
  }

  void removeItem({Todo todo}) {
    view.removingItem();
    items.removeWhere((element) => element.id == todo.id);
    view.loadedData(items: items);
  }
}
