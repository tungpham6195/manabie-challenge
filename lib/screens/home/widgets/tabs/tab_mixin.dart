import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:manabie_todo_app/models/models.dart';
import 'package:manabie_todo_app/screens/home/redux/home_screen_action.dart';
import 'package:redux/redux.dart';

mixin TabMixin<T extends StatefulWidget> on State<T> {
  StreamSubscription _homeScreenSub;

  Store<HomeScreenState> get _homeScreenStore =>
      StoreProvider.of<HomeScreenState>(context, listen: false);

  @override
  void initState() {
    super.initState();
    _homeScreenSub = _homeScreenStore.onChange.listen((state) {
      if (state is HomeScreenStateUpdateItem) {
        return onUpdateFromHomeScreen(todo: state.todo);
      }

      if (state is HomeScreenStateAddedNewItem) {
        return onAddingNewTodoFromHomeScreen(todo: state.todo);
      }

      if (state is HomeScreenStateRemovedItem) {
        return onRemovingTodo(todo: state.todo);
      }
    });
  }

  @override
  void dispose() {
    _homeScreenSub.cancel();
    super.dispose();
  }

  void onUpdateFromHomeScreen({Todo todo});

  void reloadHomeScreen({Todo todo}) {
    _homeScreenStore.dispatch(HomeScreenActionUpdateItem(todo: todo));
  }

  void onAddingNewTodoFromHomeScreen({Todo todo});

  void onRemovingTodo({Todo todo});

  void dispatchRemovingItem({Todo todo}) {
    _homeScreenStore.dispatch(HomeScreenActionRemoveTodo(todo: todo));
  }
}
