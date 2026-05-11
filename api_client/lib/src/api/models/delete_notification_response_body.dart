// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'delete_notification_response_body.freezed.dart';
part 'delete_notification_response_body.g.dart';

@Freezed()
abstract class DeleteNotificationResponseBody
    with _$DeleteNotificationResponseBody {
  const factory DeleteNotificationResponseBody({
    /// Success message
    required String message,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _DeleteNotificationResponseBody;

  factory DeleteNotificationResponseBody.fromJson(Map<String, Object?> json) =>
      _$DeleteNotificationResponseBodyFromJson(json);
}
