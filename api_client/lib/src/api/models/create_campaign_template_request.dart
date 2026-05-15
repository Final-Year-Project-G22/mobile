// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_campaign_template_request.freezed.dart';
part 'create_campaign_template_request.g.dart';

@Freezed()
abstract class CreateCampaignTemplateRequest
    with _$CreateCampaignTemplateRequest {
  const factory CreateCampaignTemplateRequest({
    /// Multi-channel content (in_app, email, push, sms)
    required Map<String, dynamic> defaultContent,

    /// Enable automatic push mirroring from in-app content
    required bool enablePushMirror,

    /// Template name
    required String name,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,

    /// Template description
    String? description,
  }) = _CreateCampaignTemplateRequest;

  factory CreateCampaignTemplateRequest.fromJson(Map<String, Object?> json) =>
      _$CreateCampaignTemplateRequestFromJson(json);
}
