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
        return updateFromHomeScreen(todo: state.todo);
      }

      if (state is HomeScreenStateAddedNewItem) {
        return addNewTodoFromHomeScreen(todo: state.todo);
      }

      if (state is HomeScreenStateRemovedItem) {
        return removeTodo(todo: state.todo);
      }
    });
  }

  @override
  void dispose() {
    _homeScreenSub.cancel();
    super.dispose();
  }

  void updateFromHomeScreen({Todo todo});

  void reloadHomeScreen({Todo todo}) {
    _homeScreenStore.dispatch(HomeScreenActionUpdateItem(todo: todo));
  }

  void addNewTodoFromHomeScreen({Todo todo});

  void removeTodo({Todo todo});
}
