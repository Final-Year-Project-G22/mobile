// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_community_category_request.freezed.dart';
part 'update_community_category_request.g.dart';

@Freezed()
abstract class UpdateCommunityCategoryRequest
    with _$UpdateCommunityCategoryRequest {
  const factory UpdateCommunityCategoryRequest({
    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,

    /// Category description
    String? description,

    /// Active flag
    bool? isActive,

    /// Category name
    String? name,

    /// Parent category ID
    String? parentCategoryId,

    /// Category slug
    String? slug,
  }) = _UpdateCommunityCategoryRequest;

  factory UpdateCommunityCategoryRequest.fromJson(Map<String, Object?> json) =>
      _$UpdateCommunityCategoryRequestFromJson(json);
}
