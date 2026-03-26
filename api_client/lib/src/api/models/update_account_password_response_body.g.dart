// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_account_password_response_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UpdateAccountPasswordResponseBody _$UpdateAccountPasswordResponseBodyFromJson(
  Map<String, dynamic> json,
) => _UpdateAccountPasswordResponseBody(
  message: json['message'] as String,
  schema: json[r'$schema'] as String?,
);

Map<String, dynamic> _$UpdateAccountPasswordResponseBodyToJson(
  _UpdateAccountPasswordResponseBody instance,
) => <String, dynamic>{
  'message': instance.message,
  r'$schema': instance.schema,
};
