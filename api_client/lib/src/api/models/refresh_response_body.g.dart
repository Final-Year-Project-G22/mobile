// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refresh_response_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RefreshResponseBody _$RefreshResponseBodyFromJson(Map<String, dynamic> json) =>
    _RefreshResponseBody(
      accessToken: json['accessToken'] as String,
      expiresAt: DateTime.parse(json['expiresAt'] as String),
      schema: json[r'$schema'] as String?,
    );

Map<String, dynamic> _$RefreshResponseBodyToJson(
  _RefreshResponseBody instance,
) => <String, dynamic>{
  'accessToken': instance.accessToken,
  'expiresAt': instance.expiresAt.toIso8601String(),
  r'$schema': instance.schema,
};
