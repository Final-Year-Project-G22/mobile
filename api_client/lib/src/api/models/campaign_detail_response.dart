// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'campaign_created_by_response.dart';
import 'campaign_template_info_response.dart';

part 'campaign_detail_response.freezed.dart';
part 'campaign_detail_response.g.dart';

@Freezed()
abstract class CampaignDetailResponse with _$CampaignDetailResponse {
  const factory CampaignDetailResponse({
    /// Campaign template ID
    required String campaignTemplateId,

    /// Campaign type
    required String campaignType,

    /// Creation time
    required DateTime createdAt,

    /// Creator account info
    required CampaignCreatedByResponse createdBy,

    /// Campaign ID
    required String id,

    /// Campaign name
    required String name,

    /// Target sector IDs
    required List<dynamic>? sectorIds,

    /// Campaign status
    required String status,

    /// Target tag IDs
    required List<dynamic>? tagIds,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,

    /// Campaign template details
    CampaignTemplateInfoResponse? campaignTemplate,

    /// Campaign description
    String? description,

    /// Target region
    String? region,

    /// Scheduled sending time
    DateTime? scheduledFor,

    /// Actual sending time
    DateTime? sentAt,

    /// Target business stage
    String? stage,

    /// Segment filters or resolved recipients
    Map<String, dynamic>? targetSegment,
  }) = _CampaignDetailResponse;

  factory CampaignDetailResponse.fromJson(Map<String, Object?> json) => _$CampaignDetailResponseFromJson(json);
}
