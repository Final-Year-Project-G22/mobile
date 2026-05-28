import 'package:api_client/api_client.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'entities/conversation_list_result.dart';
import 'entities/conversation_result.dart';
import 'failures/ai_failures.dart';

enum SseEventType { chunk, citations, done, error, toolUse, toolResult }

class SseEvent {
  const SseEvent({
    required this.type,
    this.text,
    this.citations,
    this.sessionId,
    this.error,
    this.toolName,
    this.toolArguments,
    this.toolResultSummary,
  });
  final SseEventType type;
  final String? text;
  final List<CitationDto>? citations;
  final String? sessionId;
  final String? error;
  final String? toolName;
  final String? toolArguments;
  final String? toolResultSummary;
}

abstract class IAiRepository {
  Stream<SseEvent> askStream({
    required String query,
    String? sessionId,
    String? title,
    CancelToken? cancelToken,
  });

  Future<Either<AiFailure, ConversationListResult>> listConversations({
    int limit = 20,
    int offset = 0,
  });

  Future<Either<AiFailure, ConversationResult>> getConversation(
    String sessionId, {
    int messageLimit = 50,
    int messageOffset = 0,
  });

  Future<Either<AiFailure, Unit>> archiveConversation(String sessionId);
}
