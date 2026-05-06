// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'mute_account_request.freezed.dart';
part 'mute_account_request.g.dart';

@Freezed()
abstract class MuteAccountRequest with _$MuteAccountRequest {
  const factory MuteAccountRequest({
    /// Account ID to mute
    required String mutedAccountId,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,

    /// Optional expiration time
    DateTime? muteUntil,

    /// Reason for muting
    String? reason,
  }) = _MuteAccountRequest;

  factory MuteAccountRequest.fromJson(Map<String, Object?> json) => _$MuteAccountRequestFromJson(json);
}
