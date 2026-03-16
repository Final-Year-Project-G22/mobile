// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserDto _$UserDtoFromJson(Map<String, dynamic> json) => _UserDto(
  firstName: json['firstName'] as String,
  id: json['id'] as String,
  lastName: json['lastName'] as String,
  bio: json['bio'] as String?,
  imageUrl: json['imageUrl'] as String?,
);

Map<String, dynamic> _$UserDtoToJson(_UserDto instance) => <String, dynamic>{
  'firstName': instance.firstName,
  'id': instance.id,
  'lastName': instance.lastName,
  'bio': instance.bio,
  'imageUrl': instance.imageUrl,
};
