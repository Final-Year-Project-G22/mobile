import 'package:api_client/api_client.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'entities/chat_message.dart';
import 'entities/conversation_summary.dart';
import 'failures/ai_failures.dart';

enum SseEventType { chunk, citations, done, error }

class SseEvent {
  const SseEvent({
    required this.type,
    this.text,
    this.citations,
    this.sessionId,
    this.error,
  });
  final SseEventType type;
  final String? text;
  final List<CitationDto>? citations;
  final String? sessionId;
  final String? error;
}

abstract class IAiRepository {
  Stream<SseEvent> askStream({
    required String query,
    String? sessionId,
    String? title,
    CancelToken? cancelToken,
  });

  Future<Either<AiFailure, List<ConversationSummary>>> listConversations();

  Future<Either<AiFailure, List<ChatMessage>>> getConversation(
    String sessionId,
  );
}
