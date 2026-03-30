// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_account_password_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UpdateAccountPasswordRequest _$UpdateAccountPasswordRequestFromJson(
  Map<String, dynamic> json,
) => _UpdateAccountPasswordRequest(
  confirmPassword: json['confirmPassword'] as String,
  existingPassword: json['existingPassword'] as String,
  newPassword: json['newPassword'] as String,
  schema: json[r'$schema'] as String?,
);

Map<String, dynamic> _$UpdateAccountPasswordRequestToJson(
  _UpdateAccountPasswordRequest instance,
) => <String, dynamic>{
  'confirmPassword': instance.confirmPassword,
  'existingPassword': instance.existingPassword,
  'newPassword': instance.newPassword,
  r'$schema': instance.schema,
};
