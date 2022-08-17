import 'package:axiaworks_flutter_tutorial/birthday/constants.dart';
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
    var isBirthday = false;

    /// 誕生年を今の年に変換↓
    /// リスト追加・日付順に並び替え↓
    /// 1.今日誕生日 2.今年の誕生日が過ぎてない人 3.今年の誕生日が過ぎた人の順にリストに追加
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
      // 日付順に並び替えるために一時的にリスト（tempList）に追加
      tempList
        ..add(birthdayItem)
        ..sort((a, b) => a.birthday.compareTo(b.birthday));
    }
    for (final item in tempList) {
      //1.今日誕生日の人をbirthdayListに追加
      if (item.birthday == nowDate) {
        isBirthday = true;
        //誕生年を元の年に戻す
        final item1 = birthdays.firstWhere((element) => element.id == item.id);
        birthdayList.add(item.copyWith(birthday: item1.birthday));
      }
    }
    for (final item in tempList) {
      //2.日付が今より過去でなければ、birthdayListに追加
      if (item.birthday.isBefore(now) == false) {
        //誕生年を元の年に戻す
        final item1 = birthdays.firstWhere((element) => element.id == item.id);
        birthdayList.add(item.copyWith(birthday: item1.birthday));
      }
    }
    for (final item in tempList) {
      //3.日付が今日でないかつ、今日より過去だったら、birthdayListに追加
      if (item.birthday != nowDate && item.birthday.isBefore(now) == true) {
        //誕生年を元の年に戻す
        final item1 = birthdays.firstWhere((element) => element.id == item.id);
        birthdayList.add(item.copyWith(birthday: item1.birthday));
      }
    }

    //stateの変更
    if (birthdays.isNotEmpty && isBirthday == true) {
      //アイテムがある・今日誕生日の人がいる場合
      state = state.copyWith(
        isLoading: false,
        isReadyData: true,
        isTodayBirthday: isBirthday,
        birthdayItems: birthdayList,
      );
    } else if (birthdays.isNotEmpty && isBirthday == false) {
      //アイテムがある・今日誕生日の人がいない場合
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

  //残日数計算
  int calculateCountdown(DateTime birthday) {
    //今年、誕生日が過ぎてる場合
    if (birthday.isBefore(nowDate)) {
      return birthday.difference(nowDate).inDays + 365;
    } else {
      //今年、誕生日が過ぎてない場合
      return birthday.difference(nowDate).inDays;
    }
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

    //データを更新
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

  Future<void> shareMessage(String text) async {
    await Share.share(
      text,
    );
  }
}
