// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_current_user_response_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GetCurrentUserResponseBody _$GetCurrentUserResponseBodyFromJson(Map<String, dynamic> json) =>
    _GetCurrentUserResponseBody(
      account: AccountDto.fromJson(json['account'] as Map<String, dynamic>),
      user: UserDto.fromJson(json['user'] as Map<String, dynamic>),
      schema: json[r'$schema'] as String?,
    );

Map<String, dynamic> _$GetCurrentUserResponseBodyToJson(_GetCurrentUserResponseBody instance) => <String, dynamic>{
  'account': instance.account,
  'user': instance.user,
  r'$schema': instance.schema,
};
