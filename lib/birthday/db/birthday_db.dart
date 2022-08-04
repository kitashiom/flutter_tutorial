import 'package:drift/drift.dart';

part 'birthday_db.g.dart';

class Birthdays extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 1, max: 50)();
  TextColumn get description => text().withLength(min: 1, max: 50)();
  DateTimeColumn get addDate => dateTime()();
  DateTimeColumn get limitDate => dateTime()();
}

@DriftDatabase(tables: [Birthdays])
class MyDatabase extends _$MyDatabase {}
