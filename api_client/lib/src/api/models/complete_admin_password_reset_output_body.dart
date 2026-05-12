// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'complete_admin_password_reset_output_body.freezed.dart';
part 'complete_admin_password_reset_output_body.g.dart';

@Freezed()
abstract class CompleteAdminPasswordResetOutputBody with _$CompleteAdminPasswordResetOutputBody {
  const factory CompleteAdminPasswordResetOutputBody({
    /// Status message
    required String message,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _CompleteAdminPasswordResetOutputBody;

  factory CompleteAdminPasswordResetOutputBody.fromJson(Map<String, Object?> json) =>
      _$CompleteAdminPasswordResetOutputBodyFromJson(json);
}
