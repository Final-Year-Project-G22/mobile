// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_admin_status_request.freezed.dart';
part 'update_admin_status_request.g.dart';

@Freezed()
abstract class UpdateAdminStatusRequest with _$UpdateAdminStatusRequest {
  const factory UpdateAdminStatusRequest({
    /// New status (active, locked, suspended)
    required String status,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _UpdateAdminStatusRequest;

  factory UpdateAdminStatusRequest.fromJson(Map<String, Object?> json) =>
      _$UpdateAdminStatusRequestFromJson(json);
}
