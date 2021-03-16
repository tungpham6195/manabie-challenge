import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:manabie_todo_app/repositories/repositories.dart';
import 'package:manabie_todo_app/screens/home/redux/home_screen_action.dart';
import 'package:manabie_todo_app/screens/home/view_model/home_screen_view_model.dart';
import 'package:manabie_todo_app/screens/home/widgets/enter_new_todo_dialog/enter_new_todo_dialog.dart';
import 'package:manabie_todo_app/screens/home/widgets/tabs/all/all_todo_tab.dart';
import 'package:manabie_todo_app/screens/home/widgets/tabs/general/todo_tab.dart';
import 'package:redux/redux.dart';

final _homeScreenStore = Store<HomeScreenState>(homeScreenReducer,
    initialState: HomeScreenState.init());

class HomeScreen extends StatefulWidget {
  static Widget newInstance() => StoreProvider<HomeScreenState>(
      store: _homeScreenStore, child: HomeScreen._());

  HomeScreen._();

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin<HomeScreen> {
  TabController _tabController;
  HomeScreenViewModel _homeScreenViewModel;

  Store<HomeScreenState> get _homeScreenStore =>
      StoreProvider.of<HomeScreenState>(context, listen: false);
  StreamSubscription _homeScreenSub;

  @override
  void initState() {
    super.initState();
    _homeScreenViewModel = HomeScreenViewModel.init(
      store: _homeScreenStore,
      todoRepository: TodoRepository.init(),
    );
    _tabController = TabController(length: 3, vsync: this)
      ..addListener(() {
        if (!_tabController.indexIsChanging) {
          _homeScreenViewModel.changeTab(_tabController.index);
        }
      });
    _homeScreenSub = _homeScreenStore.onChange.listen((state) {
      if (state is HomeScreenStateShowAddingDialog) {
        showDialog(
          context: context,
          builder: (context) {
            return EnterNewTodoDialog(
              onSubmitted: (description) {
                _homeScreenViewModel.addItem(description: description);
              },
            );
          },
        );
      }
    });
  }

  @override
  void dispose() {
    _homeScreenSub.cancel();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: TabBarView(
          controller: _tabController,
          physics: NeverScrollableScrollPhysics(),
          children: [
            AllTodoTab.newInstance(),
            TodoTab.completeTab(),
            TodoTab.incompleteTab(),
          ]),
      bottomNavigationBar: StoreBuilder<HomeScreenState>(
        builder: (context, store) {
          return BottomNavigationBar(
            onTap: (index) {
              _tabController.animateTo(index);
            },
            currentIndex: store.state.index,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'All',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.star),
                label: 'Complete',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.star_border),
                label: 'Incomplete',
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _homeScreenViewModel.showAddingDialog();
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
