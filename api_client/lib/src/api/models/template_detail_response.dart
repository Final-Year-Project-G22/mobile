// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'template_detail_response.freezed.dart';
part 'template_detail_response.g.dart';

@Freezed()
abstract class TemplateDetailResponse with _$TemplateDetailResponse {
  const factory TemplateDetailResponse({
    /// Notification category
    required String category,

    /// Multi-channel content
    required Map<String, dynamic> defaultContent,

    /// Template ID
    required String id,

    /// Whether template is system-managed
    required bool isSystemManaged,

    /// Template name
    required String name,

    /// Notification type
    required String notificationType,

    /// Default priority
    required int priority,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,

    /// Default TTL in seconds
    int? defaultTtl,

    /// Template description
    String? description,

    /// Template translations
    List<dynamic>? translations,

    /// Template variable schema
    Map<String, dynamic>? variablesSchema,
  }) = _TemplateDetailResponse;

  factory TemplateDetailResponse.fromJson(Map<String, Object?> json) =>
      _$TemplateDetailResponseFromJson(json);
}
