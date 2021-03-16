part of 'all_todo_tab_view_model.dart';

abstract class AllTodoTabViewInteraction {
  void loadingData();

  void loadedData({List<Todo> items});

  void changingStatus();

  void changedStatus({List<Todo> items, Todo todo});

  void doNothing();

  void addingItem();

  void removingItem();

  AllTodoTabViewInteraction._();
}
