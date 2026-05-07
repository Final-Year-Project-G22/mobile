import 'package:freezed_annotation/freezed_annotation.dart';

import 'notification_summary.dart';

part 'inbox_entry.freezed.dart';

@freezed
abstract class InboxEntry with _$InboxEntry {
  const factory InboxEntry({
    required String id,
    required String category,
    required bool isRead,
    required bool isArchived,
    required NotificationSummary notification,
    String? actionUrl,
    DateTime? expiresAt,
  }) = _InboxEntry;
}
