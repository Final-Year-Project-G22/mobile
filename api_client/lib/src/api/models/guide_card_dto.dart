// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'guide_card_dto.freezed.dart';
part 'guide_card_dto.g.dart';

@Freezed()
abstract class GuideCardDto with _$GuideCardDto {
  const factory GuideCardDto({
    /// Guide ID
    required String id,

    /// Localized guide name
    required String name,

    /// Target sector IDs
    required List<dynamic>? sectorIds,

    /// Guide slug
    required String slug,

    /// Target tag IDs
    required List<dynamic>? tagIds,

    /// Localized description
    String? description,

    /// Icon identifier
    String? icon,
  }) = _GuideCardDto;

  factory GuideCardDto.fromJson(Map<String, Object?> json) =>
      _$GuideCardDtoFromJson(json);
}
