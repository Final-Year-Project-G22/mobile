import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/l10n/generated/app_localizations.dart';
import '../../../../../shared/utils/formatters/date_formatters.dart' show DateFormatters;
import '../../../../../shared/widgets/adisu_progress_indicator.dart';
import '../../../../constants/app_spacing.dart';
import '../../application/inbox_notifier.dart';
import '../../application/inbox_state.dart';
import '../../compliance/presentation/pages/compliance_page.dart';
import '../../domain/entities/inbox_entry.dart';
import '../../domain/failures/inbox_failure.dart';
import '../../scheduled_alerts/presentation/pages/scheduled_alerts_page.dart';

class InboxPage extends ConsumerStatefulWidget {
  const InboxPage({super.key});

  @override
  ConsumerState<InboxPage> createState() => _InboxPageState();
}

class _InboxPageState extends ConsumerState<InboxPage>
    with SingleTickerProviderStateMixin {
  final _scrollController = ScrollController();
  bool _initialized = false;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
    _tabController.dispose();
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
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: l10n.inboxTab),
            Tab(text: l10n.scheduledTab),
            Tab(text: l10n.compliance),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildBody(state, l10n),
          const ScheduledAlertsPage(),
          const CompliancePage(),
        ],
      ),
    );
  }

  Widget _buildBody(InboxState state, AppLocalizations l10n) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    if (state.isLoading && state.entries.isEmpty) {
      return const Center(child: AdisuProgressIndicator());
    }

    if (state.failure != null && state.entries.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline,
                size: 48, color: colorScheme.onSurfaceVariant),
            const SizedBox(height: 16),
            Text(
              state.failure?.when(
                serverError: (_) => l10n.errorServer,
                notFound: () => l10n.errorUnknown,
                unauthorized: () => l10n.errorUnauthorized,
                invalidData: (_) => l10n.errorUnknown,
                networkError: () => l10n.errorNetwork,
              ) ?? l10n.errorUnknown,
              style: textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () =>
                  ref.read(inboxProvider.notifier).loadInbox(),
              child: Text(l10n.retry),
            ),
          ],
        ),
      );
    }

    final filteredEntries = state.entries;

    if (filteredEntries.isEmpty && !state.isLoading) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.inbox_outlined,
                size: 64, color: colorScheme.onSurfaceVariant),
            const SizedBox(height: 16),
            Text(
              l10n.inboxEmpty,
              style: textTheme.bodyLarge,
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () => ref.read(inboxProvider.notifier).loadInbox(),
      child: ListView.builder(
        controller: _scrollController,
        itemCount: filteredEntries.length + (state.isLoading ? 1 : 0),
        itemBuilder: (context, index) {
          if (index >= filteredEntries.length) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: AdisuProgressIndicator(),
              ),
            );
          }
          final entry = filteredEntries[index];
          return _InboxTile(
            entry: entry,
            onTap: () => ref.read(inboxProvider.notifier).markAsRead(entry.id),
          );
        },
      ),
    );
  }
}

class _InboxTile extends StatelessWidget {
  const _InboxTile({required this.entry, this.onTap});

  final InboxEntry entry;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        leading: Icon(
          entry.notification.type == 'account_alert_critical'
              ? Icons.warning
              : Icons.notifications,
          color: entry.isRead
              ? colorScheme.onSurfaceVariant
              : colorScheme.primary,
        ),
        title: Text(
          entry.notification.title,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: entry.isRead ? FontWeight.normal : FontWeight.w600,
          ),
        ),
        subtitle: Text(
          entry.notification.content,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.bodySmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        trailing: Text(
          DateFormatters.shortDate(entry.notification.sentAt),
          style: theme.textTheme.labelSmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
