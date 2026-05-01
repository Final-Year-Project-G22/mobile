// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_role_request.freezed.dart';
part 'create_role_request.g.dart';

@Freezed()
abstract class CreateRoleRequest with _$CreateRoleRequest {
  const factory CreateRoleRequest({
    /// Role code
    required String code,

    /// Role name
    required String name,

    /// Permissions for role
    required List<dynamic>? permissionIds,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,

    /// Role description
    String? description,
  }) = _CreateRoleRequest;

  factory CreateRoleRequest.fromJson(Map<String, Object?> json) =>
      _$CreateRoleRequestFromJson(json);
}
