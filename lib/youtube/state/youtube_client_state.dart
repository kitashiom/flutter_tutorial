import 'package:axiaworks_flutter_tutorial/youtube/model/youtube_item.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'youtube_client_state.freezed.dart';

@freezed
class YoutubeClientState with _$YoutubeClientState {
  const factory YoutubeClientState({
    @Default(false) bool isLoading,
    @Default(false) bool isReadyData,
    @Default(<YoutubeItem>[]) List<YoutubeItem> youtubeItems,
  }) = _YoutubeClientState;
}
