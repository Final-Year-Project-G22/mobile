// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_template_request.freezed.dart';
part 'create_template_request.g.dart';

@Freezed()
abstract class CreateTemplateRequest with _$CreateTemplateRequest {
  const factory CreateTemplateRequest({
    /// Multi-channel content
    required Map<String, dynamic> defaultContent,

    /// Template name
    required String name,

    /// Notification type
    required String notificationType,

    /// Default priority
    required int priority,

    /// Template group
    required String templateGroup,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,

    /// Default TTL in seconds
    int? defaultTtl,

    /// Template description
    String? description,

    /// Template variable schema
    Map<String, dynamic>? variablesSchema,
  }) = _CreateTemplateRequest;

  factory CreateTemplateRequest.fromJson(Map<String, Object?> json) =>
      _$CreateTemplateRequestFromJson(json);
}
