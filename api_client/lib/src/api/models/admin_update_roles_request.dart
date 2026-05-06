// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'admin_update_roles_request.freezed.dart';
part 'admin_update_roles_request.g.dart';

@Freezed()
abstract class AdminUpdateRolesRequest with _$AdminUpdateRolesRequest {
  const factory AdminUpdateRolesRequest({
    /// Role IDs
    required List<dynamic>? roleIds,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _AdminUpdateRolesRequest;

  factory AdminUpdateRolesRequest.fromJson(Map<String, Object?> json) => _$AdminUpdateRolesRequestFromJson(json);
}
