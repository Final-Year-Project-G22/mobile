import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../shared/utils/formatters/date_formatters.dart';
import '../../../../constants/app_colors.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      if (!_initialized) {
        _initialized = true;
        ref.read(inboxProvider.notifier).loadInbox();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(inboxProvider.notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(inboxProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
          isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      appBar: AppBar(
        title: const Text('Inbox'),
        actions: [
          TextButton(
            onPressed: () => ref.read(inboxProvider.notifier).markAllAsRead(),
            child: const Text('Mark all read'),
          ),
          AppSpacing.gapHorizontalXs,
        ],
      ),
      body: _buildBody(state, isDark),
    );
  }

  Widget _buildBody(InboxState state, bool isDark) {
    if (state.isLoading && state.entries.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.errorMessage != null && state.entries.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: isDark ? AppColors.slate400 : AppColors.slate500,
            ),
            AppSpacing.gapVerticalMd,
            Text(
              state.errorMessage!,
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            AppSpacing.gapVerticalMd,
            ElevatedButton(
              onPressed: () => ref.read(inboxProvider.notifier).refresh(),
              child: const Text('Retry'),
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
              color: isDark ? AppColors.slate400 : AppColors.slate500,
            ),
            AppSpacing.gapVerticalMd,
            Text(
              'No notifications yet',
              style: Theme.of(context).textTheme.bodyLarge,
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
              child: Center(child: CircularProgressIndicator()),
            );
          }
          return _InboxTile(
            entry: state.entries[index],
            onTap: () {
              ref.read(inboxProvider.notifier).markAsRead(
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isUnread = !entry.isRead;

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xxs,
      ),
      decoration: BoxDecoration(
        color: isUnread
            ? (isDark
                ? AppColors.slate800.withValues(alpha: 0.6)
                : AppColors.slate100.withValues(alpha: 0.6))
            : (isDark ? AppColors.surfaceDark : AppColors.surfaceLight),
        borderRadius: AppSpacing.borderRadiusMd,
        border: Border.all(
          color: isDark ? AppColors.borderDark : AppColors.borderLight,
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
                    ? AppColors.accent.withValues(alpha: 0.15)
                    : (isDark ? AppColors.slate700 : AppColors.slate100),
                child: Icon(
                  _iconForCategory(entry.category),
                  size: 20,
                  color: isUnread
                      ? AppColors.accent
                      : (isDark ? AppColors.slate400 : AppColors.slate500),
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
                            style: TextStyle(
                              fontWeight:
                                  isUnread ? FontWeight.w600 : FontWeight.w400,
                              fontSize: 14,
                              color: isDark
                                  ? AppColors.textPrimaryDark
                                  : AppColors.textPrimaryLight,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          _formatTimeAgo(entry.notification.sentAt),
                          style: TextStyle(
                            fontSize: 12,
                            color: isDark
                                ? AppColors.textSecondaryDark
                                : AppColors.textSecondaryLight,
                          ),
                        ),
                      ],
                    ),
                    if (entry.notification.content.isNotEmpty) ...[
                      AppSpacing.gapVerticalXxs,
                      Text(
                        entry.notification.content,
                        style: TextStyle(
                          fontSize: 13,
                          color: isDark
                              ? AppColors.textSecondaryDark
                              : AppColors.textSecondaryLight,
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
                    margin: const EdgeInsets.only(top: 6),
                    decoration: const BoxDecoration(
                      color: AppColors.accent,
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

  IconData _iconForCategory(String category) {
    switch (category.toLowerCase()) {
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

  String _formatTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final diff = now.difference(dateTime);

    if (diff.inMinutes < 1) return 'now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m';
    if (diff.inHours < 24) return '${diff.inHours}h';
    if (diff.inDays < 7) return '${diff.inDays}d';
    return DateFormatters.dayMonth(dateTime);
  }
}
