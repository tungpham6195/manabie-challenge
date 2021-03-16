part of 'all_todo_tab_view_model.dart';

class TodoTabViewModelImpl extends AllTodoTabViewModel
    implements AllTodoTabViewInteraction {
  final Store<AllTodoTabState> allTodoTabStore;
  AllTodoTabController _controller;

  TodoTabViewModelImpl._({
    this.allTodoTabStore,
    TodoRepository todoRepository,
  }) : super._() {
    _controller =
        AllTodoTabController(view: this, todoRepository: todoRepository);
  }

  @override
  void changedStatus({List<Todo> items, Todo todo}) {
    allTodoTabStore
        .dispatch(AllTodoTabActionChangedStatus(items: items, todo: todo));
  }

  @override
  void changingStatus() {
    allTodoTabStore.dispatch(AllTodoTabActionChangeStatus());
  }

  @override
  void loadedData({List<Todo> items}) {
    allTodoTabStore.dispatch(AllTodoTabActionLoaded(items: items));
  }

  @override
  void loadingData() {
    allTodoTabStore.dispatch(AllTodoTabActionLoadData());
  }

  @override
  void loadToDoList() {
    _controller.loadToDoList();
  }

  @override
  void updateStatus({Todo todo}) {
    _controller.updateStatus(todo: todo);
  }

  @override
  void doNothing() {
    allTodoTabStore.dispatch(AllTodoTabActionDoNothing());
  }

  @override
  void reloadTodoListWithUpdatedItem({Todo todo}) {
    _controller.reloadTodoListWithUpdatedItem(todo: todo);
  }

  @override
  void addingItem() {
    allTodoTabStore.dispatch(AllTodoTabActionAddingItem());
  }

  @override
  void removingItem() {
    allTodoTabStore.dispatch(AllTodoTabActionRemovingItem());
  }

  @override
  void addTodo({Todo todo}) {
    _controller.addItem(todo: todo);
  }

  @override
  void removeTodo({Todo todo}) {
    _controller.removeItem(todo: todo);
  }
}
