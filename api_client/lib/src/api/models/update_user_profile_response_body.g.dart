// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_user_profile_response_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UpdateUserProfileResponseBody _$UpdateUserProfileResponseBodyFromJson(Map<String, dynamic> json) =>
    _UpdateUserProfileResponseBody(
      bio: json['bio'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      schema: json[r'$schema'] as String?,
    );

Map<String, dynamic> _$UpdateUserProfileResponseBodyToJson(_UpdateUserProfileResponseBody instance) =>
    <String, dynamic>{
      'bio': instance.bio,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      r'$schema': instance.schema,
    };
