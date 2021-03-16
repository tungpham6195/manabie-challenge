import 'package:manabie_todo_app/models/models.dart';
import 'package:manabie_todo_app/repositories/repositories.dart';
import 'package:manabie_todo_app/screens/home/controller/home_screen_controller.dart';
import 'package:manabie_todo_app/screens/home/redux/home_screen_action.dart';
import 'package:redux/redux.dart';

part 'home_screen_view_interaction.dart';

part 'home_screen_view_model_impl.dart';

abstract class HomeScreenViewModel {
  factory HomeScreenViewModel.init(
          {Store<HomeScreenState> store, TodoRepository todoRepository}) =>
      HomeScreenViewModelImpl._(
          homeScreenStateStore: store, todoRepository: todoRepository);

  void changeTab(int index);

  void showAddingDialog();

  void addItem({String description});

  HomeScreenViewModel._();
}
