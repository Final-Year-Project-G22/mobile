// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'download_log_list_response.freezed.dart';
part 'download_log_list_response.g.dart';

@Freezed()
abstract class DownloadLogListResponse with _$DownloadLogListResponse {
  const factory DownloadLogListResponse({
    /// Download logs
    required List<dynamic>? data,

    /// Current page
    required int page,

    /// Items per page
    required int pageSize,

    /// Total count
    required int total,

    /// Total pages
    required int totalPages,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _DownloadLogListResponse;

  factory DownloadLogListResponse.fromJson(Map<String, Object?> json) =>
      _$DownloadLogListResponseFromJson(json);
}
