// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_conversation_input_body.freezed.dart';
part 'get_conversation_input_body.g.dart';

@Freezed()
abstract class GetConversationInputBody with _$GetConversationInputBody {
  const factory GetConversationInputBody({
    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _GetConversationInputBody;

  factory GetConversationInputBody.fromJson(Map<String, Object?> json) => _$GetConversationInputBodyFromJson(json);
}
