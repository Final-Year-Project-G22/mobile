// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'activity_logs_response.freezed.dart';
part 'activity_logs_response.g.dart';

@Freezed()
abstract class ActivityLogsResponse with _$ActivityLogsResponse {
  const factory ActivityLogsResponse({
    required List<dynamic>? data,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _ActivityLogsResponse;

  factory ActivityLogsResponse.fromJson(Map<String, Object?> json) =>
      _$ActivityLogsResponseFromJson(json);
}
