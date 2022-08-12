import 'package:axiaworks_flutter_tutorial/birthday/db/birthday_db.dart';
import 'package:axiaworks_flutter_tutorial/birthday/repository/birthday_repository.dart';
import 'package:axiaworks_flutter_tutorial/birthday/state/birthday_client_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final birthdayStateNotifierProvider =
    StateNotifierProvider<BirthdayStateNotifier, BirthdayClientState>(
  (ref) => BirthdayStateNotifier(),
);

class BirthdayStateNotifier extends StateNotifier<BirthdayClientState> {
  BirthdayStateNotifier() : super(const BirthdayClientState()) {
    getBirthdayData();
  }

  final _repository = BirthdayRepository();

  Future<void> getBirthdayData() async {
    state = state.copyWith(isLoading: true);

    final birthdays = await _repository.getAllBirthdayData();
    final birthdayList = <Birthday>[];
    final tempList = <Birthday>[];
    final now = DateTime.now();
    final nowDate = DateTime(now.year, now.month, now.day);

    for (final item in birthdays) {
      final birthday = item.birthday;
      // 誕生年を現在の年に変換
      final birthdayItem = item.copyWith(
        birthday: DateTime(
          now.year,
          birthday.month,
          birthday.day,
        ),
      );
      // 一時リスト（tempList）に追加＆日付順に並び替え
      tempList
        ..add(birthdayItem)
        ..sort((a, b) => a.birthday.compareTo(b.birthday));
    }
    for (final item in tempList) {
      //日付が今より過去でなければ、birthdayListに追加
      if (item.birthday == nowDate) {
        //誕生年を元の年に戻す
        final item1 = birthdays.firstWhere((element) => element.id == item.id);
        birthdayList.add(item.copyWith(birthday: item1.birthday));
      }
    }
    for (final item in tempList) {
      //日付が今より過去でなければ、birthdayListに追加
      if (item.birthday.isBefore(now) == false) {
        //誕生年を元の年に戻す
        final item1 = birthdays.firstWhere((element) => element.id == item.id);
        birthdayList.add(item.copyWith(birthday: item1.birthday));
      }
    }
    for (final item in tempList) {
      //日付が今より過去だったら、birthdayListに追加
      if (item.birthday.isBefore(now) == true) {
        //誕生年を元の年に戻す
        final item1 = birthdays.firstWhere((element) => element.id == item.id);
        birthdayList.add(item.copyWith(birthday: item1.birthday));
      }
    }

    //stateの変更
    if (birthdays.isNotEmpty) {
      state = state.copyWith(
        isLoading: false,
        isReadyData: true,
        birthdayItems: birthdayList,
      );
    } else {
      state = state.copyWith(
        isLoading: false,
        isReadyData: false,
        birthdayItems: [],
      );
    }
  }

  Future<void> insertBirthdayData(BirthdaysCompanion birthday) async {
    state = state.copyWith(isLoading: true);
    await _repository.insertBirthdayData(birthday);
    await getBirthdayData();
  }

  Future<void> deleteBirthdayData(int id) async {
    await _repository.deleteBirthdayData(id);
    await getBirthdayData();
  }

  Future<void> updateBirthdayData(BirthdaysCompanion birthday) async {
    await _repository.updateBirthdayData(birthday);
    await getBirthdayData();
  }
}
