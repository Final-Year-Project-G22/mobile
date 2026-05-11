// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'admin_guide_card_dto.freezed.dart';
part 'admin_guide_card_dto.g.dart';

@Freezed()
abstract class AdminGuideCardDto with _$AdminGuideCardDto {
  const factory AdminGuideCardDto({
    required String id,
    required String name,
    required List<dynamic>? sectorIds,
    required String slug,
    required int sortOrder,
    required List<dynamic>? tagIds,
    String? description,
    String? icon,
  }) = _AdminGuideCardDto;

  factory AdminGuideCardDto.fromJson(Map<String, Object?> json) =>
      _$AdminGuideCardDtoFromJson(json);
}
