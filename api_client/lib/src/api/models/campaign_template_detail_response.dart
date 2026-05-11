// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'campaign_template_detail_response.freezed.dart';
part 'campaign_template_detail_response.g.dart';

@Freezed()
abstract class CampaignTemplateDetailResponse
    with _$CampaignTemplateDetailResponse {
  const factory CampaignTemplateDetailResponse({
    /// Creation time
    required DateTime createdAt,

    /// Multi-channel content
    required Map<String, dynamic> defaultContent,

    /// Template ID
    required String id,

    /// Template name
    required String name,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,

    /// Template description
    String? description,

    /// Template translations
    List<dynamic>? translations,
  }) = _CampaignTemplateDetailResponse;

  factory CampaignTemplateDetailResponse.fromJson(Map<String, Object?> json) =>
      _$CampaignTemplateDetailResponseFromJson(json);
}
