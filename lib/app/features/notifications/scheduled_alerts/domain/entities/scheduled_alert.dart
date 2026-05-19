import 'package:freezed_annotation/freezed_annotation.dart';

part 'scheduled_alert.freezed.dart';

@freezed
abstract class ScheduledAlert with _$ScheduledAlert {
  const factory ScheduledAlert({
    required String id,
    required String title,
    required String body,
    required List<String> channels,
    required DateTime scheduledFor,
    required String status,
    String? templateSlug,
    DateTime? rescheduledFrom,
    DateTime? sentAt,
    DateTime? cancelledAt,
    DateTime? createdAt,
  }) = _ScheduledAlert;
}
