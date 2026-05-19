import 'package:freezed_annotation/freezed_annotation.dart';

part 'scheduled_alert_template.freezed.dart';

@freezed
abstract class ScheduledAlertTemplate with _$ScheduledAlertTemplate {
  const factory ScheduledAlertTemplate({
    required String slug,
    required String name,
    required String defaultTitle,
    required String defaultBody,
    String? defaultChannel,
  }) = _ScheduledAlertTemplate;
}
