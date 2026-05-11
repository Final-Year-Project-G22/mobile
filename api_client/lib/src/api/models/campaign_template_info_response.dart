// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'campaign_template_info_response.freezed.dart';
part 'campaign_template_info_response.g.dart';

@Freezed()
abstract class CampaignTemplateInfoResponse with _$CampaignTemplateInfoResponse {
  const factory CampaignTemplateInfoResponse({
    /// Multi-channel content
    required Map<String, dynamic> defaultContent,

    /// Template ID
    required String id,

    /// Template name
    required String name,

    /// Template description
    String? description,
  }) = _CampaignTemplateInfoResponse;

  factory CampaignTemplateInfoResponse.fromJson(Map<String, Object?> json) =>
      _$CampaignTemplateInfoResponseFromJson(json);
}
