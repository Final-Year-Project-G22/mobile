// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'campaign_detail_response.freezed.dart';
part 'campaign_detail_response.g.dart';

@Freezed()
abstract class CampaignDetailResponse with _$CampaignDetailResponse {
  const factory CampaignDetailResponse({
    /// Campaign type
    required String campaignType,

    /// Creation time
    required DateTime createdAt,

    /// Creator account ID
    required String createdBy,

    /// Campaign ID
    required String id,

    /// Campaign name
    required String name,

    /// Campaign status
    required String status,

    /// Notification template ID
    required String templateId,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,

    /// Override multi-channel content
    Map<String, dynamic>? customContent,

    /// Override email subject
    String? customSubject,

    /// Campaign description
    String? description,

    /// Scheduled sending time
    DateTime? scheduledFor,

    /// Actual sending time
    DateTime? sentAt,

    /// Segment filters or resolved recipients
    Map<String, dynamic>? targetSegment,
  }) = _CampaignDetailResponse;

  factory CampaignDetailResponse.fromJson(Map<String, Object?> json) =>
      _$CampaignDetailResponseFromJson(json);
}
