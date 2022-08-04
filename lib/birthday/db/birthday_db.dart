import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'birthday_db.g.dart';

class Birthdays extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 15)();
  DateTimeColumn get birthday => dateTime()();
  TextColumn get gift => text().withLength(min: 1, max: 50)();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updateAt => dateTime()();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}

@DriftDatabase(tables: [Birthdays])
class MyDatabase extends _$MyDatabase {
  MyDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<List<Birthday>> get readAllBirthdayData => select(birthdays).get();

  Future<void> writeBirthday(BirthdaysCompanion birthday) =>
      into(birthdays).insert(birthday);

  Future<void> deleteBirthday(int id) =>
      (delete(birthdays)..where((tbl) => tbl.id.equals(id))).go();
}
