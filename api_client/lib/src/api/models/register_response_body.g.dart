// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_response_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RegisterResponseBody _$RegisterResponseBodyFromJson(
  Map<String, dynamic> json,
) => _RegisterResponseBody(
  accessToken: json['accessToken'] as String,
  account: AccountDto.fromJson(json['account'] as Map<String, dynamic>),
  expiresAt: DateTime.parse(json['expiresAt'] as String),
  user: UserDto.fromJson(json['user'] as Map<String, dynamic>),
  schema: json[r'$schema'] as String?,
);

Map<String, dynamic> _$RegisterResponseBodyToJson(
  _RegisterResponseBody instance,
) => <String, dynamic>{
  'accessToken': instance.accessToken,
  'account': instance.account,
  'expiresAt': instance.expiresAt.toIso8601String(),
  'user': instance.user,
  r'$schema': instance.schema,
};
