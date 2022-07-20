import 'package:freezed_annotation/freezed_annotation.dart';

part 'youtube_user.freezed.dart';
part 'youtube_user.g.dart';

@freezed
class YoutubeUser with _$YoutubeUser {
  const factory YoutubeUser({
    @JsonKey(name: "profile_image_url") String? profileImageUrl,
  }) = _YoutubeUser;

  factory YoutubeUser.fromJson(Map<String, dynamic> json) =>
      _$YoutubeUserFromJson(json);
}
