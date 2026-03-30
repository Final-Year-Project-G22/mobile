// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_file.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FormFile _$FormFileFromJson(Map<String, dynamic> json) => _FormFile(
  contentType: json['ContentType'] as String,
  filename: json['Filename'] as String,
  isSet: json['IsSet'] as bool,
  size: (json['Size'] as num).toInt(),
);

Map<String, dynamic> _$FormFileToJson(_FormFile instance) => <String, dynamic>{
  'ContentType': instance.contentType,
  'Filename': instance.filename,
  'IsSet': instance.isSet,
  'Size': instance.size,
};
