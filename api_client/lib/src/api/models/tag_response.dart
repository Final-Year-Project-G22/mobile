// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'tag_response.freezed.dart';
part 'tag_response.g.dart';

@Freezed()
abstract class TagResponse with _$TagResponse {
  const factory TagResponse({
    /// Tag group
    required String group,

    /// Tag ID
    required String id,

    /// Whether tag is active
    required bool isActive,

    /// Whether multiple tags from this group can be selected together
    required bool isMultiSelect,

    /// Amharic name
    required String nameAm,

    /// English name
    required String nameEn,

    /// Tag slug
    required String slug,

    /// Display order
    required int sortOrder,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,

    /// Created timestamp
    DateTime? createdAt,

    /// Amharic description
    String? descAm,

    /// English description
    String? descEn,

    /// Icon identifier
    String? icon,

    /// Updated timestamp
    DateTime? updatedAt,
  }) = _TagResponse;

  factory TagResponse.fromJson(Map<String, Object?> json) => _$TagResponseFromJson(json);
}
