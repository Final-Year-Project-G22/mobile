// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'my_download_response.freezed.dart';
part 'my_download_response.g.dart';

@Freezed()
abstract class MyDownloadResponse with _$MyDownloadResponse {
  const factory MyDownloadResponse({
    /// Download timestamp
    required String downloadedAt,

    /// Group ID
    required String groupId,

    /// Download log ID
    required String id,

    /// Template ID
    required String templateId,
  }) = _MyDownloadResponse;

  factory MyDownloadResponse.fromJson(Map<String, Object?> json) => _$MyDownloadResponseFromJson(json);
}
