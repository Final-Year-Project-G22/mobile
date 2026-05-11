// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'verify_email_otp_response_body.freezed.dart';
part 'verify_email_otp_response_body.g.dart';

@Freezed()
abstract class VerifyEmailOtpResponseBody with _$VerifyEmailOtpResponseBody {
  const factory VerifyEmailOtpResponseBody({
    /// Verification status message
    required String message,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _VerifyEmailOtpResponseBody;

  factory VerifyEmailOtpResponseBody.fromJson(Map<String, Object?> json) =>
      _$VerifyEmailOtpResponseBodyFromJson(json);
}
