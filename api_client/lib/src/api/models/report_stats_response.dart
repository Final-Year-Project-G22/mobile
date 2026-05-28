// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'report_stats_response.freezed.dart';
part 'report_stats_response.g.dart';

@Freezed()
abstract class ReportStatsResponse with _$ReportStatsResponse {
  const factory ReportStatsResponse({
    /// Pending reports
    required int pending,

    /// Resolved reports
    required int resolved,

    /// Total reports
    required int total,

    /// Percentage change vs previous period
    required double trendPercent,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _ReportStatsResponse;

  factory ReportStatsResponse.fromJson(Map<String, Object?> json) =>
      _$ReportStatsResponseFromJson(json);
}
