import 'package:freezed_annotation/freezed_annotation.dart';

import 'chat_message.dart';
import 'conversation_summary.dart';

part 'conversation_result.freezed.dart';

@freezed
abstract class ConversationResult with _$ConversationResult {
  const factory ConversationResult({
    required ConversationSummary session,
    required List<ChatMessage> messages,
    required int totalMsgs,
  }) = _ConversationResult;
}
