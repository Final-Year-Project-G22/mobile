// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'block_reported_user_request.freezed.dart';
part 'block_reported_user_request.g.dart';

@Freezed()
abstract class BlockReportedUserRequest with _$BlockReportedUserRequest {
  const factory BlockReportedUserRequest({
    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,

    /// Reason for blocking user
    String? reason,
  }) = _BlockReportedUserRequest;

  factory BlockReportedUserRequest.fromJson(Map<String, Object?> json) =>
      _$BlockReportedUserRequestFromJson(json);
}
