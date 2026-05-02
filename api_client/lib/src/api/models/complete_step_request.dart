// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'complete_step_request.freezed.dart';
part 'complete_step_request.g.dart';

@Freezed()
abstract class CompleteStepRequest with _$CompleteStepRequest {
  const factory CompleteStepRequest({
    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,

    /// Step notes
    String? notes,

    /// Time spent in seconds
    int? timeSpentSeconds,

    /// Uploaded document URLs
    List<dynamic>? uploadedDocuments,
  }) = _CompleteStepRequest;

  factory CompleteStepRequest.fromJson(Map<String, Object?> json) =>
      _$CompleteStepRequestFromJson(json);
}
