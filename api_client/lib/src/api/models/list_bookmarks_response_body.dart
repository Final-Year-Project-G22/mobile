// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'list_bookmarks_response_body.freezed.dart';
part 'list_bookmarks_response_body.g.dart';

@Freezed()
abstract class ListBookmarksResponseBody with _$ListBookmarksResponseBody {
  const factory ListBookmarksResponseBody({
    required List<dynamic>? bookmarks,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _ListBookmarksResponseBody;

  factory ListBookmarksResponseBody.fromJson(Map<String, Object?> json) =>
      _$ListBookmarksResponseBodyFromJson(json);
}
