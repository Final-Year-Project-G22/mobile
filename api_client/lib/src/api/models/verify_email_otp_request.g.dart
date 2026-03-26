// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_email_otp_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_VerifyEmailOtpRequest _$VerifyEmailOtpRequestFromJson(
  Map<String, dynamic> json,
) => _VerifyEmailOtpRequest(
  otp: json['otp'] as String,
  schema: json[r'$schema'] as String?,
);

Map<String, dynamic> _$VerifyEmailOtpRequestToJson(
  _VerifyEmailOtpRequest instance,
) => <String, dynamic>{'otp': instance.otp, r'$schema': instance.schema};
