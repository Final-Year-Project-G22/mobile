// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'delete_role_output_body.freezed.dart';
part 'delete_role_output_body.g.dart';

@Freezed()
abstract class DeleteRoleOutputBody with _$DeleteRoleOutputBody {
  const factory DeleteRoleOutputBody({
    /// Status message
    required String message,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _DeleteRoleOutputBody;

  factory DeleteRoleOutputBody.fromJson(Map<String, Object?> json) =>
      _$DeleteRoleOutputBodyFromJson(json);
}
