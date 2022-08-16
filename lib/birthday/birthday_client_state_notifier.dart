import 'package:axiaworks_flutter_tutorial/birthday/db/birthday_db.dart';
import 'package:axiaworks_flutter_tutorial/birthday/repository/birthday_repository.dart';
import 'package:axiaworks_flutter_tutorial/birthday/state/birthday_client_state.dart';
import 'package:drift/drift.dart' as drift;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

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
    var isBirthday = false;

    ///誕生年を今の年に変換↓
    ///リスト追加・日付順に並び替え↓
    ///誕生年を戻して、当日誕生日→今年誕生日→来年誕生日の順にリストに追加
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
      //日付が今日だったら、birthdayListに追加
      if (item.birthday == nowDate) {
        isBirthday = true;
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
      //日付が今日でないかつ、今より過去だったら、birthdayListに追加
      if (item.birthday != nowDate && item.birthday.isBefore(now) == true) {
        //誕生年を元の年に戻す
        final item1 = birthdays.firstWhere((element) => element.id == item.id);
        birthdayList.add(item.copyWith(birthday: item1.birthday));
      }
    }

    //stateの変更
    if (birthdays.isNotEmpty && isBirthday == true) {
      state = state.copyWith(
        isLoading: false,
        isReadyData: true,
        isTodayBirthday: true,
        birthdayItems: birthdayList,
      );
    } else if (birthdays.isNotEmpty && isBirthday == false) {
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

  Future<void> changeIcon(Birthday birthdayItem) async {
    final iconList = <String>[
      '👩🏻',
      '🧑🏻',
      '👶🏻',
      '👧🏻',
      '👦🏻',
      '👩🏻‍🦱',
      '👨🏻',
      '👵🏻',
      '👴🏻',
    ];

    var index = 0;
    final currentIndex = iconList.indexOf(birthdayItem.icon);

    if (currentIndex < iconList.length - 1) {
      index = currentIndex + 1;
    } else {
      index = 0;
    }

    final newBirthday = BirthdaysCompanion(
      id: drift.Value(birthdayItem.id),
      icon: drift.Value(iconList[index]),
      name: drift.Value(birthdayItem.name),
      birthday: drift.Value(birthdayItem.birthday),
      gift: drift.Value(birthdayItem.gift),
      createdAt: drift.Value(birthdayItem.createdAt),
      updateAt: drift.Value(
        DateTime.now(),
      ),
    );
    await updateBirthdayData(newBirthday);
  }

  Future<void> shareMessage(
    String text,
  ) async {
    await Share.share(
      text,
    );
  }
}
