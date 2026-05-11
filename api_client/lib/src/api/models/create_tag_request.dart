// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_tag_request.freezed.dart';
part 'create_tag_request.g.dart';

@Freezed()
abstract class CreateTagRequest with _$CreateTagRequest {
  const factory CreateTagRequest({
    /// Tag group
    required String group,

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

    /// Amharic description
    String? descAm,

    /// English description
    String? descEn,

    /// Icon identifier
    String? icon,
  }) = _CreateTagRequest;

  factory CreateTagRequest.fromJson(Map<String, Object?> json) => _$CreateTagRequestFromJson(json);
}
