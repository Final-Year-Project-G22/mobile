// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'archive_notification_response_body.freezed.dart';
part 'archive_notification_response_body.g.dart';

@Freezed()
abstract class ArchiveNotificationResponseBody with _$ArchiveNotificationResponseBody {
  const factory ArchiveNotificationResponseBody({
    /// Success message
    required String message,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _ArchiveNotificationResponseBody;

  factory ArchiveNotificationResponseBody.fromJson(Map<String, Object?> json) =>
      _$ArchiveNotificationResponseBodyFromJson(json);
}
