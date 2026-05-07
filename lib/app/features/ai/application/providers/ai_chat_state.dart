import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/chat_message.dart';

part 'ai_chat_state.freezed.dart';

@freezed
abstract class AiChatState with _$AiChatState {
  const factory AiChatState({
    @Default([]) List<ChatMessage> messages,
    String? sessionId,
    @Default(false) bool isStreaming,
    String? streamError,
  }) = _AiChatState;
}
