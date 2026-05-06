// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'list_mutes_response_body.freezed.dart';
part 'list_mutes_response_body.g.dart';

@Freezed()
abstract class ListMutesResponseBody with _$ListMutesResponseBody {
  const factory ListMutesResponseBody({
    /// Muted accounts
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
  }) = _ListMutesResponseBody;

  factory ListMutesResponseBody.fromJson(Map<String, Object?> json) => _$ListMutesResponseBodyFromJson(json);
}
