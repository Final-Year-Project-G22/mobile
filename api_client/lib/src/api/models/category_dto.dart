// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_dto.freezed.dart';
part 'category_dto.g.dart';

@Freezed()
abstract class CategoryDto with _$CategoryDto {
  const factory CategoryDto({
    /// Category ID
    required String id,

    /// Whether category is active
    required bool isActive,

    /// Category name
    required String name,

    /// Category slug
    required String slug,

    /// Created timestamp
    DateTime? createdAt,

    /// Category description
    String? description,

    /// Parent category ID
    String? parentCategoryId,

    /// Updated timestamp
    DateTime? updatedAt,
  }) = _CategoryDto;

  factory CategoryDto.fromJson(Map<String, Object?> json) => _$CategoryDtoFromJson(json);
}
