// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_community_category_request.freezed.dart';
part 'create_community_category_request.g.dart';

@Freezed()
abstract class CreateCommunityCategoryRequest
    with _$CreateCommunityCategoryRequest {
  const factory CreateCommunityCategoryRequest({
    /// Active flag
    required bool isActive,

    /// Category name
    required String name,

    /// Category slug
    required String slug,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,

    /// Category description
    String? description,

    /// Parent category ID
    String? parentCategoryId,
  }) = _CreateCommunityCategoryRequest;

  factory CreateCommunityCategoryRequest.fromJson(Map<String, Object?> json) =>
      _$CreateCommunityCategoryRequestFromJson(json);
}
