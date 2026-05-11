// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_admin_status_output_body.freezed.dart';
part 'update_admin_status_output_body.g.dart';

@Freezed()
abstract class UpdateAdminStatusOutputBody with _$UpdateAdminStatusOutputBody {
  const factory UpdateAdminStatusOutputBody({
    /// Status message
    required String message,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _UpdateAdminStatusOutputBody;

  factory UpdateAdminStatusOutputBody.fromJson(Map<String, Object?> json) =>
      _$UpdateAdminStatusOutputBodyFromJson(json);
}
