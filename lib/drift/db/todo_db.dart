import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'todo_db.g.dart';

<<<<<<< Updated upstream
class Todos extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 1, max: 50)();
  TextColumn get description => text().withLength(min: 1, max: 50)();
  DateTimeColumn get addDate => dateTime()();
  DateTimeColumn get limitDate => dateTime()();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
=======
class TodoItem extends Table {
  // 最後の'()'は'call()'の略
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title =>
      text().withDefault(const Constant('')).withLength(min: 1)();
  TextColumn get description => text().withDefault(const Constant(''))();
  DateTimeColumn get addDate => dateTime()();

  DateTimeColumn get limitDate => dateTime()();
}

// データベースの場所を指定
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    // db.sqliteファイルをアプリのドキュメントフォルダに置く
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.splite'));
>>>>>>> Stashed changes
    return NativeDatabase(file);
  });
}

<<<<<<< Updated upstream
@DriftDatabase(tables: [Todos])
class MyDatabase extends _$MyDatabase {
  MyDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<List<Todo>> get readAllTodoData => select(todos).get();

  Future writeTodo(TodosCompanion todo) => into(todos).insert(todo);

  Future deleteTodo(int id) =>
      (delete(todos)..where((tbl) => tbl.id.equals(id))).go();
=======
@DriftDatabase(tables: [TodoItem])
class MyDatabase extends _$MyDatabase {
  MyDatabase() : super(_openConnection());
  // テーブルと列を変更するときに使用する
  @override
  int get schemaVersion => 1;

  // 全てのデータの取得
  Future<List<TodoItemData>> readAllTodoData() => select(todoItem).get();

  // データの追加
  Future<void> writeTodo(TodoItemCompanion data) => into(todoItem).insert(data);

  // データの更新
  Future<void> updateTodo(TodoItemData data) => update(todoItem).replace(data);

  // データの削除
  Future<void> deleteTodo(int id) =>
      (delete(todoItem)..where((it) => it.id.equals(id))).go();
>>>>>>> Stashed changes
}
