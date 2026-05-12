// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'guide_with_progress_dto.freezed.dart';
part 'guide_with_progress_dto.g.dart';

@Freezed()
abstract class GuideWithProgressDto with _$GuideWithProgressDto {
  const factory GuideWithProgressDto({
    /// Completed steps count
    required int completedSteps,

    /// Guide ID
    required String id,

    /// Localized guide name
    required String name,

    /// Guide slug
    required String slug,

    /// Total steps count
    required int totalSteps,

    /// Icon identifier
    String? icon,
  }) = _GuideWithProgressDto;

  factory GuideWithProgressDto.fromJson(Map<String, Object?> json) =>
      _$GuideWithProgressDtoFromJson(json);
}
