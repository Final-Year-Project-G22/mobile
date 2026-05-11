// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'admin_category_dto.freezed.dart';
part 'admin_category_dto.g.dart';

@Freezed()
abstract class AdminCategoryDto with _$AdminCategoryDto {
  const factory AdminCategoryDto({
    required String id,
    required String name,
    required String slug,
    required int sortOrder,
    List<dynamic>? children,
    String? description,
    String? icon,
    String? parentId,
  }) = _AdminCategoryDto;

  factory AdminCategoryDto.fromJson(Map<String, Object?> json) =>
      _$AdminCategoryDtoFromJson(json);
}
