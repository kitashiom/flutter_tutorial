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

    if (birthdays.isNotEmpty) {
      state = state.copyWith(
        isLoading: false,
        isReadyData: true,
        birthdayItems: birthdays,
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
}
