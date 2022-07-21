import 'package:axiaworks_flutter_tutorial/residence/model/residence_item.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'residence_client_state.freezed.dart';

@freezed
class ResidenceClientState with _$ResidenceClientState {
  const factory ResidenceClientState({
    @Default(false) bool isLoading,
    @Default(false) bool isReadyData,
    @Default(<ResidenceItem>[]) List<ResidenceItem> residenceItems,
  }) = _ResidenceClientState;
}
