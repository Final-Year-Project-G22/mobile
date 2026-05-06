// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'dead_event_dto.freezed.dart';
part 'dead_event_dto.g.dart';

@Freezed()
abstract class DeadEventDto with _$DeadEventDto {
  const factory DeadEventDto({
    required DateTime createdAt,
    required String eventId,
    required String eventType,
    required String payload,
    required int replayCount,
    required String status,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
    String? errorMessage,
  }) = _DeadEventDto;

  factory DeadEventDto.fromJson(Map<String, Object?> json) => _$DeadEventDtoFromJson(json);
}
