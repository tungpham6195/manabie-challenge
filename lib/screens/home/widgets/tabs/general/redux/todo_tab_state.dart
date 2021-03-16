part of 'todo_tab_action.dart';

class TodoTabState {
  final List<Todo> items;
  final bool loading;

  TodoTabState._({
    this.items = const [],
    this.loading = false,
  });

  factory TodoTabState.initial() => TodoTabState._();

  factory TodoTabState.loading({List<Todo> items}) =>
      TodoTabState._(loading: true, items: items);

  factory TodoTabState.loaded({List<Todo> items}) =>
      TodoTabState._(items: items);

  factory TodoTabState.changingStatus({List<Todo> items}) =>
      TodoTabState._(loading: true, items: items);

  factory TodoTabState.addingTodo({List<Todo> items}) =>
      TodoTabState._(loading: true, items: items);

  factory TodoTabState.removingTodo({List<Todo> items}) =>
      TodoTabState._(loading: true, items: items);
}

class TodoTabStateChangedStatus extends TodoTabState {
  final Todo todo;

  TodoTabStateChangedStatus({this.todo, List<Todo> items})
      : super._(
          loading: false,
          items: items,
        );
}

class TodoTabStateRemovedItem extends TodoTabState {
  final Todo todo;

  TodoTabStateRemovedItem({this.todo, List<Todo> items})
      : super._(
          loading: false,
          items: items,
        );
}

final Reducer<TodoTabState> todoTabReducer = combineReducers<TodoTabState>([
  TypedReducer<TodoTabState, TodoTabActionLoadData>((state, action) {
    return TodoTabState.loading(items: state.items);
  }),
  TypedReducer<TodoTabState, TodoTabActionLoaded>((state, action) {
    return TodoTabState.loaded(items: action.items);
  }),
  TypedReducer<TodoTabState, TodoTabActionChangeStatus>((state, action) {
    return TodoTabState.changingStatus(items: state.items);
  }),
  TypedReducer<TodoTabState, TodoTabActionChangedStatus>((state, action) {
    return TodoTabStateChangedStatus(items: action.items, todo: action.todo);
  }),
  TypedReducer<TodoTabState, TodoTabActionAddingItem>((state, action) {
    return TodoTabState.addingTodo(items: state.items);
  }),
  TypedReducer<TodoTabState, TodoTabActionRemovingItem>((state, action) {
    return TodoTabState.removingTodo(items: state.items);
  }),
  TypedReducer<TodoTabState, TodoTabActionRemovedItem>((state, action) {
    return TodoTabStateRemovedItem(items: action.items, todo: action.todo);
  }),
]);
