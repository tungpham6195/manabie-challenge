import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:manabie_todo_app/models/models.dart';
import 'package:manabie_todo_app/repositories/repositories.dart';
import 'package:manabie_todo_app/screens/home/widgets/tabs/all/redux/all_todo_tab_action.dart';
import 'package:manabie_todo_app/screens/home/widgets/tabs/all/view_model/all_todo_tab_view_model.dart';
import 'package:manabie_todo_app/screens/home/widgets/tabs/tab_mixin.dart';
import 'package:manabie_todo_app/screens/home/widgets/todo_item.dart';
import 'package:redux/redux.dart';

final allTodoTabStore = Store<AllTodoTabState>(allTodoTabReducer,
    initialState: AllTodoTabState.initial());

class AllTodoTab extends StatefulWidget {
  static Widget newInstance() => StoreProvider<AllTodoTabState>(
      store: allTodoTabStore, child: AllTodoTab._());

  AllTodoTab._();

  @override
  _AllTodoTabState createState() => _AllTodoTabState();
}

class _AllTodoTabState extends State<AllTodoTab>
    with AutomaticKeepAliveClientMixin<AllTodoTab>, TabMixin<AllTodoTab> {
  AllTodoTabViewModel _allTodoTabViewModel;

  Store<AllTodoTabState> get _allTodoTabStore =>
      StoreProvider.of<AllTodoTabState>(context, listen: false);

  StreamSubscription _todoTabSub;

  @override
  void initState() {
    super.initState();
    _allTodoTabViewModel = AllTodoTabViewModel.init(
        todoRepository: TodoRepository.init(), store: _allTodoTabStore)
      ..loadToDoList();

    _todoTabSub = _allTodoTabStore.onChange.listen((state) {
      if (state is AllTodoTabStateChangedStatus) {
        reloadHomeScreen(todo: state.todo);
      }
    });
  }

  @override
  void dispose() {
    _todoTabSub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StoreConnector<AllTodoTabState, List<Todo>>(
      builder: (context, items) {
        return ListView.builder(
          itemBuilder: (context, index) {
            final item = items.elementAt(index);
            return TodoItem(
              item: item,
              onChanged: (value) {
                _allTodoTabViewModel.updateStatus(todo: item);
              },
              onDeleted: () {
                _allTodoTabViewModel.removeTodo(todo: item);
              },
            );
          },
          itemCount: items.length,
        );
      },
      converter: (store) => store.state.items,
    );
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void onUpdateFromHomeScreen({Todo todo}) {
    _allTodoTabViewModel.reloadTodoListWithUpdatedItem(todo: todo);
  }

  @override
  void onAddingNewTodoFromHomeScreen({Todo todo}) {
    _allTodoTabViewModel.addTodo(todo: todo);
  }

  @override
  void onRemovingTodo({Todo todo}) {
    _allTodoTabViewModel.removeTodo(todo: todo);
  }
}
