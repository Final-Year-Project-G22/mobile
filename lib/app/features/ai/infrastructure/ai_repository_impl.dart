import 'dart:async';

import 'package:api_client/api_client.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../domain/entities/chat_message.dart';
import '../domain/entities/conversation_summary.dart';
import '../domain/failures/ai_failures.dart';
import '../domain/i_ai_repository.dart';
import 'sse_parser.dart';

class AiRepositoryImpl implements IAiRepository {
  const AiRepositoryImpl({
    required Dio dio,
    required AiConversationsClient conversationsClient,
  }) : _dio = dio,
       _conversationsClient = conversationsClient;

  final Dio _dio;
  final AiConversationsClient _conversationsClient;

  @override
  Stream<SseEvent> askStream({
    required String query,
    String? sessionId,
    String? title,
    CancelToken? cancelToken,
  }) {
    final controller = StreamController<SseEvent>();
    final request = AskRequest(
      query: query,
      sessionId: sessionId,
      title: title,
    );

    unawaited(
      _dio
          .post<ResponseBody>(
            '/api/v1/ai/ask/stream',
            data: request.toJson(),
            options: Options(
              responseType: ResponseType.stream,
              receiveTimeout: const Duration(hours: 24),
              sendTimeout: const Duration(hours: 24),
              extra: <String, dynamic>{'sse': true},
              headers: {
                'Accept': 'text/event-stream',
              },
            ),
            cancelToken: cancelToken,
          )
          .then((response) {
            debugPrint('[AI Repo] SSE response status: ${response.statusCode}');
            debugPrint('[AI Repo] SSE data type: ${response.data.runtimeType}');

            const parser = SseParser();
            final byteStream = response.data!.stream.cast<List<int>>();

            final loggedStream = byteStream.map((bytes) {
              debugPrint('[AI Repo] raw chunk: ${bytes.length} bytes');
              return bytes;
            });

            final eventStream = parser.parse(loggedStream);

            unawaited(controller.addStream(eventStream));
          })
          .catchError((Object error) {
            debugPrint('[AI Repo] SSE request failed: $error');
            controller.addError(error);
          }),
    );

    return controller.stream;
  }

  @override
  Future<Either<AiFailure, List<ConversationSummary>>>
  listConversations() async {
    try {
      final response = await _conversationsClient.listConversations();
      final data = response.data;

      final sessions = (data.sessions ?? []).cast<Map<String, dynamic>>().map((
        json,
      ) {
        final dto = ConversationDto.fromJson(json);
        return ConversationSummary(
          id: dto.id,
          title: dto.title.isNotEmpty ? dto.title : 'New chat',
          updatedAt: dto.updatedAt,
        );
      }).toList();

      return right(sessions);
    } on DioException catch (e) {
      return left(_mapDioError(e));
    }
  }

  @override
  Future<Either<AiFailure, List<ChatMessage>>> getConversation(
    String sessionId,
  ) async {
    try {
      final response = await _conversationsClient.getConversation(
        sessionId: sessionId,
      );
      final data = response.data;

      final messages = (data.messages ?? []).cast<Map<String, dynamic>>().map((
        json,
      ) {
        final dto = MessageDto.fromJson(json);

        final citations = (dto.citations ?? [])
            .cast<Map<String, dynamic>>()
            .map(CitationDto.fromJson)
            .toList();

        return ChatMessage(
          id: dto.id,
          role: dto.role == 'user' ? ChatRole.user : ChatRole.assistant,
          content: dto.content,
          citations: citations,
          createdAt: dto.createdAt,
        );
      }).toList();

      return right(messages);
    } on DioException catch (e) {
      return left(_mapDioError(e));
    }
  }

  AiFailure _mapDioError(DioException e) {
    final statusCode = e.response?.statusCode;

    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.connectionError) {
      return const AiFailure.networkError();
    }

    if (statusCode == 401) return const AiFailure.unauthorized();
    if (statusCode == 404) return const AiFailure.notFound();
    if (statusCode != null && statusCode >= 500) {
      return const AiFailure.serverError();
    }

    return const AiFailure.networkError();
  }
}
