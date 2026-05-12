// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_library_category_request.freezed.dart';
part 'create_library_category_request.g.dart';

@Freezed()
abstract class CreateLibraryCategoryRequest with _$CreateLibraryCategoryRequest {
  const factory CreateLibraryCategoryRequest({
    /// Category name
    required String name,

    /// URL-friendly identifier
    required String slug,

    /// Display order
    required int sortOrder,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,

    /// Icon name
    String? icon,

    /// Parent category ID
    String? parentCategoryId,
  }) = _CreateLibraryCategoryRequest;

  factory CreateLibraryCategoryRequest.fromJson(Map<String, Object?> json) =>
      _$CreateLibraryCategoryRequestFromJson(json);
}
