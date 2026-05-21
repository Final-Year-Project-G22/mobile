// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'admin_guide_step_dto.freezed.dart';
part 'admin_guide_step_dto.g.dart';

@Freezed()
abstract class AdminGuideStepDto with _$AdminGuideStepDto {
  const factory AdminGuideStepDto({
    required DateTime effectiveDate,
    required String guideId,
    required String id,
    required bool isOptional,
    required String slug,
    required int sortOrder,
    required String stepType,
    required List<dynamic>? translations,
    String? complianceType,
    int? difficultyLevel,
    int? estimatedTime,
    DateTime? expiryDate,
    int? feeEstimate,
  }) = _AdminGuideStepDto;

  factory AdminGuideStepDto.fromJson(Map<String, Object?> json) =>
      _$AdminGuideStepDtoFromJson(json);
}
