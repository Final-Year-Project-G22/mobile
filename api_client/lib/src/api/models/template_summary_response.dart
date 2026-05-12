// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'template_summary_response.freezed.dart';
part 'template_summary_response.g.dart';

@Freezed()
abstract class TemplateSummaryResponse with _$TemplateSummaryResponse {
  const factory TemplateSummaryResponse({
    /// Template ID
    required String id,

    /// Whether template is system-managed
    required bool isSystemManaged,

    /// Template name
    required String name,

    /// Notification type
    required String notificationType,

    /// Template group
    required String templateGroup,
  }) = _TemplateSummaryResponse;

  factory TemplateSummaryResponse.fromJson(Map<String, Object?> json) =>
      _$TemplateSummaryResponseFromJson(json);
}
