// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_avatar_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UploadAvatarResponse _$UploadAvatarResponseFromJson(
  Map<String, dynamic> json,
) => _UploadAvatarResponse(
  imageUrl: json['imageUrl'] as String,
  schema: json[r'$schema'] as String?,
);

Map<String, dynamic> _$UploadAvatarResponseToJson(
  _UploadAvatarResponse instance,
) => <String, dynamic>{
  'imageUrl': instance.imageUrl,
  r'$schema': instance.schema,
};
