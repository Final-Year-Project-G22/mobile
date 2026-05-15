// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'ingestion_status_projection_response.freezed.dart';
part 'ingestion_status_projection_response.g.dart';

@Freezed()
abstract class IngestionStatusProjectionResponse
    with _$IngestionStatusProjectionResponse {
  const factory IngestionStatusProjectionResponse({
    /// Account identifier
    required String accountId,

    /// Number of chunks failed
    required int chunksFailedCount,

    /// Number of chunks processed
    required int chunksProcessedCount,

    /// Current ingestion stage
    required String currentStage,

    /// Document identifier
    required String documentId,

    /// Monotonic event sequence number
    required int eventSequence,

    /// Whether this is a terminal stage
    required bool isTerminal,

    /// Ingestion start timestamp
    required DateTime startedAt,

    /// Last update timestamp
    required DateTime updatedAt,

    /// User identifier
    required String userId,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,

    /// Completion timestamp if terminal
    DateTime? completedAt,

    /// Declared language hint (en/am)
    String? declaredLanguage,

    /// Last error message if failed
    String? lastError,

    /// Associated sector IDs
    List<dynamic>? sectorIds,

    /// Original source filename
    String? sourceFilename,

    /// Associated tag IDs
    List<dynamic>? tagIds,
  }) = _IngestionStatusProjectionResponse;

  factory IngestionStatusProjectionResponse.fromJson(
    Map<String, Object?> json,
  ) => _$IngestionStatusProjectionResponseFromJson(json);
}
