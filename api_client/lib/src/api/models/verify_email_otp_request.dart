// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'verify_email_otp_request.freezed.dart';
part 'verify_email_otp_request.g.dart';

@Freezed()
abstract class VerifyEmailOtpRequest with _$VerifyEmailOtpRequest {
  const factory VerifyEmailOtpRequest({
    /// 6-digit verification code
    required String otp,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _VerifyEmailOtpRequest;

  factory VerifyEmailOtpRequest.fromJson(Map<String, Object?> json) =>
      _$VerifyEmailOtpRequestFromJson(json);
}
