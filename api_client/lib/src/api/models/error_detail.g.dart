// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ErrorDetail _$ErrorDetailFromJson(Map<String, dynamic> json) => _ErrorDetail(
  location: json['location'] as String?,
  message: json['message'] as String?,
  value: json['value'],
);

Map<String, dynamic> _$ErrorDetailToJson(_ErrorDetail instance) =>
    <String, dynamic>{
      'location': instance.location,
      'message': instance.message,
      'value': instance.value,
    };
