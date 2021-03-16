import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:manabie_todo_app/models/models.dart';
import 'package:manabie_todo_app/repositories/repositories.dart';
import 'package:manabie_todo_app/screens/home/widgets/tabs/general/redux/todo_tab_action.dart';
import 'package:manabie_todo_app/screens/home/widgets/tabs/general/view_model/todo_tab_view_model.dart';
import 'package:manabie_todo_app/screens/home/widgets/tabs/tab_mixin.dart';
import 'package:manabie_todo_app/screens/home/widgets/todo_item.dart';
import 'package:redux/redux.dart';

final _todoCompleteTabStore =
    Store<TodoTabState>(todoTabReducer, initialState: TodoTabState.initial());
final _todoInCompleteTabStore =
    Store<TodoTabState>(todoTabReducer, initialState: TodoTabState.initial());

class TodoTab extends StatefulWidget {
  static Widget completeTab() => StoreProvider<TodoTabState>(
      store: _todoCompleteTabStore,
      child: TodoTab._(
        status: ToDoStatus.completed,
      ));

  static Widget incompleteTab() => StoreProvider<TodoTabState>(
      store: _todoInCompleteTabStore,
      child: TodoTab._(
        status: ToDoStatus.incomplete,
      ));

  final ToDoStatus status;

  TodoTab._({this.status}) : super(key: ValueKey(status));

  @override
  _TodoTabState createState() => _TodoTabState();
}

class _TodoTabState extends State<TodoTab>
    with AutomaticKeepAliveClientMixin<TodoTab>, TabMixin<TodoTab> {
  Store<TodoTabState> get _todoTabStore =>
      StoreProvider.of<TodoTabState>(context, listen: false);

  StreamSubscription _todoTabSub;
  TodoTabViewModel todoTabViewModel;

  @override
  void initState() {
    super.initState();
    todoTabViewModel = TodoTabViewModel.init(
      toDoTabStore: _todoTabStore,
      status: widget.status,
      todoRepository: TodoRepository.init(),
    )..loadToDoList();

    _todoTabSub = _todoTabStore.onChange.listen((state) {
      if (state is TodoTabStateChangedStatus) {
        return reloadHomeScreen(todo: state.todo);
      }

      if (state is TodoTabStateRemovedItem) {
        return dispatchRemovingItem(todo: state.todo);
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
    return StoreConnector<TodoTabState, List<Todo>>(
      builder: (context, items) {
        return ListView.builder(
          itemBuilder: (context, index) {
            final item = items.elementAt(index);
            return TodoItem(
              item: item,
              onChanged: (value) {
                todoTabViewModel.updateStatus(todo: item);
              },
              onDeleted: () {
                todoTabViewModel.removeItem(todo: item);
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
    todoTabViewModel.updateList(todo: todo);
  }

  @override
  void onAddingNewTodoFromHomeScreen({Todo todo}) {
    todoTabViewModel.updateList(todo: todo);
  }

  @override
  void onRemovingTodo({Todo todo}) {
    todoTabViewModel.removeItem(todo: todo);
  }
}
