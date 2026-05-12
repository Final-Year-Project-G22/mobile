// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_campaign_template_request.freezed.dart';
part 'update_campaign_template_request.g.dart';

@Freezed()
abstract class UpdateCampaignTemplateRequest with _$UpdateCampaignTemplateRequest {
  const factory UpdateCampaignTemplateRequest({
    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,

    /// Multi-channel content
    Map<String, dynamic>? defaultContent,

    /// Template description
    String? description,

    /// Template name
    String? name,
  }) = _UpdateCampaignTemplateRequest;

  factory UpdateCampaignTemplateRequest.fromJson(Map<String, Object?> json) =>
      _$UpdateCampaignTemplateRequestFromJson(json);
}
