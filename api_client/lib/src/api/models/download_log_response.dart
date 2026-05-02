// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'download_log_response.freezed.dart';
part 'download_log_response.g.dart';

@Freezed()
abstract class DownloadLogResponse with _$DownloadLogResponse {
  const factory DownloadLogResponse({
    /// Account ID
    required String accountId,

    /// Download timestamp
    required DateTime downloadedAt,

    /// Group ID
    required String groupId,

    /// Download log ID
    required String id,

    /// Template ID
    required String templateId,
  }) = _DownloadLogResponse;

  factory DownloadLogResponse.fromJson(Map<String, Object?> json) =>
      _$DownloadLogResponseFromJson(json);
}
