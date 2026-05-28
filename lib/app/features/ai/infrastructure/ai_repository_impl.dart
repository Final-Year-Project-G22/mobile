import 'dart:async';
import 'dart:convert';

import 'package:api_client/api_client.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../domain/entities/chat_message.dart';
import '../domain/entities/conversation_list_result.dart';
import '../domain/entities/conversation_result.dart';
import '../domain/entities/conversation_summary.dart';
import '../domain/failures/ai_failures.dart';
import '../domain/i_ai_repository.dart';
import 'sse_parser.dart';

class AiRepositoryImpl implements IAiRepository {
  const AiRepositoryImpl({
    required Dio dio,
    required http.Client httpClient,
    required Future<String?> Function() tokenProvider,
    required Future<String?> Function() localeProvider,
    required String baseUrl,
  }) : _dio = dio,
       _httpClient = httpClient,
       _tokenProvider = tokenProvider,
       _localeProvider = localeProvider,
       _baseUrl = baseUrl;

  final Dio _dio;
  final http.Client _httpClient;
  final Future<String?> Function() _tokenProvider;
  final Future<String?> Function() _localeProvider;
  final String _baseUrl;

  @override
  Stream<SseEvent> askStream({
    required String query,
    String? sessionId,
    String? title,
    CancelToken? cancelToken,
  }) {
    final controller = StreamController<SseEvent>();

    unawaited(() async {
      try {
        final token = await _tokenProvider();
        final locale = await _localeProvider();
        final uri = Uri.parse('$_baseUrl/api/v1/ai/ask/stream');
        final body = jsonEncode({
          'query': query,
          'sessionId': ?sessionId,
          'title': ?title,
          'language': ?locale,
          'strategy': 'agentic',
        });

        final request = http.Request('POST', uri);
        request.headers['Content-Type'] = 'application/json';
        request.headers['Accept'] = 'text/event-stream';
        if (locale != null && locale.isNotEmpty) {
          request.headers['Accept-Language'] = locale;
        }
        if (token != null && token.isNotEmpty) {
          request.headers['Authorization'] = 'Bearer $token';
        }
        request.body = body;

        debugPrint('[AI Repo] SSE request: POST $uri');
        debugPrint('[AI Repo] SSE body: $body');

        final response = await _httpClient.send(request);

        if (response.statusCode != 200) {
          final responseBody = await response.stream.bytesToString();
          controller.addError(
            Exception(
              'SSE request failed: ${response.statusCode} $responseBody',
            ),
          );
          return;
        }

        const parser = SseParser();
        final byteStream = response.stream.cast<List<int>>();
        final eventStream = parser.parse(byteStream);

        if (cancelToken != null) {
          unawaited(
            cancelToken.whenCancel.then((_) async {
              if (!controller.isClosed) await controller.close();
            }),
          );
        }

        await controller.addStream(eventStream);
      } on Exception catch (e) {
        if (!controller.isClosed) {
          controller.addError(e);
        }
      } finally {
        if (!controller.isClosed) {
          await controller.close();
        }
      }
    }());

    return controller.stream;
  }

  @override
  Future<Either<AiFailure, ConversationListResult>> listConversations({
    int limit = 20,
    int offset = 0,
  }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/api/v1/ai/conversations',
        queryParameters: {
          'limit': limit,
          'offset': offset,
        },
      );

      final sessionsRaw = response.data?['sessions'] as List<dynamic>? ?? [];
      final total = response.data?['total'] as int? ?? 0;

      final sessions = sessionsRaw.map((json) {
        final dto = ConversationDto.fromJson(json as Map<String, dynamic>);
        return ConversationSummary(
          id: dto.id,
          title: dto.title.isNotEmpty ? dto.title : 'New chat',
          updatedAt: dto.updatedAt,
          language: dto.language,
        );
      }).toList();

      return right(
        ConversationListResult(
          sessions: sessions,
          total: total,
        ),
      );
    } on DioException catch (e) {
      return left(_mapDioError(e));
    }
  }

  @override
  Future<Either<AiFailure, ConversationResult>> getConversation(
    String sessionId, {
    int messageLimit = 50,
    int messageOffset = 0,
  }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/api/v1/ai/conversations/$sessionId',
        queryParameters: {
          'messageLimit': messageLimit,
          'messageOffset': messageOffset,
        },
      );

      final data = response.data!;

      final sessionDto = ConversationDto.fromJson(
        data['session'] as Map<String, dynamic>,
      );
      final session = ConversationSummary(
        id: sessionDto.id,
        title: sessionDto.title.isNotEmpty ? sessionDto.title : 'New chat',
        updatedAt: sessionDto.updatedAt,
        language: sessionDto.language,
      );

      final messagesRaw = data['messages'] as List<dynamic>? ?? [];
      final totalMsgs = data['totalMsgs'] as int? ?? 0;

      final messages = messagesRaw.map((json) {
        final dto = MessageDto.fromJson(json as Map<String, dynamic>);

        final citationsRaw = dto.citations ?? [];
        final citations = citationsRaw
            .map((c) => CitationDto.fromJson(c as Map<String, dynamic>))
            .toList();

        return ChatMessage(
          id: dto.id,
          role: dto.role == 'user' ? ChatRole.user : ChatRole.assistant,
          content: dto.content,
          citations: citations,
          createdAt: dto.createdAt,
        );
      }).toList();

      return right(
        ConversationResult(
          session: session,
          messages: messages,
          totalMsgs: totalMsgs,
        ),
      );
    } on DioException catch (e) {
      return left(_mapDioError(e));
    }
  }

  @override
  Future<Either<AiFailure, Unit>> archiveConversation(String sessionId) async {
    try {
      await _dio.delete<void>('/api/v1/ai/conversations/$sessionId');
      return const Right(unit);
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
