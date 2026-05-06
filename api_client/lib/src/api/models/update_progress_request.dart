// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_progress_request.freezed.dart';
part 'update_progress_request.g.dart';

@Freezed()
abstract class UpdateProgressRequest with _$UpdateProgressRequest {
  const factory UpdateProgressRequest({
    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,

    /// Step notes
    String? notes,

    /// Time spent in seconds
    int? timeSpentSeconds,

    /// Uploaded document URLs
    List<dynamic>? uploadedDocuments,
  }) = _UpdateProgressRequest;

  factory UpdateProgressRequest.fromJson(Map<String, Object?> json) => _$UpdateProgressRequestFromJson(json);
}
