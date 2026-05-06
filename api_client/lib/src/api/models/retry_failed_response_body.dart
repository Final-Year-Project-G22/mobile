// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'retry_failed_response_body.freezed.dart';
part 'retry_failed_response_body.g.dart';

@Freezed()
abstract class RetryFailedResponseBody with _$RetryFailedResponseBody {
  const factory RetryFailedResponseBody({
    /// Success message
    required String message,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _RetryFailedResponseBody;

  factory RetryFailedResponseBody.fromJson(Map<String, Object?> json) => _$RetryFailedResponseBodyFromJson(json);
}
