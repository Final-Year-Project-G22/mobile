// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_campaign_request.freezed.dart';
part 'create_campaign_request.g.dart';

@Freezed()
abstract class CreateCampaignRequest with _$CreateCampaignRequest {
  const factory CreateCampaignRequest({
    /// Campaign template ID
    required String campaignTemplateId,

    /// Campaign type (broadcast or segmented)
    required String campaignType,

    /// Campaign name
    required String name,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,

    /// Campaign description
    String? description,

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
  }) = _CreateCampaignRequest;

  factory CreateCampaignRequest.fromJson(Map<String, Object?> json) =>
      _$CreateCampaignRequestFromJson(json);
}
