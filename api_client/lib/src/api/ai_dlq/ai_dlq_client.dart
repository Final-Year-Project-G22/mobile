// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:retrofit/error_logger.dart';

import '../models/dead_event_dto.dart';
import '../models/get_dead_event_input_body.dart';
import '../models/list_dead_events_input_body.dart';
import '../models/list_dead_events_output_body.dart';
import '../models/redrive_batch_input_body.dart';
import '../models/redrive_batch_output_body.dart';
import '../models/redrive_event_input_body.dart';
import '../models/redrive_event_output_body.dart';

part 'ai_dlq_client.g.dart';

@RestApi()
abstract class AiDlqClient {
  factory AiDlqClient(Dio dio, {String? baseUrl}) = _AiDlqClient;

  /// List dead letter events.
  ///
  /// Get a paginated list of dead letter queue events for the account.
  ///
  /// [body] - Name not received - field will be skipped.
  @GET('/api/v1/ai/ingestion/dlq/events')
  Future<HttpResponse<ListDeadEventsOutputBody>> listDeadEvents({@Body() required ListDeadEventsInputBody body});

  /// Redrive batch.
  ///
  /// Redrive multiple dead events in a single request.
  ///
  /// [body] - Name not received - field will be skipped.
  @POST('/api/v1/ai/ingestion/dlq/events/batch/redrive')
  Future<HttpResponse<RedriveBatchOutputBody>> redriveBatch({@Body() required RedriveBatchInputBody body});

  /// Get dead event.
  ///
  /// Get a specific dead letter queue event by ID.
  ///
  /// [eventId] - Event ID.
  ///
  /// [body] - Name not received - field will be skipped.
  @GET('/api/v1/ai/ingestion/dlq/events/{eventId}')
  Future<HttpResponse<DeadEventDto>> getDeadEvent({
    @Path('eventId') required String eventId,
    @Body() required GetDeadEventInputBody body,
  });

  /// Redrive single event.
  ///
  /// Redrive a dead event back to the processing queue.
  ///
  /// [eventId] - Event ID.
  ///
  /// [body] - Name not received - field will be skipped.
  @POST('/api/v1/ai/ingestion/dlq/events/{eventId}/redrive')
  Future<HttpResponse<RedriveEventOutputBody>> redriveEvent({
    @Path('eventId') required String eventId,
    @Body() required RedriveEventInputBody body,
  });
}
