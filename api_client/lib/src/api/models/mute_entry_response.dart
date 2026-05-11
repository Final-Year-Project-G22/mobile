// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'mute_entry_response.freezed.dart';
part 'mute_entry_response.g.dart';

@Freezed()
abstract class MuteEntryResponse with _$MuteEntryResponse {
  const factory MuteEntryResponse({
    /// When the mute was created
    required String? createdAt,

    /// Mute entry ID
    required String id,

    /// Muted account ID
    required String mutedAccountId,

    /// Expiration time
    DateTime? muteUntil,

    /// Reason for muting
    String? reason,
  }) = _MuteEntryResponse;

  factory MuteEntryResponse.fromJson(Map<String, Object?> json) =>
      _$MuteEntryResponseFromJson(json);
}
