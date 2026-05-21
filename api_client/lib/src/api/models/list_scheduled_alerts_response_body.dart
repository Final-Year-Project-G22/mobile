// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'list_scheduled_alerts_response_body.freezed.dart';
part 'list_scheduled_alerts_response_body.g.dart';

@Freezed()
abstract class ListScheduledAlertsResponseBody
    with _$ListScheduledAlertsResponseBody {
  const factory ListScheduledAlertsResponseBody({
    required List<dynamic>? data,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _ListScheduledAlertsResponseBody;

  factory ListScheduledAlertsResponseBody.fromJson(Map<String, Object?> json) =>
      _$ListScheduledAlertsResponseBodyFromJson(json);
}
