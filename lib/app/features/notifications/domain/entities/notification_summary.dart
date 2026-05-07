import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_summary.freezed.dart';

@freezed
abstract class NotificationSummary with _$NotificationSummary {
  const factory NotificationSummary({
    required String type,
    required String channel,
    required String title,
    required String content,
    required DateTime sentAt,
    DateTime? deliveredAt,
    DateTime? readAt,
  }) = _NotificationSummary;
}
