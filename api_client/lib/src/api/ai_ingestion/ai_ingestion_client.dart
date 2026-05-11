// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:retrofit/error_logger.dart';

import '../models/create_upload_intent_request.dart';
import '../models/create_upload_intent_response_body.dart';
import '../models/delete_document_response_body.dart';
import '../models/finalize_upload_request.dart';
import '../models/finalize_upload_response_body.dart';
import '../models/ingest_toggle_state_response.dart';
import '../models/set_ingest_toggle_input_body.dart';

part 'ai_ingestion_client.g.dart';

@RestApi()
abstract class AiIngestionClient {
  factory AiIngestionClient(Dio dio, {String? baseUrl}) = _AiIngestionClient;

  /// Delete ingestion document.
  ///
  /// Soft-deletes an ingestion document and its status projection.
  ///
  /// [documentId] - Document ID.
  @DELETE('/api/v1/ai/ingestion/documents/{documentId}')
  Future<HttpResponse<DeleteDocumentResponseBody>> deleteIngestionDocument({
    @Path('documentId') required String documentId,
  });

  /// Get ingestion toggle.
  ///
  /// Get the current ingestion toggle state.
  @GET('/api/v1/ai/ingestion/toggle')
  Future<HttpResponse<IngestToggleStateResponse>> getIngestionToggle();

  /// Set ingestion toggle.
  ///
  /// Enable or disable document ingestion for the account.
  ///
  /// [body] - Name not received - field will be skipped.
  @PATCH('/api/v1/ai/ingestion/toggle')
  Future<HttpResponse<IngestToggleStateResponse>> setIngestionToggle({@Body() required SetIngestToggleInputBody body});

  /// Finalize uploaded document ingestion.
  ///
  /// Validates uploaded object metadata, writes ingestion metadata and outbox entry atomically.
  ///
  /// [body] - Name not received - field will be skipped.
  @POST('/api/v1/ai/ingestion/uploads/finalize')
  Future<HttpResponse<FinalizeUploadResponseBody>> finalizeIngestionUpload({
    @Body() required FinalizeUploadRequest body,
  });

  /// Create direct upload intent.
  ///
  /// Generates a SeaweedFS direct-upload URL and required headers.
  ///
  /// [body] - Name not received - field will be skipped.
  @POST('/api/v1/ai/ingestion/uploads/intents')
  Future<HttpResponse<CreateUploadIntentResponseBody>> createIngestionUploadIntent({
    @Body() required CreateUploadIntentRequest body,
  });
}
