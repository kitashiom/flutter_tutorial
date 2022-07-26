import 'package:axiaworks_flutter_tutorial/drift/db/todo_db.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

<<<<<<< Updated upstream
final todoRepository = Provider(
  (ref) => TodoRepository(),
);

class TodoRepository {
  MyDatabase database = MyDatabase();
  Future<List<Todo>> getAllTodoData() async {
    final todoList = database.readAllTodoData;
    return todoList;
  }

  Future<void> insertTodoData(TodosCompanion todo) async {
=======
final todoRepositoryProvider =
    Provider<TodoRepository>((_) => TodoRepository());

class TodoRepository {
  MyDatabase database = MyDatabase();

  Future<List<TodoItemData>> getAllTodoData() async {
    return database.readAllTodoData();
  }

  Future<void> insertTodoData(TodoItemCompanion todo) async {
>>>>>>> Stashed changes
    return database.writeTodo(todo);
  }

  Future<void> deleteTodoData(int id) async {
    return database.deleteTodo(id);
  }
}
