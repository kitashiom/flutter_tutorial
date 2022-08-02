import 'package:axiaworks_flutter_tutorial/drift/db/todo_db.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    return database.writeTodo(todo);
  }

  Future<void> deleteTodoData(int id) async {
    return database.deleteTodo(id);
  }
}
