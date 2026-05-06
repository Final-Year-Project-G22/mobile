// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_detail_response.freezed.dart';
part 'category_detail_response.g.dart';

@Freezed()
abstract class CategoryDetailResponse with _$CategoryDetailResponse {
  const factory CategoryDetailResponse({
    /// Category ID
    required String id,

    /// Active flag
    required bool isActive,

    /// Category name
    required String name,

    /// Category slug
    required String slug,

    /// Display order
    required int sortOrder,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,

    /// Icon name
    String? icon,

    /// Parent category ID
    String? parentCategoryId,

    /// Category translations
    List<dynamic>? translations,
  }) = _CategoryDetailResponse;

  factory CategoryDetailResponse.fromJson(Map<String, Object?> json) => _$CategoryDetailResponseFromJson(json);
}
