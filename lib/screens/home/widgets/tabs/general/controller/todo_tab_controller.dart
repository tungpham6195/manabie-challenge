import 'package:manabie_todo_app/models/models.dart';
import 'package:manabie_todo_app/repositories/repositories.dart';
import 'package:manabie_todo_app/screens/home/widgets/tabs/general/view_model/todo_tab_view_model.dart';

class TodoTabController {
  final ToDoStatus status;
  final TodoRepository todoRepository;
  final TodoTabViewInteraction view;

  TodoTabController({
    this.view,
    this.status,
    this.todoRepository,
  });

  List<Todo> items = [];

  void loadToDoList() async {
    view.loadingData();
    final response = await todoRepository.getToDoList(
      status: status,
    );
    items = response;
    view.loadedData(items: items);
  }

  void updateStatus({Todo todo}) async {
    view.changingStatus();
    ToDoStatus newStatus;
    if (todo.status == ToDoStatus.incomplete) {
      newStatus = ToDoStatus.completed;
    } else {
      newStatus = ToDoStatus.incomplete;
    }
    final response =
        await todoRepository.changeTodoStatus(todo: todo, status: newStatus);
    todo = todo.copyWith(status: newStatus);
    if (response) {
      items.removeWhere((element) => element.id == todo.id);
    }
    view.changedStatus(items: items, todo: todo);
  }

  void addItem({Todo todo}) {
    view.addingItem();
    items.add(todo);
    view.loadedData(items: items);
  }

  void removeItem({Todo todo}) {
    final index = items.indexWhere((element) => element.id == todo.id);
    if (index.isNegative) return;
    view.removingItem();
    items.removeWhere((element) => element.id == todo.id);
    view.removedItem(items: items, todo: todo);
  }

  void updateList({Todo todo}) {
    if (todo.status == status) {
      return addItem(todo: todo);
    }
    removeItem(todo: todo);
  }
}
