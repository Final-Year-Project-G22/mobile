// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'campaign_summary_response.freezed.dart';
part 'campaign_summary_response.g.dart';

@Freezed()
abstract class CampaignSummaryResponse with _$CampaignSummaryResponse {
  const factory CampaignSummaryResponse({
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

    /// Scheduled sending time
    DateTime? scheduledFor,

    /// Actual sending time
    DateTime? sentAt,
  }) = _CampaignSummaryResponse;

  factory CampaignSummaryResponse.fromJson(Map<String, Object?> json) => _$CampaignSummaryResponseFromJson(json);
}
