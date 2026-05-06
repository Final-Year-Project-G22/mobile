// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'archive_conversation_input_body.freezed.dart';
part 'archive_conversation_input_body.g.dart';

@Freezed()
abstract class ArchiveConversationInputBody with _$ArchiveConversationInputBody {
  const factory ArchiveConversationInputBody({
    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _ArchiveConversationInputBody;

  factory ArchiveConversationInputBody.fromJson(Map<String, Object?> json) =>
      _$ArchiveConversationInputBodyFromJson(json);
}
