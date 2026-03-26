// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'o_auth_complete_email_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OAuthCompleteEmailRequest _$OAuthCompleteEmailRequestFromJson(
  Map<String, dynamic> json,
) => _OAuthCompleteEmailRequest(
  email: json['email'] as String,
  state: json['state'] as String,
  schema: json[r'$schema'] as String?,
);

Map<String, dynamic> _$OAuthCompleteEmailRequestToJson(
  _OAuthCompleteEmailRequest instance,
) => <String, dynamic>{
  'email': instance.email,
  'state': instance.state,
  r'$schema': instance.schema,
};
