// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'complete_admin_password_reset_request.freezed.dart';
part 'complete_admin_password_reset_request.g.dart';

@Freezed()
abstract class CompleteAdminPasswordResetRequest
    with _$CompleteAdminPasswordResetRequest {
  const factory CompleteAdminPasswordResetRequest({
    /// Confirm new password
    required String confirmPassword,

    /// New password (min 8 chars, 1 uppercase, 1 lowercase, 1 digit)
    required String newPassword,

    /// Reset token
    required String token,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _CompleteAdminPasswordResetRequest;

  factory CompleteAdminPasswordResetRequest.fromJson(
    Map<String, Object?> json,
  ) => _$CompleteAdminPasswordResetRequestFromJson(json);
}
