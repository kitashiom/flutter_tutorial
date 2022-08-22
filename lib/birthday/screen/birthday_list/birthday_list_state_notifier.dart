import 'package:axiaworks_flutter_tutorial/birthday/constants.dart';
import 'package:axiaworks_flutter_tutorial/birthday/db/birthday_db.dart';
import 'package:axiaworks_flutter_tutorial/birthday/repository/birthday_repository.dart';
import 'package:axiaworks_flutter_tutorial/birthday/state/birthday_list_state.dart';
import 'package:drift/drift.dart' as drift;
import 'package:flutter_riverpod/flutter_riverpod.dart';

final birthdayListStateNotifierProvider =
    StateNotifierProvider<BirthdayListStateNotifier, BirthdayListState>(
  (ref) => BirthdayListStateNotifier(ref.read),
);

class BirthdayListStateNotifier extends StateNotifier<BirthdayListState> {
  BirthdayListStateNotifier(this.read) : super(const BirthdayListState()) {
    getBirthdayData();
  }

  //Provider経由で取得
  final Reader read;
  BirthdayRepository get _repository => read(birthdayRepository);

  Future<void> getBirthdayData() async {
    state = state.copyWith(isLoading: true);

    final birthdays = await _repository.getAllBirthdayData();
    final birthdayList = <Birthday>[];

    //今日誕生日の人
    final todays = birthdays.where((e) {
      final date = e.copyWith(birthday: changeBirthYear(e.birthday));
      return date.birthday == nowDate;
    }).toList();

    //今年誕生日来てない人
    final futures = birthdays.where((e) {
      final date = e.copyWith(birthday: changeBirthYear(e.birthday));
      return !date.birthday.isBefore(now);
    }).toList();

    //今年誕生日来た人
    final pasts = birthdays.where((e) {
      final date = e.copyWith(birthday: changeBirthYear(e.birthday));
      return date.birthday.isBefore(now) && date.birthday != nowDate;
    }).toList();

    birthdayList
      ..addAll(sortBirthday(todays))
      ..addAll(sortBirthday(futures))
      ..addAll(sortBirthday(pasts));

    state = state.copyWith(
      isLoading: false,
      isTodayBirthday: isBirthday(todays),
      birthdayItems: birthdayList,
    );
  }

  bool isBirthday(List<Birthday> todays) {
    if (todays.isEmpty) {
      return false;
    }
    return true;
  }

  DateTime changeBirthYear(DateTime birthday) {
    return DateTime(now.year, birthday.month, birthday.day);
  }

  List<Birthday> sortBirthday(List<Birthday> birthdays) {
    birthdays.sort((a, b) {
      final aa = a.copyWith(birthday: changeBirthYear(a.birthday));
      final bb = b.copyWith(birthday: changeBirthYear(b.birthday));
      return aa.birthday.compareTo(bb.birthday);
    });
    return birthdays;
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

  Future<void> setCurrentBirthday(int id) async {
    state = state.copyWith(
      currentId: id,
    );
  }
}
