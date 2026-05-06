// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'list_post_reports_response_body.freezed.dart';
part 'list_post_reports_response_body.g.dart';

@Freezed()
abstract class ListPostReportsResponseBody with _$ListPostReportsResponseBody {
  const factory ListPostReportsResponseBody({
    /// Current page
    required int page,

    /// Page size
    required int pageSize,

    /// Post report list
    required List<dynamic>? reports,

    /// Total count
    required int total,

    /// Total pages
    required int totalPages,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _ListPostReportsResponseBody;

  factory ListPostReportsResponseBody.fromJson(Map<String, Object?> json) =>
      _$ListPostReportsResponseBodyFromJson(json);
}
