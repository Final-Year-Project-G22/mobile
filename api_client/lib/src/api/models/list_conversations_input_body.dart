// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'list_conversations_input_body.freezed.dart';
part 'list_conversations_input_body.g.dart';

@Freezed()
abstract class ListConversationsInputBody with _$ListConversationsInputBody {
  const factory ListConversationsInputBody({
    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _ListConversationsInputBody;

  factory ListConversationsInputBody.fromJson(Map<String, Object?> json) => _$ListConversationsInputBodyFromJson(json);
}
