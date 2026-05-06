// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'list_thread_reports_response_body.freezed.dart';
part 'list_thread_reports_response_body.g.dart';

@Freezed()
abstract class ListThreadReportsResponseBody with _$ListThreadReportsResponseBody {
  const factory ListThreadReportsResponseBody({
    /// Current page
    required int page,

    /// Page size
    required int pageSize,

    /// Thread report list
    required List<dynamic>? reports,

    /// Total count
    required int total,

    /// Total pages
    required int totalPages,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _ListThreadReportsResponseBody;

  factory ListThreadReportsResponseBody.fromJson(Map<String, Object?> json) =>
      _$ListThreadReportsResponseBodyFromJson(json);
}
