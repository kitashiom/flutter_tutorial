import 'package:freezed_annotation/freezed_annotation.dart';

part 'youtube_item.freezed.dart';
part 'youtube_item.g.dart';

@freezed
class YoutubeItem with _$YoutubeItem {
  const factory YoutubeItem({
    @JsonKey(name: 'imagePath') String? imagePath,
    @JsonKey(name: 'iconPath') String? iconPath,
    @JsonKey(name: 'title') String? title,
    @JsonKey(name: 'channelName') String? channelName,
    @JsonKey(name: 'numOfViews') String? numOfViews,
    @JsonKey(name: 'daysAgo') String? daysAgo,
  }) = _YoutubeItem;

  factory YoutubeItem.fromJson(Map<String, dynamic> json) =>
      _$YoutubeItemFromJson(json);
}
