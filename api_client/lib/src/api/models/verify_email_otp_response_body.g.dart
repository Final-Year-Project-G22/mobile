// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_email_otp_response_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_VerifyEmailOtpResponseBody _$VerifyEmailOtpResponseBodyFromJson(
  Map<String, dynamic> json,
) => _VerifyEmailOtpResponseBody(
  message: json['message'] as String,
  schema: json[r'$schema'] as String?,
);

Map<String, dynamic> _$VerifyEmailOtpResponseBodyToJson(
  _VerifyEmailOtpResponseBody instance,
) => <String, dynamic>{
  'message': instance.message,
  r'$schema': instance.schema,
};
