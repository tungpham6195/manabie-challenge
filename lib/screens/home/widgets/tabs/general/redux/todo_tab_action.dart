import 'package:manabie_todo_app/models/models.dart';
import 'package:redux/redux.dart';

part 'todo_tab_state.dart';

abstract class TodoTabAction {}

class TodoTabActionLoadData extends TodoTabAction {}

class TodoTabActionLoaded extends TodoTabAction {
  final List<Todo> items;

  TodoTabActionLoaded({this.items});
}

class TodoTabActionChangeStatus {}

class TodoTabActionChangedStatus {
  final List<Todo> items;
  final Todo todo;

  TodoTabActionChangedStatus({this.todo, this.items});
}

class TodoTabActionAddingItem {}

class TodoTabActionRemovingItem {}
