// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_bookmark_note_request.freezed.dart';
part 'update_bookmark_note_request.g.dart';

@Freezed()
abstract class UpdateBookmarkNoteRequest with _$UpdateBookmarkNoteRequest {
  const factory UpdateBookmarkNoteRequest({
    /// Bookmark note
    required String? note,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _UpdateBookmarkNoteRequest;

  factory UpdateBookmarkNoteRequest.fromJson(Map<String, Object?> json) => _$UpdateBookmarkNoteRequestFromJson(json);
}
