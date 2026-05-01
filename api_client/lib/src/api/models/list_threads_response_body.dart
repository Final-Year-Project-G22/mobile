// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'list_threads_response_body.freezed.dart';
part 'list_threads_response_body.g.dart';

@Freezed()
abstract class ListThreadsResponseBody with _$ListThreadsResponseBody {
  const factory ListThreadsResponseBody({
    /// Thread list
    required List<dynamic>? threads,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _ListThreadsResponseBody;

  factory ListThreadsResponseBody.fromJson(Map<String, Object?> json) =>
      _$ListThreadsResponseBodyFromJson(json);
}
