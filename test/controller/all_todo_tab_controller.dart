import 'package:flutter_test/flutter_test.dart';
import 'package:manabie_todo_app/models/models.dart';
import 'package:manabie_todo_app/repositories/repositories.dart';
import 'package:manabie_todo_app/screens/home/widgets/tabs/all/controller/all_todo_tab_controller.dart';
import 'package:manabie_todo_app/screens/home/widgets/tabs/all/view_model/all_todo_tab_view_model.dart';
import 'package:mockito/mockito.dart';

import '../mock/all_todo_tab_view_interaction_mock.dart';
import '../mock/todo_list_mock.dart';
import '../mock/todo_repository_mock.dart';

main() {
  TodoRepository todoRepository;
  AllTodoTabController controller;
  AllTodoTabViewInteraction view;
  setUp(() {
    todoRepository = TodoRepositoryMock();
    view = AllTodoTabViewInteractionMock();
    controller =
        AllTodoTabController(view: view, todoRepository: todoRepository);
  });

  group('AllTodoTabController test', () {
    test('test loadToDoList', () async {
      when(todoRepository.getToDoList()).thenAnswer((_) async {
        return todoListMock;
      });

      controller.loadToDoList();
      verify(view.loadingData()).called(1);
      expect(
          (await todoRepository.getToDoList()).first.id, todoListMock.first.id);
      expect((await todoRepository.getToDoList()).length, todoListMock.length);
      await untilCalled(todoRepository.getToDoList());
      verify(view.loadedData(
              items: argThat(equals(todoListMock), named: 'items')))
          .called(1);
    });

    test('test updateStatus success with completed item', () async {
      final todo = Todo(
          id: 0, description: 'This is TODO 1', status: ToDoStatus.completed);
      final nextStatus = ToDoStatus.incomplete;
      when(todoRepository.changeTodoStatus(todo: todo, status: nextStatus))
          .thenAnswer((_) async => true);
      controller.updateStatus(todo: todo);
      verify(view.changingStatus()).called(1);
      expect(
          await todoRepository.changeTodoStatus(todo: todo, status: nextStatus),
          isTrue);
      await untilCalled(
          todoRepository.changeTodoStatus(todo: todo, status: nextStatus));
      verify(view.changedStatus(
              items: argThat(isNotNull, named: 'items'),
              todo: argThat(isNotNull, named: 'todo')))
          .called(1);
      verifyNever(view.doNothing());
    });
    test('test updateStatus success with incomplete item', () async {
      final todo = Todo(
          id: 0, description: 'This is TODO 1', status: ToDoStatus.incomplete);
      final nextStatus = ToDoStatus.completed;
      when(todoRepository.changeTodoStatus(todo: todo, status: nextStatus))
          .thenAnswer((_) async => true);
      controller.updateStatus(todo: todo);
      verify(view.changingStatus()).called(1);
      expect(
          await todoRepository.changeTodoStatus(todo: todo, status: nextStatus),
          isTrue);
      await untilCalled(
          todoRepository.changeTodoStatus(todo: todo, status: nextStatus));
      verify(view.changedStatus(
              items: argThat(isNotNull, named: 'items'),
              todo: argThat(isNotNull, named: 'todo')))
          .called(1);
      verifyNever(view.doNothing());
    });

    test('test updateStatus failed', () async {
      final todo = Todo(
          id: 0, description: 'This is TODO 1', status: ToDoStatus.incomplete);
      final nextStatus = ToDoStatus.completed;
      when(todoRepository.changeTodoStatus(todo: todo, status: nextStatus))
          .thenAnswer((_) async => false);
      controller.updateStatus(todo: todo);
      verify(view.changingStatus()).called(1);
      await untilCalled(
          todoRepository.changeTodoStatus(todo: todo, status: nextStatus));
      expect(
          await todoRepository.changeTodoStatus(todo: todo, status: nextStatus),
          isFalse);
      verify(view.doNothing()).called(1);
    });
    test('test reloadTodoListWithUpdatedItem', () async {
      final todo = Todo(
          id: 0, description: 'This is TODO 1', status: ToDoStatus.incomplete);
      controller.reloadTodoListWithUpdatedItem(todo: todo);
      verify(view.loadedData(items: argThat(isNotNull, named: 'items')))
          .called(1);
    });
  });
}
