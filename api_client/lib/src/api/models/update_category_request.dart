// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_category_request.freezed.dart';
part 'update_category_request.g.dart';

@Freezed()
abstract class UpdateCategoryRequest with _$UpdateCategoryRequest {
  const factory UpdateCategoryRequest({
    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,

    /// Visibility conditions
    List<dynamic>? conditions,

    /// Icon identifier
    String? icon,

    /// Parent category ID
    String? parentId,

    /// Category slug
    String? slug,

    /// Display order
    int? sortOrder,

    /// Localized translations
    List<dynamic>? translations,
  }) = _UpdateCategoryRequest;

  factory UpdateCategoryRequest.fromJson(Map<String, Object?> json) => _$UpdateCategoryRequestFromJson(json);
}
