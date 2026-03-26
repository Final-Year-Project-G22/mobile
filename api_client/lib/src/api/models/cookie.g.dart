// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cookie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Cookie _$CookieFromJson(Map<String, dynamic> json) => _Cookie(
  domain: json['Domain'] as String,
  expires: DateTime.parse(json['Expires'] as String),
  httpOnly: json['HttpOnly'] as bool,
  maxAge: (json['MaxAge'] as num).toInt(),
  name: json['Name'] as String,
  partitioned: json['Partitioned'] as bool,
  path: json['Path'] as String,
  quoted: json['Quoted'] as bool,
  raw: json['Raw'] as String,
  rawExpires: json['RawExpires'] as String,
  sameSite: (json['SameSite'] as num).toInt(),
  secure: json['Secure'] as bool,
  unparsed: json['Unparsed'] as List<dynamic>?,
  value: json['Value'] as String,
);

Map<String, dynamic> _$CookieToJson(_Cookie instance) => <String, dynamic>{
  'Domain': instance.domain,
  'Expires': instance.expires.toIso8601String(),
  'HttpOnly': instance.httpOnly,
  'MaxAge': instance.maxAge,
  'Name': instance.name,
  'Partitioned': instance.partitioned,
  'Path': instance.path,
  'Quoted': instance.quoted,
  'Raw': instance.raw,
  'RawExpires': instance.rawExpires,
  'SameSite': instance.sameSite,
  'Secure': instance.secure,
  'Unparsed': instance.unparsed,
  'Value': instance.value,
};
