part of 'home_screen_view_model.dart';

class HomeScreenViewModelImpl extends HomeScreenViewModel
    implements HomeScreenViewInteraction {
  final Store<HomeScreenState> homeScreenStateStore;
  HomeScreenController controller;

  HomeScreenViewModelImpl._(
      {this.homeScreenStateStore, TodoRepository todoRepository})
      : super._() {
    controller = HomeScreenController(
      view: this,
      todoRepository: todoRepository,
    );
  }

  @override
  void changeTab(int index) {
    homeScreenStateStore
        .dispatch(HomeScreenActionChangeBottomTab(index: index));
  }

  @override
  void addedTodo({Todo todo}) {
    homeScreenStateStore.dispatch(HomeScreenActionAddNewTodo(todo: todo));
  }

  @override
  void showAddingDialog() {
    homeScreenStateStore.dispatch(HomeScreenActionShowAddingDialog());
  }

  @override
  void addItem({String description}) {
    controller.addNewItem(description: description);
  }

  @override
  void addTodoFailed() {
    homeScreenStateStore.dispatch(HomeScreenActionAddTodoFailed());
  }
}
