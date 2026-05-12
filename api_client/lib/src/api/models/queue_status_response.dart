// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'queue_status_response.freezed.dart';
part 'queue_status_response.g.dart';

@Freezed()
abstract class QueueStatusResponse with _$QueueStatusResponse {
  const factory QueueStatusResponse({
    /// Number of cancelled notifications
    required int cancelled,

    /// Number of delivered notifications
    required int delivered,

    /// Number of failed notifications
    required int failed,

    /// Number of pending notifications
    required int pending,

    /// Number of processing notifications
    required int processing,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _QueueStatusResponse;

  factory QueueStatusResponse.fromJson(Map<String, Object?> json) =>
      _$QueueStatusResponseFromJson(json);
}
