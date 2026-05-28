// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_stats_response.freezed.dart';
part 'user_stats_response.g.dart';

@Freezed()
abstract class UserStatsResponse with _$UserStatsResponse {
  const factory UserStatsResponse({
    /// Total number of accounts
    required int total,

    /// Percentage change vs previous period
    required double trendPercent,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _UserStatsResponse;

  factory UserStatsResponse.fromJson(Map<String, Object?> json) =>
      _$UserStatsResponseFromJson(json);
}
