// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'admin_list_response_body.freezed.dart';
part 'admin_list_response_body.g.dart';

@Freezed()
abstract class AdminListResponseBody with _$AdminListResponseBody {
  const factory AdminListResponseBody({
    /// List of admin accounts
    required List<dynamic>? admins,

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
  }) = _AdminListResponseBody;

  factory AdminListResponseBody.fromJson(Map<String, Object?> json) =>
      _$AdminListResponseBodyFromJson(json);
}
