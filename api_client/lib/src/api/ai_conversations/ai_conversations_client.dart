// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:retrofit/error_logger.dart';

import '../models/archive_conversation_input_body.dart';
import '../models/archive_conversation_output_body.dart';
import '../models/get_conversation_input_body.dart';
import '../models/get_conversation_output_body.dart';
import '../models/list_conversations_input_body.dart';
import '../models/list_conversations_output_body.dart';

part 'ai_conversations_client.g.dart';

@RestApi()
abstract class AiConversationsClient {
  factory AiConversationsClient(Dio dio, {String? baseUrl}) =
      _AiConversationsClient;

  /// List conversations.
  ///
  /// Get a paginated list of user's conversation sessions.
  ///
  /// [body] - Name not received - field will be skipped.
  @GET('/api/v1/ai/conversations')
  Future<HttpResponse<ListConversationsOutputBody>> listConversations({
    @Body() required ListConversationsInputBody body,
  });

  /// Archive conversation.
  ///
  /// Archive (soft-delete) a conversation session.
  ///
  /// [sessionId] - Session ID.
  ///
  /// [body] - Name not received - field will be skipped.
  @DELETE('/api/v1/ai/conversations/{sessionId}')
  Future<HttpResponse<ArchiveConversationOutputBody>> archiveConversation({
    @Path('sessionId') required String sessionId,
    @Body() required ArchiveConversationInputBody body,
  });

  /// Get conversation.
  ///
  /// Get a conversation with its messages.
  ///
  /// [sessionId] - Session ID.
  ///
  /// [body] - Name not received - field will be skipped.
  @GET('/api/v1/ai/conversations/{sessionId}')
  Future<HttpResponse<GetConversationOutputBody>> getConversation({
    @Path('sessionId') required String sessionId,
    @Body() required GetConversationInputBody body,
  });
}
