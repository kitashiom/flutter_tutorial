import 'package:axiaworks_flutter_tutorial/drift/db/todo_db.dart';
import 'package:axiaworks_flutter_tutorial/drift/repository/todo_repository.dart';
import 'package:axiaworks_flutter_tutorial/drift/state/todo_client_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final todoStateNotifierProvider =
    StateNotifierProvider<TodoStateNotifier, TodoClientState>(
  (ref) => TodoStateNotifier(),
);

class TodoStateNotifier extends StateNotifier<TodoClientState> {
  TodoStateNotifier() : super(const TodoClientState()) {
    getTodoData();
  }

  final _repository = TodoRepository();
  Future getTodoData() async {
    state = state.copyWith(isLoading: true);

    final todos = await _repository.getAllTodoData();

    if (todos.isNotEmpty) {
      state = state.copyWith(
        isLoading: false,
        isReadyData: true,
        todoItems: todos,
      );
    } else {
      state = state.copyWith(
        isLoading: false,
        isReadyData: false,
        todoItems: [],
      );
    }
  }

  Future<void> insertTodoData(TodosCompanion todo) async {
    state = state.copyWith(isLoading: true);
    await _repository.insertTodoData(todo);
    await getTodoData();
  }

  Future<void> deleteTodoData(int id) async {
    await _repository.deleteTodoData(id);
    await getTodoData();
  }
}
