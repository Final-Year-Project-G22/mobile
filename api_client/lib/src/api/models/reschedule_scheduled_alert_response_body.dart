// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'reschedule_scheduled_alert_response_body.freezed.dart';
part 'reschedule_scheduled_alert_response_body.g.dart';

@Freezed()
abstract class RescheduleScheduledAlertResponseBody
    with _$RescheduleScheduledAlertResponseBody {
  const factory RescheduleScheduledAlertResponseBody({
    required String message,
    required DateTime previousScheduledFor,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _RescheduleScheduledAlertResponseBody;

  factory RescheduleScheduledAlertResponseBody.fromJson(
    Map<String, Object?> json,
  ) => _$RescheduleScheduledAlertResponseBodyFromJson(json);
}
