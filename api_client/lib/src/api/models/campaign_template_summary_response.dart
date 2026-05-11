// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'campaign_template_summary_response.freezed.dart';
part 'campaign_template_summary_response.g.dart';

@Freezed()
abstract class CampaignTemplateSummaryResponse with _$CampaignTemplateSummaryResponse {
  const factory CampaignTemplateSummaryResponse({
    /// Creation time
    required DateTime createdAt,

    /// Template ID
    required String id,

    /// Template name
    required String name,

    /// Template description
    String? description,
  }) = _CampaignTemplateSummaryResponse;

  factory CampaignTemplateSummaryResponse.fromJson(Map<String, Object?> json) =>
      _$CampaignTemplateSummaryResponseFromJson(json);
}
