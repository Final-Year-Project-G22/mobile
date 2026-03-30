// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'o_auth_callback_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OAuthCallbackResponse _$OAuthCallbackResponseFromJson(Map<String, dynamic> json) => _OAuthCallbackResponse(
  schema: json[r'$schema'] as String?,
  accessToken: json['accessToken'] as String?,
  account: json['account'] == null ? null : AccountDto.fromJson(json['account'] as Map<String, dynamic>),
  emailRequired: json['emailRequired'] == null
      ? null
      : OAuthEmailRequiredResponse.fromJson(json['emailRequired'] as Map<String, dynamic>),
  expiresAt: json['expiresAt'] == null ? null : DateTime.parse(json['expiresAt'] as String),
  isNewUser: json['isNewUser'] as bool?,
  refreshToken: json['refreshToken'] as String?,
  user: json['user'] == null ? null : UserDto.fromJson(json['user'] as Map<String, dynamic>),
);

Map<String, dynamic> _$OAuthCallbackResponseToJson(_OAuthCallbackResponse instance) => <String, dynamic>{
  r'$schema': instance.schema,
  'accessToken': instance.accessToken,
  'account': instance.account,
  'emailRequired': instance.emailRequired,
  'expiresAt': instance.expiresAt?.toIso8601String(),
  'isNewUser': instance.isNewUser,
  'refreshToken': instance.refreshToken,
  'user': instance.user,
};
