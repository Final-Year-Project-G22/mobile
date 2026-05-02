// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_bookmark_response_body.freezed.dart';
part 'add_bookmark_response_body.g.dart';

@Freezed()
abstract class AddBookmarkResponseBody with _$AddBookmarkResponseBody {
  const factory AddBookmarkResponseBody({
    /// Success message
    required String message,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _AddBookmarkResponseBody;

  factory AddBookmarkResponseBody.fromJson(Map<String, Object?> json) =>
      _$AddBookmarkResponseBodyFromJson(json);
}
