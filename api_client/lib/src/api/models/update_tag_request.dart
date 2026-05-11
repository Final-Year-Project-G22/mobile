// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_tag_request.freezed.dart';
part 'update_tag_request.g.dart';

@Freezed()
abstract class UpdateTagRequest with _$UpdateTagRequest {
  const factory UpdateTagRequest({
    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,

    /// Amharic description
    String? descAm,

    /// English description
    String? descEn,

    /// Tag group
    String? group,

    /// Icon identifier
    String? icon,

    /// Whether tag is active
    bool? isActive,

    /// Whether multiple tags from this group can be selected together
    bool? isMultiSelect,

    /// Amharic name
    String? nameAm,

    /// English name
    String? nameEn,

    /// Tag slug
    String? slug,

    /// Display order
    int? sortOrder,
  }) = _UpdateTagRequest;

  factory UpdateTagRequest.fromJson(Map<String, Object?> json) => _$UpdateTagRequestFromJson(json);
}
