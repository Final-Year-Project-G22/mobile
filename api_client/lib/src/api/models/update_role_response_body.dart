// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'role_dto.dart';

part 'update_role_response_body.freezed.dart';
part 'update_role_response_body.g.dart';

@Freezed()
abstract class UpdateRoleResponseBody with _$UpdateRoleResponseBody {
  const factory UpdateRoleResponseBody({
    /// Updated role
    required RoleDto role,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _UpdateRoleResponseBody;

  factory UpdateRoleResponseBody.fromJson(Map<String, Object?> json) => _$UpdateRoleResponseBodyFromJson(json);
}
