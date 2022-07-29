import 'package:axiaworks_flutter_tutorial/mercari/model/mercari_item.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'mercari_client_state.freezed.dart';

@freezed
class MercariClientState with _$MercariClientState {
  const factory MercariClientState({
    @Default(false) bool isLoading,
    @Default(false) bool isReadyData,
    @Default(<MercariItem>[]) List<MercariItem> mercariItems,
  }) = _MercariClientState;
}
