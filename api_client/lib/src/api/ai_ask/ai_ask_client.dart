// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:retrofit/error_logger.dart';

import '../models/ask_request.dart';
import '../models/ask_response_body.dart';

part 'ai_ask_client.g.dart';

@RestApi()
abstract class AiAskClient {
  factory AiAskClient(Dio dio, {String? baseUrl}) = _AiAskClient;

  /// Ask a question.
  ///
  /// Ask AI a question and get an answer with citations.
  ///
  /// [body] - Name not received - field will be skipped.
  @POST('/api/v1/ai/ask')
  Future<HttpResponse<AskResponseBody>> ask({
    @Body() required AskRequest body,
  });

  /// Ask a question with streaming response.
  ///
  /// Ask AI a question and receive token chunks as Server-Sent Events.
  ///
  /// [body] - Name not received - field will be skipped.
  @POST('/api/v1/ai/ask/stream')
  Future<HttpResponse<void>> askStream({
    @Body() required AskRequest body,
  });
}
