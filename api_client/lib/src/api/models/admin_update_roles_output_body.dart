// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'admin_update_roles_output_body.freezed.dart';
part 'admin_update_roles_output_body.g.dart';

@Freezed()
abstract class AdminUpdateRolesOutputBody with _$AdminUpdateRolesOutputBody {
  const factory AdminUpdateRolesOutputBody({
    /// Status message
    required String message,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _AdminUpdateRolesOutputBody;

  factory AdminUpdateRolesOutputBody.fromJson(Map<String, Object?> json) =>
      _$AdminUpdateRolesOutputBodyFromJson(json);
}
