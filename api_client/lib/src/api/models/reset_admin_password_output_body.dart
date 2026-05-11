// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'reset_admin_password_output_body.freezed.dart';
part 'reset_admin_password_output_body.g.dart';

@Freezed()
abstract class ResetAdminPasswordOutputBody with _$ResetAdminPasswordOutputBody {
  const factory ResetAdminPasswordOutputBody({
    /// Status message
    required String message,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _ResetAdminPasswordOutputBody;

  factory ResetAdminPasswordOutputBody.fromJson(Map<String, Object?> json) =>
      _$ResetAdminPasswordOutputBodyFromJson(json);
}
