part of 'todo_tab_view_model.dart';

class TodoTabViewModelImpl extends TodoTabViewModel
    implements TodoTabViewInteraction {
  final Store<TodoTabState> toDoTabStore;
  TodoTabController _controller;

  TodoTabViewModelImpl._({
    this.toDoTabStore,
    ToDoStatus status,
    TodoRepository todoRepository,
  }) : super._() {
    _controller = TodoTabController(
        view: this, status: status, todoRepository: todoRepository);
  }

  @override
  void addingItem() {
    toDoTabStore.dispatch(TodoTabActionAddingItem());
  }

  @override
  void removingItem() {
    toDoTabStore.dispatch(TodoTabActionRemovingItem());
  }

  @override
  void changedStatus({List<Todo> items, Todo todo}) {
    toDoTabStore.dispatch(TodoTabActionChangedStatus(items: items, todo: todo));
  }

  @override
  void changingStatus() {
    toDoTabStore.dispatch(TodoTabActionChangeStatus());
  }

  @override
  void loadedData({List<Todo> items}) {
    toDoTabStore.dispatch(TodoTabActionLoaded(items: items));
  }

  @override
  void loadingData() {
    toDoTabStore.dispatch(TodoTabActionLoadData());
  }

  @override
  void loadToDoList() {
    _controller.loadToDoList();
  }

  @override
  void removeItem({Todo todo}) {
    _controller.removeItem(todo: todo);
  }

  @override
  void updateStatus({Todo todo}) {
    _controller.updateStatus(todo: todo);
  }

  @override
  void updateList({Todo todo}) {
    _controller.updateList(todo: todo);
  }

  @override
  void removedItem({Todo todo, List<Todo> items}) {
    toDoTabStore.dispatch(TodoTabActionRemovedItem(todo: todo, items: items));
  }
}
