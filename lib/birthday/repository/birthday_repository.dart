import 'package:axiaworks_flutter_tutorial/birthday/db/birthday_db.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final birthdayRepository = Provider(
  (ref) => BirthdayRepository(),
);

class BirthdayRepository {
  MyDatabase database = MyDatabase();
  Future<List<Birthday>> getAllBirthdayData() async {
    final birthdayList = database.readAllBirthdayData;
    return birthdayList;
  }

  Future<void> insertBirthdayData(BirthdaysCompanion birthday) async {
    return database.writeBirthday(birthday);
  }

  Future<void> deleteBirthdayData(int id) async {
    return database.deleteBirthday(id);
  }
}
