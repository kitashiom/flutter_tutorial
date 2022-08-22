import 'package:axiaworks_flutter_tutorial/birthday/db/birthday_db.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'birthday_state.freezed.dart';

@freezed
class BirthdayState with _$BirthdayState {
  const factory BirthdayState({
    @Default(false) bool isLoading,
    @Default(0) int currentId,
    Birthday? currentItem,
  }) = _BirthdayState;
}
