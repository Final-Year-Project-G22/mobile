// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'block_reported_user_response_body.freezed.dart';
part 'block_reported_user_response_body.g.dart';

@Freezed()
abstract class BlockReportedUserResponseBody
    with _$BlockReportedUserResponseBody {
  const factory BlockReportedUserResponseBody({
    /// Message
    required String message,

    /// Success
    required bool success,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _BlockReportedUserResponseBody;

  factory BlockReportedUserResponseBody.fromJson(Map<String, Object?> json) =>
      _$BlockReportedUserResponseBodyFromJson(json);
}
