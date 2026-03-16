// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ErrorModel _$ErrorModelFromJson(Map<String, dynamic> json) => _ErrorModel(
  type: json['type'] as String? ?? 'about:blank',
  schema: json[r'$schema'] as String?,
  detail: json['detail'] as String?,
  errors: json['errors'] as List<dynamic>?,
  instance: json['instance'] as String?,
  status: (json['status'] as num?)?.toInt(),
  title: json['title'] as String?,
);

Map<String, dynamic> _$ErrorModelToJson(_ErrorModel instance) =>
    <String, dynamic>{
      'type': instance.type,
      r'$schema': instance.schema,
      'detail': instance.detail,
      'errors': instance.errors,
      'instance': instance.instance,
      'status': instance.status,
      'title': instance.title,
    };
