import 'package:freezed_annotation/freezed_annotation.dart';

part 'residence_item.freezed.dart';
part 'residence_item.g.dart';

@freezed
class ResidenceItem with _$ResidenceItem {
  const factory ResidenceItem({
    @JsonKey(name: 'imagePath') String? imagePath,
    @JsonKey(name: 'title') String? title,
    @JsonKey(name: 'price') String? price,
    @JsonKey(name: 'access') String? access,
    @JsonKey(name: 'area') String? area,
    @JsonKey(name: 'floor') String? floor,
  }) = _ResidenceItem;

  factory ResidenceItem.fromJson(Map<String, dynamic> json) =>
      _$ResidenceItemFromJson(json);
}
