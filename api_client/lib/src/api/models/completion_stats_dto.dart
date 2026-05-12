// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'completion_stats_dto.freezed.dart';
part 'completion_stats_dto.g.dart';

@Freezed()
abstract class CompletionStatsDto with _$CompletionStatsDto {
  const factory CompletionStatsDto({
    /// Number of fully completed guides
    required int completedGuides,

    /// Number of guides in progress
    required int inProgressGuides,

    /// Stats period (e.g. monthly)
    required String period,

    /// Total steps across all guides
    required int totalStepsAll,

    /// Total steps completed across all guides
    required int totalStepsCompleted,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _CompletionStatsDto;

  factory CompletionStatsDto.fromJson(Map<String, Object?> json) =>
      _$CompletionStatsDtoFromJson(json);
}
