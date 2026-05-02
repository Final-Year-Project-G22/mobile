// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'guide_progress_summary_dto.freezed.dart';
part 'guide_progress_summary_dto.g.dart';

@Freezed()
abstract class GuideProgressSummaryDto with _$GuideProgressSummaryDto {
  const factory GuideProgressSummaryDto({
    /// Completed steps count
    required int completedSteps,

    /// In-progress steps count
    required int inProgressSteps,

    /// Skipped steps count
    required int skippedSteps,

    /// Total number of steps
    required int totalSteps,
  }) = _GuideProgressSummaryDto;

  factory GuideProgressSummaryDto.fromJson(Map<String, Object?> json) =>
      _$GuideProgressSummaryDtoFromJson(json);
}
