// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'schedule_campaign_response_body.freezed.dart';
part 'schedule_campaign_response_body.g.dart';

@Freezed()
abstract class ScheduleCampaignResponseBody
    with _$ScheduleCampaignResponseBody {
  const factory ScheduleCampaignResponseBody({
    /// Success message
    required String message,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _ScheduleCampaignResponseBody;

  factory ScheduleCampaignResponseBody.fromJson(Map<String, Object?> json) =>
      _$ScheduleCampaignResponseBodyFromJson(json);
}
