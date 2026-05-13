import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/providers/sse_providers.dart';
import 'inbox_notifier.dart';
import 'unread_count_provider.dart';

part 'sse_inbox_listener.g.dart';

@Riverpod(keepAlive: true)
class LiveUnreadCount extends _$LiveUnreadCount {
  @override
  int? build() => null;

  void update(int count) {
    state = count;
  }
}

@riverpod
AsyncValue<int> notificationBadgeCount(Ref ref) {
  final live = ref.watch(liveUnreadCountProvider);
  if (live != null) {
    return AsyncData(live);
  }
  return ref.watch(unreadCountProvider);
}

@Riverpod(keepAlive: true)
void sseInboxListener(Ref ref) {
  ref.listen(sseInboxEventsProvider, (_, next) {
    final msg = next.asData?.value;
    if (msg == null) return;

    final event = msg['event'] as String?;

    if (event != 'notification_new') return;

    final unreadCount = msg['unreadCount'];
    if (unreadCount is int) {
      ref.read(liveUnreadCountProvider.notifier).update(unreadCount);
    }

    ref.read(inboxProvider.notifier).scheduleSilentRefresh();
  });
}
