// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_category_request.freezed.dart';
part 'create_category_request.g.dart';

@Freezed()
abstract class CreateCategoryRequest with _$CreateCategoryRequest {
  const factory CreateCategoryRequest({
    /// Category slug
    required String slug,

    /// Display order
    required int sortOrder,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,

    /// Visibility conditions
    List<dynamic>? conditions,

    /// Icon identifier
    String? icon,

    /// Parent category ID
    String? parentId,

    /// Localized translations
    List<dynamic>? translations,
  }) = _CreateCategoryRequest;

  factory CreateCategoryRequest.fromJson(Map<String, Object?> json) => _$CreateCategoryRequestFromJson(json);
}
