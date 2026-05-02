// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'usage_dto.dart';

part 'ask_response_body.freezed.dart';
part 'ask_response_body.g.dart';

@Freezed()
abstract class AskResponseBody with _$AskResponseBody {
  const factory AskResponseBody({
    required String answer,
    required List<dynamic>? citations,
    required DateTime createdAt,
    required int latencyMs,
    required String model,
    required String requestId,
    required String sessionId,
    required DateTime updatedAt,
    required UsageDto usage,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _AskResponseBody;

  factory AskResponseBody.fromJson(Map<String, Object?> json) =>
      _$AskResponseBodyFromJson(json);
}
