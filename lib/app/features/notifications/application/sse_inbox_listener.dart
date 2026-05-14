import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/lifecycle/app_lifecycle_provider.dart';
import '../../../../core/providers/sse_providers.dart';
import 'inbox_notifier.dart';
import 'unread_count_provider.dart';

part 'sse_inbox_listener.g.dart';

@riverpod
AsyncValue<int> notificationBadgeCount(Ref ref) {
  return ref.watch(unreadCountProvider);
}

@Riverpod(keepAlive: true)
void sseInboxListener(Ref ref) {
  ref
    ..listen(sseInboxEventsProvider, (_, next) {
      final msg = next.asData?.value;
      if (msg == null) return;

      final event = msg['event'] as String?;

      if (event != 'notification_new') return;

      ref.invalidate(unreadCountProvider);

      ref.read(inboxProvider.notifier).scheduleSilentRefresh();
    })
    ..listen(isAppInForegroundProvider, (_, next) {
      if (next) {
        ref.invalidate(unreadCountProvider);
        ref.read(inboxProvider.notifier).scheduleSilentRefresh();
      }
    });
}
