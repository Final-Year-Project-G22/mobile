// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'scheduled_template_response.freezed.dart';
part 'scheduled_template_response.g.dart';

@Freezed()
abstract class ScheduledTemplateResponse with _$ScheduledTemplateResponse {
  const factory ScheduledTemplateResponse({
    required String defaultBody,
    required String defaultTitle,
    required String name,
    required String slug,
    String? defaultChannel,
  }) = _ScheduledTemplateResponse;

  factory ScheduledTemplateResponse.fromJson(Map<String, Object?> json) =>
      _$ScheduledTemplateResponseFromJson(json);
}
