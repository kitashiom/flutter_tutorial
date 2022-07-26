import 'package:axiaworks_flutter_tutorial/drift/db/todo_db.dart';
import 'package:axiaworks_flutter_tutorial/drift/repository/todo_repository.dart';
import 'package:axiaworks_flutter_tutorial/drift/state/todo_client_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

<<<<<<< Updated upstream
final todoStateNotifierProvider =
    StateNotifierProvider<TodoStateNotifier, TodoClientState>(
  (ref) => TodoStateNotifier(),
);

class TodoStateNotifier extends StateNotifier<TodoClientState> {
  TodoStateNotifier() : super(const TodoClientState()) {
=======
final todoClientStateNotifier =
    StateNotifierProvider.autoDispose<TodoClientStateNotifier, TodoClientState>(
  (ref) => TodoClientStateNotifier(),
);

class TodoClientStateNotifier extends StateNotifier<TodoClientState> {
  TodoClientStateNotifier() : super(const TodoClientState()) {
>>>>>>> Stashed changes
    getTodoData();
  }

  final _repository = TodoRepository();
<<<<<<< Updated upstream
  Future getTodoData() async {
=======

  Future<void> getTodoData() async {
>>>>>>> Stashed changes
    state = state.copyWith(isLoading: true);

    final todos = await _repository.getAllTodoData();

    if (todos.isNotEmpty) {
      state = state.copyWith(
        isLoading: false,
        isReadyData: true,
        todoItems: todos,
      );
<<<<<<< Updated upstream
    } else {
      state = state.copyWith(
        isLoading: false,
        isReadyData: false,
=======
      //リストの要素が空の場合の処理
    } else {
      //screen側のビルドが再度走る
      state = state.copyWith(
        isLoading: false,
        isReadyData: false,
        //空のリストをセットしてる
>>>>>>> Stashed changes
        todoItems: [],
      );
    }
  }

<<<<<<< Updated upstream
  Future<void> insertTodoData(TodosCompanion todo) async {
    state = state.copyWith(isLoading: true);
    await _repository.insertTodoData(todo);
    await getTodoData();
  }

  Future<void> deleteTodoData(int id) async {
    await _repository.deleteTodoData(id);
    await getTodoData();
=======
  //保存したデータを含めてもう1回ロードして画面構築をしている
  Future<void> insertTodoData(TodoItemCompanion todo) async {
    //ローディングたてて
    state = state.copyWith(isLoading: true);
    //新規でレコード追加して
    _repository.insertTodoData(todo);
    //データをゲットする
    await getTodoData();
  }

  Future deleteTodoData(int id) async {
    await _repository.deleteTodoData(id);
    getTodoData();
>>>>>>> Stashed changes
  }
}
