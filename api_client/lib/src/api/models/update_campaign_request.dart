// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_campaign_request.freezed.dart';
part 'update_campaign_request.g.dart';

@Freezed()
abstract class UpdateCampaignRequest with _$UpdateCampaignRequest {
  const factory UpdateCampaignRequest({
    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,

    /// Override multi-channel content
    Map<String, dynamic>? customContent,

    /// Override email subject
    String? customSubject,

    /// Campaign description
    String? description,

    /// Campaign name
    String? name,

    /// Scheduled sending time
    DateTime? scheduledFor,

    /// Segment filters for segmented campaigns
    Map<String, dynamic>? targetSegment,
  }) = _UpdateCampaignRequest;

  factory UpdateCampaignRequest.fromJson(Map<String, Object?> json) =>
      _$UpdateCampaignRequestFromJson(json);
}
