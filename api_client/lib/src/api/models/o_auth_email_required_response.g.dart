// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'o_auth_email_required_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OAuthEmailRequiredResponse _$OAuthEmailRequiredResponseFromJson(
  Map<String, dynamic> json,
) => _OAuthEmailRequiredResponse(
  firstName: json['firstName'] as String,
  lastName: json['lastName'] as String,
  name: json['name'] as String,
  provider: json['provider'] as String,
  state: json['state'] as String,
  subject: json['subject'] as String,
  pictureUrl: json['pictureUrl'] as String?,
);

Map<String, dynamic> _$OAuthEmailRequiredResponseToJson(
  _OAuthEmailRequiredResponse instance,
) => <String, dynamic>{
  'firstName': instance.firstName,
  'lastName': instance.lastName,
  'name': instance.name,
  'provider': instance.provider,
  'state': instance.state,
  'subject': instance.subject,
  'pictureUrl': instance.pictureUrl,
};
