// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'list_followed_threads_response_body.freezed.dart';
part 'list_followed_threads_response_body.g.dart';

@Freezed()
abstract class ListFollowedThreadsResponseBody with _$ListFollowedThreadsResponseBody {
  const factory ListFollowedThreadsResponseBody({
    /// Followed threads
    required List<dynamic>? threads,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _ListFollowedThreadsResponseBody;

  factory ListFollowedThreadsResponseBody.fromJson(Map<String, Object?> json) =>
      _$ListFollowedThreadsResponseBodyFromJson(json);
}
