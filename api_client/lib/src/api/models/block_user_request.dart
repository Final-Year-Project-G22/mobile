// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'block_user_request.freezed.dart';
part 'block_user_request.g.dart';

@Freezed()
abstract class BlockUserRequest with _$BlockUserRequest {
  const factory BlockUserRequest({
    /// Blocked account ID
    required String blockedId,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,

    /// Block reason
    String? reason,
  }) = _BlockUserRequest;

  factory BlockUserRequest.fromJson(Map<String, Object?> json) => _$BlockUserRequestFromJson(json);
}
