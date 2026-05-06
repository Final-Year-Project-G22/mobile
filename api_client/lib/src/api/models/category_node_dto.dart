// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_node_dto.freezed.dart';
part 'category_node_dto.g.dart';

@Freezed()
abstract class CategoryNodeDto with _$CategoryNodeDto {
  const factory CategoryNodeDto({
    /// Category ID
    required String id,

    /// Localized category name
    required String name,

    /// Category slug
    required String slug,

    /// Display order
    required int sortOrder,

    /// Nested subcategories
    List<dynamic>? children,

    /// Localized description
    String? description,

    /// Guides in this category
    List<dynamic>? guides,

    /// Icon identifier
    String? icon,
  }) = _CategoryNodeDto;

  factory CategoryNodeDto.fromJson(Map<String, Object?> json) => _$CategoryNodeDtoFromJson(json);
}
