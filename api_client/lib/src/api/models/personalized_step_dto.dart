// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'personalized_step_dto.freezed.dart';
part 'personalized_step_dto.g.dart';

@Freezed()
abstract class PersonalizedStepDto with _$PersonalizedStepDto {
  const factory PersonalizedStepDto({
    /// Step ID
    required String id,

    /// Whether step can be skipped
    required bool isOptional,

    /// Step slug
    required String slug,

    /// Display order
    required int sortOrder,

    /// User progress status
    required String status,

    /// Step type
    required String stepType,

    /// Localized step title
    required String title,

    /// Localized description
    String? description,

    /// Estimated time in minutes
    int? estimatedTime,
  }) = _PersonalizedStepDto;

  factory PersonalizedStepDto.fromJson(Map<String, Object?> json) =>
      _$PersonalizedStepDtoFromJson(json);
}
