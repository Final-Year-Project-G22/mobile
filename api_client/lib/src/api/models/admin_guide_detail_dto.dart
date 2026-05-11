// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'admin_guide_detail_dto.freezed.dart';
part 'admin_guide_detail_dto.g.dart';

@Freezed()
abstract class AdminGuideDetailDto with _$AdminGuideDetailDto {
  const factory AdminGuideDetailDto({
    required List<dynamic>? conditions,
    required String id,
    required List<dynamic>? sectorIds,
    required String slug,
    required int sortOrder,
    required List<dynamic>? tagIds,
    required List<dynamic>? translations,
    String? icon,
  }) = _AdminGuideDetailDto;

  factory AdminGuideDetailDto.fromJson(Map<String, Object?> json) => _$AdminGuideDetailDtoFromJson(json);
}
