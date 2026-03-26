// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'o_auth_link_callback_output_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OAuthLinkCallbackOutputBody _$OAuthLinkCallbackOutputBodyFromJson(
  Map<String, dynamic> json,
) => _OAuthLinkCallbackOutputBody(
  provider: json['provider'] as String,
  schema: json[r'$schema'] as String?,
);

Map<String, dynamic> _$OAuthLinkCallbackOutputBodyToJson(
  _OAuthLinkCallbackOutputBody instance,
) => <String, dynamic>{
  'provider': instance.provider,
  r'$schema': instance.schema,
};
