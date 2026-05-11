// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_account_password_request.freezed.dart';
part 'update_account_password_request.g.dart';

@Freezed()
abstract class UpdateAccountPasswordRequest with _$UpdateAccountPasswordRequest {
  const factory UpdateAccountPasswordRequest({
    /// Password (min 8 chars, 1 uppercase, 1 lowercase, 1 digit)
    required String confirmPassword,

    /// Password
    required String existingPassword,

    /// Password (min 8 chars, 1 uppercase, 1 lowercase, 1 digit)
    required String newPassword,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _UpdateAccountPasswordRequest;

  factory UpdateAccountPasswordRequest.fromJson(Map<String, Object?> json) =>
      _$UpdateAccountPasswordRequestFromJson(json);
}
