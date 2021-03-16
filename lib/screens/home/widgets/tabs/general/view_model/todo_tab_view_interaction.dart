part of 'todo_tab_view_model.dart';

abstract class TodoTabViewInteraction {
  void loadingData();

  void loadedData({List<Todo> items});

  void changingStatus();

  void changedStatus({List<Todo> items, Todo todo});

  void addingItem();

  void removingItem();

  void removedItem({Todo todo, List<Todo> items});

  TodoTabViewInteraction._();
}
