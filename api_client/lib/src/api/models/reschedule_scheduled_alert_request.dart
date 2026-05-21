// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'reschedule_scheduled_alert_request.freezed.dart';
part 'reschedule_scheduled_alert_request.g.dart';

@Freezed()
abstract class RescheduleScheduledAlertRequest
    with _$RescheduleScheduledAlertRequest {
  const factory RescheduleScheduledAlertRequest({
    required DateTime scheduledFor,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _RescheduleScheduledAlertRequest;

  factory RescheduleScheduledAlertRequest.fromJson(Map<String, Object?> json) =>
      _$RescheduleScheduledAlertRequestFromJson(json);
}
