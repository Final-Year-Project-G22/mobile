// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_scheduled_alert_request.freezed.dart';
part 'create_scheduled_alert_request.g.dart';

@Freezed()
abstract class CreateScheduledAlertRequest with _$CreateScheduledAlertRequest {
  const factory CreateScheduledAlertRequest({
    required String body,
    required List<dynamic>? channels,
    required DateTime scheduledFor,
    required String title,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
    String? templateSlug,
  }) = _CreateScheduledAlertRequest;

  factory CreateScheduledAlertRequest.fromJson(Map<String, Object?> json) =>
      _$CreateScheduledAlertRequestFromJson(json);
}
