import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/l10n/generated/app_localizations.dart';
import '../../../../../shared/utils/formatters/date_formatters.dart';
import '../../../../../shared/widgets/adisu_progress_indicator.dart';
import '../../../../constants/app_spacing.dart';
import '../../application/inbox_notifier.dart';
import '../../application/inbox_state.dart';
import '../../domain/entities/inbox_entry.dart';

class InboxPage extends ConsumerStatefulWidget {
  const InboxPage({super.key});

  @override
  ConsumerState<InboxPage> createState() => _InboxPageState();
}

class _InboxPageState extends ConsumerState<InboxPage> {
  final _scrollController = ScrollController();
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) return;
      if (!_initialized) {
        _initialized = true;
        await ref.read(inboxProvider.notifier).loadInbox();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _onScroll() async {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      await ref.read(inboxProvider.notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(inboxProvider);
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.inbox),
        actions: [
          TextButton(
            onPressed: () => ref.read(inboxProvider.notifier).markAllAsRead(),
            child: Text(l10n.markAllRead),
          ),
          AppSpacing.gapHorizontalXs,
        ],
      ),
      body: _buildBody(state, l10n),
    );
  }

  Widget _buildBody(InboxState state, AppLocalizations l10n) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    if (state.isLoading && state.entries.isEmpty) {
      return const Center(child: AdisuProgressIndicator());
    }

    if (state.errorMessage != null && state.entries.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: colorScheme.onSurfaceVariant,
            ),
            AppSpacing.gapVerticalMd,
            Text(
              state.errorMessage!,
              style: textTheme.bodyLarge?.copyWith(
                color: colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            AppSpacing.gapVerticalMd,
            FilledButton.tonal(
              onPressed: () => ref.read(inboxProvider.notifier).refresh(),
              child: Text(l10n.retry),
            ),
          ],
        ),
      );
    }

    if (state.entries.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.notifications_none_rounded,
              size: 64,
              color: colorScheme.onSurfaceVariant,
            ),
            AppSpacing.gapVerticalMd,
            Text(
              l10n.noNotifications,
              style: textTheme.bodyLarge?.copyWith(
                color: colorScheme.onSurface,
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () => ref.read(inboxProvider.notifier).refresh(),
      child: ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.only(top: AppSpacing.xs),
        itemCount: state.entries.length + (state.isLoadingMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == state.entries.length) {
            return const Padding(
              padding: EdgeInsets.all(AppSpacing.md),
              child: Center(child: AdisuProgressIndicator.small()),
            );
          }
          return _InboxTile(
            entry: state.entries[index],
            onTap: () async {
              await ref
                  .read(inboxProvider.notifier)
                  .markAsRead(
                    state.entries[index].id,
                  );
            },
          );
        },
      ),
    );
  }
}

class _InboxTile extends StatelessWidget {
  const _InboxTile({required this.entry, required this.onTap});

  final InboxEntry entry;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final isUnread = !entry.isRead;
    final l10n = AppLocalizations.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xxs,
      ),
      decoration: BoxDecoration(
        color: isUnread
            ? colorScheme.primaryContainer.withValues(alpha: 0.3)
            : colorScheme.surface,
        borderRadius: AppSpacing.borderRadiusMd,
        border: Border.all(
          color: colorScheme.outlineVariant,
          width: 0.5,
        ),
      ),
      child: InkWell(
        borderRadius: AppSpacing.borderRadiusMd,
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: isUnread
                    ? colorScheme.primaryContainer
                    : colorScheme.surfaceContainerHigh,
                child: Icon(
                  _iconForType(entry.notification.type),
                  size: 20,
                  color: isUnread
                      ? colorScheme.onPrimaryContainer
                      : colorScheme.onSurfaceVariant,
                ),
              ),
              AppSpacing.gapHorizontalSm,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            entry.notification.title,
                            style: textTheme.titleSmall?.copyWith(
                              fontWeight: isUnread
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                              color: colorScheme.onSurface,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          _formatTimeAgo(entry.notification.sentAt, l10n),
                          style: textTheme.labelSmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                    if (entry.notification.content.isNotEmpty) ...[
                      AppSpacing.gapVerticalXxs,
                      Text(
                        entry.notification.content,
                        style: textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
              if (isUnread)
                Padding(
                  padding: const EdgeInsets.only(left: AppSpacing.xs),
                  child: Container(
                    width: 8,
                    height: 8,
                    margin: const EdgeInsets.only(top: AppSpacing.xs),
                    decoration: BoxDecoration(
                      color: colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _iconForType(String type) {
    switch (type.toLowerCase()) {
      case 'system':
        return Icons.campaign_rounded;
      case 'comment':
      case 'reply':
        return Icons.chat_bubble_outline_rounded;
      case 'mention':
        return Icons.alternate_email_rounded;
      case 'like':
      case 'reaction':
        return Icons.thumb_up_outlined;
      case 'follow':
        return Icons.person_add_outlined;
      case 'guide':
        return Icons.menu_book_outlined;
      default:
        return Icons.notifications_outlined;
    }
  }

  String _formatTimeAgo(DateTime dateTime, AppLocalizations l10n) {
    final now = DateTime.now();
    final diff = now.difference(dateTime);

    if (diff.inMinutes < 1) return l10n.timeNow;
    if (diff.inMinutes < 60) return l10n.timeMinutesShort(diff.inMinutes);
    if (diff.inHours < 24) return l10n.timeHoursShort(diff.inHours);
    if (diff.inDays < 7) return l10n.timeDaysShort(diff.inDays);
    return DateFormatters.dayMonth(dateTime);
  }
}
