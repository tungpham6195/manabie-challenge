part of 'all_todo_tab_action.dart';

class AllTodoTabState {
  final List<Todo> items;
  final bool loading;

  AllTodoTabState._({
    this.items = const [],
    this.loading = false,
  });

  factory AllTodoTabState.initial() => AllTodoTabState._();

  factory AllTodoTabState.loading({List<Todo> items}) =>
      AllTodoTabState._(loading: true, items: items);

  factory AllTodoTabState.loaded({List<Todo> items}) =>
      AllTodoTabState._(items: items);

  factory AllTodoTabState.changingStatus({List<Todo> items}) =>
      AllTodoTabState._(loading: true, items: items);

  factory AllTodoTabState.doNothing({List<Todo> items}) =>
      AllTodoTabState._(items: items);

  factory AllTodoTabState.addingTodo({List<Todo> items}) =>
      AllTodoTabState._(loading: true, items: items);

  factory AllTodoTabState.removingTodo({List<Todo> items}) =>
      AllTodoTabState._(loading: true, items: items);
}

class AllTodoTabStateChangedStatus extends AllTodoTabState {
  final Todo todo;

  AllTodoTabStateChangedStatus({this.todo, List<Todo> items})
      : super._(
          loading: false,
          items: items,
        );
}

final Reducer<AllTodoTabState> allTodoTabReducer =
    combineReducers<AllTodoTabState>([
  TypedReducer<AllTodoTabState, AllTodoTabActionLoadData>((state, action) {
    return AllTodoTabState.loading(items: state.items);
  }),
  TypedReducer<AllTodoTabState, AllTodoTabActionLoaded>((state, action) {
    return AllTodoTabState.loaded(items: action.items);
  }),
  TypedReducer<AllTodoTabState, AllTodoTabActionChangeStatus>((state, action) {
    return AllTodoTabState.changingStatus(items: state.items);
  }),
  TypedReducer<AllTodoTabState, AllTodoTabActionChangedStatus>((state, action) {
    return AllTodoTabStateChangedStatus(items: action.items, todo: action.todo);
  }),
  TypedReducer<AllTodoTabState, AllTodoTabActionDoNothing>((state, action) {
    return AllTodoTabState.doNothing(items: state.items);
  }),
  TypedReducer<AllTodoTabState, AllTodoTabActionAddingItem>((state, action) {
    return AllTodoTabState.addingTodo(items: state.items);
  }),
  TypedReducer<AllTodoTabState, AllTodoTabActionRemovingItem>((state, action) {
    return AllTodoTabState.removingTodo(items: state.items);
  }),
]);
