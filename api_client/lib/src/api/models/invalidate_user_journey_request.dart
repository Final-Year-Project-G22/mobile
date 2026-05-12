// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'invalidate_user_journey_request.freezed.dart';
part 'invalidate_user_journey_request.g.dart';

@Freezed()
abstract class InvalidateUserJourneyRequest with _$InvalidateUserJourneyRequest {
  const factory InvalidateUserJourneyRequest({
    /// Guide ID
    required String guideId,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _InvalidateUserJourneyRequest;

  factory InvalidateUserJourneyRequest.fromJson(Map<String, Object?> json) =>
      _$InvalidateUserJourneyRequestFromJson(json);
}
