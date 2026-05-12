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

    /// Campaign description
    String? description,

    /// Campaign name
    String? name,

    /// Target region
    String? region,

    /// Scheduled sending time
    DateTime? scheduledFor,

    /// Target sector IDs
    List<dynamic>? sectorIds,

    /// Target business stage
    String? stage,

    /// Target tag IDs
    List<dynamic>? tagIds,

    /// Segment filters for segmented campaigns
    Map<String, dynamic>? targetSegment,
  }) = _UpdateCampaignRequest;

  factory UpdateCampaignRequest.fromJson(Map<String, Object?> json) =>
      _$UpdateCampaignRequestFromJson(json);
}
