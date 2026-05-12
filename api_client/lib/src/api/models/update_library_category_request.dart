// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_library_category_request.freezed.dart';
part 'update_library_category_request.g.dart';

@Freezed()
abstract class UpdateLibraryCategoryRequest with _$UpdateLibraryCategoryRequest {
  const factory UpdateLibraryCategoryRequest({
    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,

    /// Icon name
    String? icon,

    /// Active flag
    bool? isActive,

    /// Category name
    String? name,

    /// URL-friendly identifier
    String? slug,

    /// Display order
    int? sortOrder,
  }) = _UpdateLibraryCategoryRequest;

  factory UpdateLibraryCategoryRequest.fromJson(Map<String, Object?> json) =>
      _$UpdateLibraryCategoryRequestFromJson(json);
}
