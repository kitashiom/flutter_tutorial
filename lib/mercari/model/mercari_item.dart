import 'package:freezed_annotation/freezed_annotation.dart';

part 'mercari_item.freezed.dart';
part 'mercari_item.g.dart';

@freezed
class MercariItem with _$MercariItem {
  const factory MercariItem({
    @JsonKey(name: "imagePath") String? imagePath,
    @JsonKey(name: "title") String? title,
    @JsonKey(name: "price") String? price,
    @JsonKey(name: "numOfPeople") int? numOfViews,
  }) = _MercariItem;

  factory MercariItem.fromJson(Map<String, dynamic> json) =>
      _$MercariItemFromJson(json);
}
