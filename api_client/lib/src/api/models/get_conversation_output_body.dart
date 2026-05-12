// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'conversation_dto.dart';

part 'get_conversation_output_body.freezed.dart';
part 'get_conversation_output_body.g.dart';

@Freezed()
abstract class GetConversationOutputBody with _$GetConversationOutputBody {
  const factory GetConversationOutputBody({
    required List<dynamic>? messages,
    required ConversationDto session,
    required int totalMsgs,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _GetConversationOutputBody;

  factory GetConversationOutputBody.fromJson(Map<String, Object?> json) => _$GetConversationOutputBodyFromJson(json);
}
