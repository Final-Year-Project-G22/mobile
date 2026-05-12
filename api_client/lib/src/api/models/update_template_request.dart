// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_template_request.freezed.dart';
part 'update_template_request.g.dart';

@Freezed()
abstract class UpdateTemplateRequest with _$UpdateTemplateRequest {
  const factory UpdateTemplateRequest({
    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,

    /// Multi-channel content
    Map<String, dynamic>? defaultContent,

    /// Default TTL in seconds
    int? defaultTtl,

    /// Template description
    String? description,

    /// Template name
    String? name,

    /// Default priority
    int? priority,

    /// Template variable schema
    Map<String, dynamic>? variablesSchema,
  }) = _UpdateTemplateRequest;

  factory UpdateTemplateRequest.fromJson(Map<String, Object?> json) => _$UpdateTemplateRequestFromJson(json);
}
