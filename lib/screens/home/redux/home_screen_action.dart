import 'package:manabie_todo_app/models/models.dart';
import 'package:redux/redux.dart';

part 'home_screen_state.dart';

class HomeScreenActionChangeBottomTab {
  final int index;

  HomeScreenActionChangeBottomTab({this.index});
}

class HomeScreenActionUpdateItem {
  final Todo todo;

  HomeScreenActionUpdateItem({this.todo});
}

class HomeScreenActionAddNewTodo {
  final Todo todo;

  HomeScreenActionAddNewTodo({this.todo});
}

class HomeScreenActionAddTodoFailed {}

class HomeScreenActionRemoveTodo {
  final Todo todo;

  HomeScreenActionRemoveTodo({this.todo});
}

class HomeScreenActionShowAddingDialog {}
