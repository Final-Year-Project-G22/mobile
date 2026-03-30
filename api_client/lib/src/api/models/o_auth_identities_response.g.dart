// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'o_auth_identities_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OAuthIdentitiesResponse _$OAuthIdentitiesResponseFromJson(
  Map<String, dynamic> json,
) => _OAuthIdentitiesResponse(
  identities: json['identities'] as List<dynamic>?,
  schema: json[r'$schema'] as String?,
);

Map<String, dynamic> _$OAuthIdentitiesResponseToJson(
  _OAuthIdentitiesResponse instance,
) => <String, dynamic>{
  'identities': instance.identities,
  r'$schema': instance.schema,
};
