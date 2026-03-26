// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'o_auth_identity_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OAuthIdentityDto _$OAuthIdentityDtoFromJson(Map<String, dynamic> json) =>
    _OAuthIdentityDto(
      provider: json['provider'] as String,
      lastUsedAt: json['lastUsedAt'] == null
          ? null
          : DateTime.parse(json['lastUsedAt'] as String),
      linkedAt: json['linkedAt'] == null
          ? null
          : DateTime.parse(json['linkedAt'] as String),
      providerEmail: json['providerEmail'] as String?,
    );

Map<String, dynamic> _$OAuthIdentityDtoToJson(_OAuthIdentityDto instance) =>
    <String, dynamic>{
      'provider': instance.provider,
      'lastUsedAt': instance.lastUsedAt?.toIso8601String(),
      'linkedAt': instance.linkedAt?.toIso8601String(),
      'providerEmail': instance.providerEmail,
    };
