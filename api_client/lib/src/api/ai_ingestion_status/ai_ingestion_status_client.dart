// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:retrofit/error_logger.dart';

import '../models/get_status_by_document_input_body.dart';
import '../models/ingestion_status_projection_response.dart';
import '../models/list_status_by_account_input_body.dart';
import '../models/list_status_by_account_output_body.dart';
import '../models/list_status_by_user_input_body.dart';
import '../models/list_status_by_user_output_body.dart';
import '../models/stream_status_by_document_input_body.dart';
import '../models/stream_status_input_body.dart';

part 'ai_ingestion_status_client.g.dart';

@RestApi()
abstract class AiIngestionStatusClient {
  factory AiIngestionStatusClient(Dio dio, {String? baseUrl}) =
      _AiIngestionStatusClient;

  /// List ingestion status by account ID.
  ///
  /// Returns a paginated list of ingestion statuses for an account.
  ///
  /// [accountId] - Account ID.
  ///
  /// [body] - Name not received - field will be skipped.
  @GET('/api/v1/ai/ingestion/status/accounts/{accountId}')
  Future<HttpResponse<ListStatusByAccountOutputBody>>
  listIngestionStatusByAccountId({
    @Path('accountId') required String accountId,
    @Body() required ListStatusByAccountInputBody body,
  });

  /// Stream ingestion status by document ID.
  ///
  /// Subscribe to real-time ingestion status updates for a specific document via SSE.
  ///
  /// [documentId] - Document ID.
  ///
  /// [body] - Name not received - field will be skipped.
  @GET('/api/v1/ai/ingestion/status/document/{documentId}/stream')
  Future<HttpResponse<void>> streamIngestionStatusByDocument({
    @Path('documentId') required String documentId,
    @Body() required StreamStatusByDocumentInputBody body,
  });

  /// Get ingestion status by document ID.
  ///
  /// Returns the current ingestion status for a document.
  ///
  /// [documentId] - Document ID.
  ///
  /// [body] - Name not received - field will be skipped.
  @GET('/api/v1/ai/ingestion/status/documents/{documentId}')
  Future<HttpResponse<IngestionStatusProjectionResponse>>
  getIngestionStatusByDocumentId({
    @Path('documentId') required String documentId,
    @Body() required GetStatusByDocumentInputBody body,
  });

  /// Stream ingestion status.
  ///
  /// Subscribe to real-time ingestion status updates via SSE.
  ///
  /// [body] - Name not received - field will be skipped.
  @GET('/api/v1/ai/ingestion/status/stream')
  Future<HttpResponse<void>> streamIngestionStatus({
    @Body() required StreamStatusInputBody body,
  });

  /// List ingestion status by user ID.
  ///
  /// Returns a paginated list of ingestion statuses for a user.
  ///
  /// [userId] - User ID.
  ///
  /// [body] - Name not received - field will be skipped.
  @GET('/api/v1/ai/ingestion/status/users/{userId}')
  Future<HttpResponse<ListStatusByUserOutputBody>> listIngestionStatusByUserId({
    @Path('userId') required String userId,
    @Body() required ListStatusByUserInputBody body,
  });
}
