// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'list_blocked_users_response_body.freezed.dart';
part 'list_blocked_users_response_body.g.dart';

@Freezed()
abstract class ListBlockedUsersResponseBody
    with _$ListBlockedUsersResponseBody {
  const factory ListBlockedUsersResponseBody({
    /// Blocked users list
    required List<dynamic>? blockedUsers,

    /// Current page
    required int page,

    /// Page size
    required int pageSize,

    /// Total count
    required int total,

    /// Total pages
    required int totalPages,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _ListBlockedUsersResponseBody;

  factory ListBlockedUsersResponseBody.fromJson(Map<String, Object?> json) =>
      _$ListBlockedUsersResponseBodyFromJson(json);
}
