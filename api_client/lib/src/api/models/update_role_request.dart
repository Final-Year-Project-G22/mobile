// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_role_request.freezed.dart';
part 'update_role_request.g.dart';

@Freezed()
abstract class UpdateRoleRequest with _$UpdateRoleRequest {
  const factory UpdateRoleRequest({
    /// Permissions for role
    required List<dynamic>? permissionIds,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,

    /// Role description
    String? description,

    /// Role name
    String? name,
  }) = _UpdateRoleRequest;

  factory UpdateRoleRequest.fromJson(Map<String, Object?> json) => _$UpdateRoleRequestFromJson(json);
}
