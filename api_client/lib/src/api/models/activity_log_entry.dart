// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'activity_log_entry.freezed.dart';
part 'activity_log_entry.g.dart';

@Freezed()
abstract class ActivityLogEntry with _$ActivityLogEntry {
  const factory ActivityLogEntry({
    /// Action description
    required String action,

    /// Admin display name
    required String adminName,

    /// Target entity
    required String target,

    /// When the action occurred
    required DateTime timestamp,
  }) = _ActivityLogEntry;

  factory ActivityLogEntry.fromJson(Map<String, Object?> json) =>
      _$ActivityLogEntryFromJson(json);
}
