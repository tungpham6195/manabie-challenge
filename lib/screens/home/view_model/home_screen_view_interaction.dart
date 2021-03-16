part of 'home_screen_view_model.dart';

abstract class HomeScreenViewInteraction {
  void addedTodo({Todo todo});

  void addTodoFailed();
}
