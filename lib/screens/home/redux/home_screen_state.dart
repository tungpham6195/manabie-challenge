part of 'home_screen_action.dart';

class HomeScreenState {
  final int index;

  HomeScreenState._({this.index = 0});

  factory HomeScreenState.init() => HomeScreenState._();

  factory HomeScreenState.changeTab({int index}) =>
      HomeScreenState._(index: index);
}

class HomeScreenStateUpdateItem extends HomeScreenState {
  final Todo todo;

  HomeScreenStateUpdateItem({int index, this.todo}) : super._(index: index);
}

class HomeScreenStateAddedNewItem extends HomeScreenState {
  final Todo todo;

  HomeScreenStateAddedNewItem({int index, this.todo}) : super._(index: index);
}

class HomeScreenStateRemovedItem extends HomeScreenState {
  final Todo todo;

  HomeScreenStateRemovedItem({int index, this.todo}) : super._(index: index);
}

class HomeScreenStateAddNewItemFailed extends HomeScreenState {
  HomeScreenStateAddNewItemFailed({int index}) : super._(index: index);
}

class HomeScreenStateShowAddingDialog extends HomeScreenState {
  HomeScreenStateShowAddingDialog({int index}) : super._(index: index);
}

Reducer<HomeScreenState> homeScreenReducer = combineReducers([
  TypedReducer<HomeScreenState, HomeScreenActionChangeBottomTab>(
      (HomeScreenState state, action) {
    return HomeScreenState.changeTab(index: action.index);
  }),
  TypedReducer<HomeScreenState, HomeScreenActionUpdateItem>(
      (HomeScreenState state, action) {
    return HomeScreenStateUpdateItem(index: state.index, todo: action.todo);
  }),
  TypedReducer<HomeScreenState, HomeScreenActionAddNewTodo>(
      (HomeScreenState state, action) {
    return HomeScreenStateAddedNewItem(index: state.index, todo: action.todo);
  }),
  TypedReducer<HomeScreenState, HomeScreenActionRemoveTodo>(
      (HomeScreenState state, action) {
    return HomeScreenStateRemovedItem(index: state.index, todo: action.todo);
  }),
  TypedReducer<HomeScreenState, HomeScreenActionShowAddingDialog>(
      (HomeScreenState state, action) {
    return HomeScreenStateShowAddingDialog(index: state.index);
  }),
  TypedReducer<HomeScreenState, HomeScreenActionAddTodoFailed>(
      (HomeScreenState state, action) {
    return HomeScreenStateAddNewItemFailed(index: state.index);
  }),
]);
