// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'o_auth_unlink_output_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OAuthUnlinkOutputBody _$OAuthUnlinkOutputBodyFromJson(
  Map<String, dynamic> json,
) => _OAuthUnlinkOutputBody(
  unlinked: json['unlinked'] as String,
  schema: json[r'$schema'] as String?,
);

Map<String, dynamic> _$OAuthUnlinkOutputBodyToJson(
  _OAuthUnlinkOutputBody instance,
) => <String, dynamic>{
  'unlinked': instance.unlinked,
  r'$schema': instance.schema,
};
