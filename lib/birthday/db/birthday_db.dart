import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'birthday_db.g.dart';

// シングルトン対応にしている(Repositoryページにも変更あり)

// テーブルの作成
class Birthdays extends Table {
  // 主キー（autoIncrementで自動的にIDを設置する）
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text().withLength(min: 1, max: 15)();

  DateTimeColumn get birthday => dateTime()();

  TextColumn get gift => text().withLength(min: 1, max: 50)();

  DateTimeColumn get createdAt => dateTime()();

  DateTimeColumn get updateAt => dateTime()();
}

// データベースの場所を指定
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db2.sqlite'));
    //シングルトン対応すべく、以下1行追加
    driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
    return NativeDatabase(file);
  });
}

// データベースへアクセス（実際に読み書き）するクラスの定義
// 中のメソッドは外向けに公開するメソッドとその動きを定義している。
@DriftDatabase(tables: [Birthdays])
class MyDatabase extends _$MyDatabase {
  static MyDatabase? _instance;

  static MyDatabase getInstance() {
    //シングルトン対応
    if (_instance == null) {
      _instance = new MyDatabase();
    }
    return _instance!;
  }

  MyDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<List<Birthday>> get readAllBirthdayData => select(birthdays).get();

  Future<void> writeBirthday(BirthdaysCompanion birthday) =>
      into(birthdays).insert(birthday);

  Future<void> deleteBirthday(int id) =>
      (delete(birthdays)..where((tbl) => tbl.id.equals(id))).go();

  Future<void> updateBirthday(BirthdaysCompanion birthday) =>
      update(birthdays).replace(birthday);
}
