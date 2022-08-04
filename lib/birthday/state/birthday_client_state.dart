import 'package:axiaworks_flutter_tutorial/birthday/db/birthday_db.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'birthday_client_state.freezed.dart';

@freezed
class BirthdayClientState with _$BirthdayClientState {
  const factory BirthdayClientState({
    @Default(false) bool isLoading,
    @Default(false) bool isReadyData,
    @Default([Birthday]) List<Birthday> birthdayItems,
  }) = _BirthdayClientState;
}
