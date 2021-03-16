import 'package:flutter_test/flutter_test.dart';
import 'package:manabie_todo_app/models/models.dart';
import 'package:manabie_todo_app/repositories/repositories.dart';
import 'package:manabie_todo_app/screens/home/widgets/tabs/general/controller/todo_tab_controller.dart';
import 'package:manabie_todo_app/screens/home/widgets/tabs/general/view_model/todo_tab_view_model.dart';
import 'package:mockito/mockito.dart';

import '../mock/todo_list_mock.dart';
import '../mock/todo_repository_mock.dart';
import '../mock/todo_tab_view_interaction_mock.dart';

main() {
  TodoRepository todoRepository;
  TodoTabViewInteraction view;
  TodoTabController controller;
  final status = ToDoStatus.completed;
  setUp(() {
    view = TodoTabViewInteractionMock();
    todoRepository = TodoRepositoryMock();
    controller = TodoTabController(
        status: status, todoRepository: todoRepository, view: view);
  });

  group('TodoTabController test for incomplete tab', () {
    test('test loadToDoList', () async {
      when(todoRepository.getToDoList(status: status)).thenAnswer((_) async {
        return todoListMock;
      });
      controller.loadToDoList();
      verify(view.loadingData()).called(1);
      expect((await todoRepository.getToDoList(status: status)).first.id,
          todoListMock.first.id);
      expect((await todoRepository.getToDoList(status: status)).length,
          todoListMock.length);
      await untilCalled(todoRepository.getToDoList(status: status));
      verify(view.loadedData(items: argThat(isNotNull, named: 'items')))
          .called(1);
    });
    test('test addItem', () {
      final todo = Todo(
          id: 5, description: 'This is TODO 6', status: ToDoStatus.completed);
      controller.items = todoListMock;
      controller.addItem(todo: todo);
      verify(view.addingItem()).called(1);
      expect(controller.items.last.id, todo.id);
      verify(view.loadedData(items: argThat(isNotNull, named: 'items')))
          .called(1);
    });
    test('test removeItem', () {
      final todo = Todo(
          id: 0, description: 'This is TODO 1', status: ToDoStatus.incomplete);
      controller.items = todoListMock;
      controller.removeItem(todo: todo);
      verify(view.removingItem()).called(1);
      expect(
          controller.items.indexWhere((element) => element.id == todo.id) < 0,
          isTrue);
      verify(view.loadedData(items: argThat(isNotNull, named: 'items')))
          .called(1);
    });

    test('test updateStatus: change status to incomplete', () async {
      final todo = Todo(
          id: 0, description: 'This is TODO 1', status: ToDoStatus.completed);
      final newStatus = ToDoStatus.incomplete;
      when(todoRepository.changeTodoStatus(todo: todo, status: newStatus))
          .thenAnswer((_) async => true);
      controller.items = todoListMock;
      controller.updateStatus(todo: todo);
      await untilCalled(
          todoRepository.changeTodoStatus(todo: todo, status: newStatus));
      expect(
          await todoRepository.changeTodoStatus(todo: todo, status: newStatus),
          isTrue);
      expect(
          controller.items.indexWhere((element) => element.id == todo.id) < 0,
          isTrue);
      verify(view.changedStatus(
              items: argThat(isNotNull, named: 'items'),
              todo: argThat(isNotNull, named: 'todo')))
          .called(1);
    });
  });
}
