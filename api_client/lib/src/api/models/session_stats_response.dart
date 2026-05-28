// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'session_stats_response.freezed.dart';
part 'session_stats_response.g.dart';

@Freezed()
abstract class SessionStatsResponse with _$SessionStatsResponse {
  const factory SessionStatsResponse({
    /// Daily average active sessions
    required int dailyAvg,

    /// Current active sessions
    required int total,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _SessionStatsResponse;

  factory SessionStatsResponse.fromJson(Map<String, Object?> json) =>
      _$SessionStatsResponseFromJson(json);
}
