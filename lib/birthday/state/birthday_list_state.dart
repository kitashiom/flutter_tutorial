import 'package:axiaworks_flutter_tutorial/birthday/db/birthday_db.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'birthday_list_state.freezed.dart';

@freezed
class BirthdayListState with _$BirthdayListState {
  const factory BirthdayListState({
    @Default(false) bool isLoading,
    @Default(false) bool isTodayBirthday,
    @Default([Birthday]) List<Birthday> birthdayItems,
    @Default(0) int currentId,
  }) = _BirthdayListState;
}
