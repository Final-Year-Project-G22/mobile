// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_o_auth_providers_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GetOAuthProvidersResponse _$GetOAuthProvidersResponseFromJson(
  Map<String, dynamic> json,
) => _GetOAuthProvidersResponse(
  providers: json['providers'] as List<dynamic>?,
  schema: json[r'$schema'] as String?,
);

Map<String, dynamic> _$GetOAuthProvidersResponseToJson(
  _GetOAuthProvidersResponse instance,
) => <String, dynamic>{
  'providers': instance.providers,
  r'$schema': instance.schema,
};
