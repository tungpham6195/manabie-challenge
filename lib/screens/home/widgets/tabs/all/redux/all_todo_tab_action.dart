import 'package:manabie_todo_app/models/models.dart';
import 'package:redux/redux.dart';

part 'all_todo_tab_state.dart';

abstract class AllTodoTabAction {}

class AllTodoTabActionLoadData extends AllTodoTabAction {}

class AllTodoTabActionLoaded extends AllTodoTabAction {
  final List<Todo> items;

  AllTodoTabActionLoaded({this.items});
}

class AllTodoTabActionChangeStatus {}

class AllTodoTabActionChangedStatus {
  final List<Todo> items;
  final Todo todo;

  AllTodoTabActionChangedStatus({this.items, this.todo});
}

class AllTodoTabActionDoNothing extends AllTodoTabAction {}

class AllTodoTabActionAddingItem {}

class AllTodoTabActionRemovingItem {}
