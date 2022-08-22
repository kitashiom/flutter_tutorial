import 'package:axiaworks_flutter_tutorial/birthday/repository/birthday_repository.dart';
import 'package:axiaworks_flutter_tutorial/birthday/screen/birthday_list/birthday_list_state_notifier.dart';
import 'package:axiaworks_flutter_tutorial/birthday/state/birthday_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

final birthdayStateNotifierProvider =
    StateNotifierProvider.autoDispose<BirthdayStateNotifier, BirthdayState>(
        (ref) {
  final currentId = ref.read(birthdayListStateNotifierProvider).currentId;
  return BirthdayStateNotifier(currentId, ref.read);
});

class BirthdayStateNotifier extends StateNotifier<BirthdayState> {
  BirthdayStateNotifier(this.currentId, this.read)
      : super(const BirthdayState()) {
    state = state.copyWith(
      currentId: currentId,
    );
    getCurrentBirthdayData(currentId);
  }

  final int currentId;

  //Provider経由で取得
  final Reader read;

  BirthdayRepository get _repository => read(birthdayRepository);

  Future<void> getCurrentBirthdayData(int id) async {
    state = state.copyWith(isLoading: true);

    final birthday = await _repository.getCurrentBirthdayData(id);

    state = state.copyWith(
      isLoading: false,
      currentItem: birthday,
    );
  }

  Future<void> shareMessage(String text) async {
    await Share.share(
      text,
    );
  }
}
