import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/l10n/generated/app_localizations.dart';
import '../../../../constants/app_spacing.dart';
import '../../../../router/routes.dart';
import '../../../auth/application/auth_notifier.dart';
import '../../../taxonomy/application/providers/taxonomy_providers.dart';
import '../../application/providers/community_data_providers.dart';
import '../../application/providers/community_state_providers.dart';

class CommunityHomePage extends ConsumerWidget {
  const CommunityHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchText = ref.watch(searchTextProvider);
    final authState = ref.watch(authProvider);
    final currentAccountId = authState.asData?.value.account?.id;
    final l10n = AppLocalizations.of(context);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: TabBar(
            tabs: [
              Tab(text: l10n.communityForYou),
              Tab(text: l10n.communityAll),
            ],
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(56),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.screenH,
                vertical: AppSpacing.xs,
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: l10n.searchThreads,
                  prefixIcon: const Icon(Icons.search),
                ),
                onChanged: (value) {
                  ref
                      .read(searchTextProvider.notifier)
                      .setSearchText(
                        value.isEmpty ? null : value,
                      );
                },
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            _ThreadListView(
              useAllThreads: false,
              searchText: searchText,
              currentAccountId: currentAccountId,
            ),
            Column(
              children: [
                const _FilterChipsRow(),
                Expanded(
                  child: _ThreadListView(
                    useAllThreads: true,
                    useFilteredAll: true,
                    searchText: searchText,
                    currentAccountId: currentAccountId,
                  ),
                ),
              ],
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final threadId = await context.push<String>('/community/create');

            if (threadId != null && context.mounted) {
              await ThreadDetailsRoute(threadId: threadId).push<void>(context);
              if (context.mounted) {
                ref
                  ..invalidate(filteredThreadsProvider)
                  ..invalidate(allThreadsProvider);
              }
            }
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class _ThreadListView extends ConsumerWidget {
  const _ThreadListView({
    required this.useAllThreads,
    required this.searchText,
    this.currentAccountId,
    this.useFilteredAll = false,
  });

  final bool useAllThreads;
  final String? searchText;
  final String? currentAccountId;
  final bool useFilteredAll;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final threadsAsync = ref.watch(
      useFilteredAll
          ? filteredAllThreadsProvider
          : (useAllThreads ? allThreadsProvider : filteredThreadsProvider),
    );

    return threadsAsync.when(
      data: (threads) {
        if (threads.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.forum,
                  size: 64,
                  color: colorScheme.onSurfaceVariant,
                ),
                const SizedBox(height: 16),
                Text(
                  searchText?.isNotEmpty == true
                      ? l10n.noThreadsFound(searchText!)
                      : (useAllThreads
                            ? l10n.noThreadsAvailable
                            : l10n.noPersonalizedThreads),
                  style: theme.textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () async => ref.invalidate(
            useFilteredAll
                ? allThreadsProvider
                : (useAllThreads
                      ? allThreadsProvider
                      : filteredThreadsProvider),
          ),
          child: ListView.builder(
            padding: const EdgeInsets.all(AppSpacing.screenH),
            itemCount: threads.length,
            itemBuilder: (context, index) {
              final thread = threads[index];
              return Card(
                margin: const EdgeInsets.symmetric(
                  horizontal: 0,
                  vertical: AppSpacing.xs,
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage:
                        thread.authorAvatarUrl != null &&
                            thread.authorAvatarUrl!.isNotEmpty
                        ? NetworkImage(thread.authorAvatarUrl!)
                        : null,
                    child:
                        (thread.authorAvatarUrl == null ||
                            thread.authorAvatarUrl!.isEmpty)
                        ? const Icon(Icons.person)
                        : null,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.xs,
                  ),
                  title: Text(
                    thread.title,
                    style: theme.textTheme.titleMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 2),
                      Text(
                        thread.authorDisplayName ??
                            thread.authorUsername ??
                            'User ${thread.authorId.length >= 6 ? thread.authorId.substring(0, 6) : thread.authorId}',
                        style: theme.textTheme.bodySmall,
                      ),
                      if (thread.description != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          thread.description!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodySmall,
                        ),
                      ],
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            Icons.comment,
                            size: 16,
                            color: colorScheme.onSurface.withValues(alpha: 0.6),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            l10n.threadReplies(thread.replyCount),
                            style: theme.textTheme.bodySmall,
                          ),
                          const SizedBox(width: 16),
                          Icon(
                            Icons.visibility,
                            size: 16,
                            color: colorScheme.onSurface.withValues(alpha: 0.6),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            l10n.threadViews(thread.viewCount),
                            style: theme.textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                  trailing: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (thread.authorId == currentAccountId)
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: colorScheme.primaryContainer,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                l10n.owned,
                                style: TextStyle(
                                  color: colorScheme.onPrimaryContainer,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            if (thread.unreadCount > 0)
                              Positioned(
                                right: -6,
                                top: -6,
                                child: Container(
                                  padding: const EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    color: colorScheme.error,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  constraints: const BoxConstraints(
                                    minWidth: 16,
                                    minHeight: 16,
                                  ),
                                  child: Text(
                                    '${thread.unreadCount}',
                                    style: TextStyle(
                                      color: colorScheme.onError,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                          ],
                        )
                      else if (thread.isFollowed)
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Icon(
                              Icons.chat_bubble,
                              color: colorScheme.primary,
                              size: 20,
                            ),
                            if (thread.unreadCount > 0)
                              Positioned(
                                right: -6,
                                top: -6,
                                child: Container(
                                  padding: const EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    color: colorScheme.error,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  constraints: const BoxConstraints(
                                    minWidth: 16,
                                    minHeight: 16,
                                  ),
                                  child: Text(
                                    '${thread.unreadCount}',
                                    style: TextStyle(
                                      color: colorScheme.onError,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      if (thread.hasSolution) const SizedBox(height: 4),
                      if (thread.hasSolution)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: colorScheme.tertiaryContainer,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: colorScheme.tertiary),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.check_circle,
                                color: colorScheme.tertiary,
                                size: 12,
                              ),
                              const SizedBox(width: 2),
                              Text(
                                l10n.solved,
                                style: TextStyle(
                                  color: colorScheme.onTertiaryContainer,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      if (thread.isPinned) const SizedBox(height: 4),
                      if (thread.isPinned)
                        Icon(
                          Icons.push_pin,
                          color: colorScheme.primary,
                        ),
                    ],
                  ),
                  onTap: () async {
                    await ThreadDetailsRoute(
                      threadId: thread.id,
                      threadTitle: thread.title,
                    ).push<void>(context);

                    if (!context.mounted) {
                      return;
                    }

                    ref
                      ..invalidate(filteredThreadsProvider)
                      ..invalidate(allThreadsProvider);
                  },
                ),
              );
            },
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(
        child: Text(l10n.errorLoadingThreads(error.toString())),
      ),
    );
  }
}

class _FilterChipsRow extends ConsumerWidget {
  const _FilterChipsRow();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final sectorsAsync = ref.watch(sectorsProvider);
    final tagsAsync = ref.watch(tagsProvider);
    final selectedSectors = ref.watch(selectedSectorIdsProvider);
    final selectedTags = ref.watch(selectedTagIdsProvider);
    final showFollowed = ref.watch(showFollowedOnlyProvider);

    final hasFilters =
        selectedSectors.isNotEmpty || selectedTags.isNotEmpty || showFollowed;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.screenH,
            vertical: AppSpacing.xs,
          ),
          child: Row(
            children: [
              if (hasFilters)
                InkWell(
                  borderRadius: BorderRadius.circular(4),
                  onTap: () {
                    ref.read(selectedSectorIdsProvider.notifier).clear();
                    ref.read(selectedTagIdsProvider.notifier).clear();
                    ref
                        .read(showFollowedOnlyProvider.notifier)
                        .toggle(value: false);
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                    child: Icon(Icons.clear, size: 16),
                  ),
                ),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children:
                        [
                              FilterChip(
                                avatar: Icon(
                                  Icons.chat_bubble,
                                  size: 14,
                                  color: showFollowed
                                      ? Theme.of(
                                          context,
                                        ).colorScheme.onPrimaryContainer
                                      : null,
                                ),
                                label: Text(
                                  l10n.followed,
                                  style: const TextStyle(fontSize: 12),
                                ),
                                selected: showFollowed,
                                onSelected: (_) {
                                  ref
                                      .read(showFollowedOnlyProvider.notifier)
                                      .toggle(value: !showFollowed);
                                },
                                visualDensity: VisualDensity.compact,
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                              ),
                              ..._buildSelectedChips(
                                context,
                                ref,
                                sectorsAsync.asData?.value
                                        .map(
                                          (s) => _FilterItem(
                                            id: s.id,
                                            displayName: s.name.isNotEmpty
                                                ? s.name
                                                : s.slug,
                                          ),
                                        )
                                        .toList() ??
                                    [],
                                selectedSectors,
                                (id) {
                                  ref
                                      .read(selectedSectorIdsProvider.notifier)
                                      .toggle(id);
                                },
                              ),
                              ..._buildSelectedChips(
                                context,
                                ref,
                                tagsAsync.asData?.value
                                        .map(
                                          (t) => _FilterItem(
                                            id: t.id,
                                            displayName: t.name.isNotEmpty
                                                ? t.name
                                                : t.slug,
                                          ),
                                        )
                                        .toList() ??
                                    [],
                                selectedTags,
                                (id) {
                                  ref
                                      .read(selectedTagIdsProvider.notifier)
                                      .toggle(id);
                                },
                              ),
                            ]
                            .map(
                              (w) => Padding(
                                padding: const EdgeInsets.only(
                                  left: AppSpacing.xs,
                                ),
                                child: w,
                              ),
                            )
                            .toList(),
                  ),
                ),
              ),
              IconButton(
                icon: Badge(
                  isLabelVisible: hasFilters,
                  label: Text(
                    '${selectedSectors.length + selectedTags.length + (showFollowed ? 1 : 0)}',
                  ),
                  child: const Icon(Icons.filter_list),
                ),
                tooltip: l10n.moreFilters,
                onPressed: () => _openFilterSheet(context, ref),
                visualDensity: VisualDensity.compact,
              ),
            ],
          ),
        ),
        const Divider(height: 1),
      ],
    );
  }

  List<Widget> _buildSelectedChips(
    BuildContext context,
    WidgetRef ref,
    List<_FilterItem> items,
    Set<String> selectedIds,
    void Function(String) onRemove,
  ) {
    return items.where((item) => selectedIds.contains(item.id)).map((item) {
      return ActionChip(
        label: Text(
          item.displayName,
          style: Theme.of(context).textTheme.labelSmall,
        ),
        onPressed: () => onRemove(item.id),
        visualDensity: VisualDensity.compact,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
      );
    }).toList();
  }

  void _openFilterSheet(BuildContext context, WidgetRef ref) {
    unawaited(
      showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        useSafeArea: true,
        builder: (_) => const _FilterBottomSheet(),
      ),
    );
  }
}

class _FilterItem {
  const _FilterItem({required this.id, required this.displayName});
  final String id;
  final String displayName;
}

class _FilterBottomSheet extends ConsumerStatefulWidget {
  const _FilterBottomSheet();

  @override
  ConsumerState<_FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends ConsumerState<_FilterBottomSheet> {
  final _searchController = TextEditingController();
  String _searchText = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final sectorsAsync = ref.watch(sectorsProvider);
    final tagsAsync = ref.watch(tagsProvider);
    final selectedSectors = ref.watch(selectedSectorIdsProvider);
    final selectedTags = ref.watch(selectedTagIdsProvider);
    final showFollowed = ref.watch(showFollowedOnlyProvider);

    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.4,
      maxChildSize: 0.9,
      expand: false,
      builder: (context, scrollController) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.screenH,
              AppSpacing.sm,
              AppSpacing.screenH,
              AppSpacing.xs,
            ),
            child: Row(
              children: [
                Text(
                  l10n.filters,
                  style: theme.textTheme.titleLarge,
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    ref.read(selectedSectorIdsProvider.notifier).clear();
                    ref.read(selectedTagIdsProvider.notifier).clear();
                    ref
                        .read(showFollowedOnlyProvider.notifier)
                        .toggle(value: false);
                  },
                  child: Text(l10n.reset),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenH),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: l10n.searchSectorsTags,
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchText.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _searchText = '');
                        },
                      )
                    : null,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.xs,
                ),
                filled: true,
                fillColor: theme.colorScheme.surfaceContainerHighest,
              ),
              onChanged: (v) => setState(() => _searchText = v.toLowerCase()),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Expanded(
            child: ListView(
              controller: scrollController,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.screenH,
              ),
              children: [
                _buildFilterSection(
                  l10n.sectors,
                  sectorsAsync.asData?.value
                          .map(
                            (s) => _FilterItem(
                              id: s.id,
                              displayName: s.name.isNotEmpty ? s.name : s.slug,
                            ),
                          )
                          .toList() ??
                      [],
                  selectedSectors,
                  (id) {
                    ref.read(selectedSectorIdsProvider.notifier).toggle(id);
                  },
                ),
                const SizedBox(height: AppSpacing.md),
                _buildFilterSection(
                  l10n.tags,
                  tagsAsync.asData?.value
                          .map(
                            (t) => _FilterItem(
                              id: t.id,
                              displayName: t.name.isNotEmpty ? t.name : t.slug,
                            ),
                          )
                          .toList() ??
                      [],
                  selectedTags,
                  (id) {
                    ref.read(selectedTagIdsProvider.notifier).toggle(id);
                  },
                ),
                const SizedBox(height: AppSpacing.md),
                SwitchListTile(
                  title: Text(l10n.followedOnly),
                  subtitle: Text(l10n.showFollowedOnly),
                  secondary: const Icon(Icons.chat_bubble),
                  value: showFollowed,
                  onChanged: (v) {
                    ref
                        .read(showFollowedOnlyProvider.notifier)
                        .toggle(value: v);
                  },
                ),
                const SizedBox(height: AppSpacing.xxxl),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection(
    String title,
    List<_FilterItem> items,
    Set<String> selectedIds,
    void Function(String) onToggle,
  ) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final filtered = _searchText.isEmpty
        ? items
        : items.where((item) {
            return item.displayName.toLowerCase().contains(_searchText);
          }).toList();

    if (filtered.isEmpty && _searchText.isNotEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.titleSmall?.copyWith(
            color: theme.colorScheme.primary,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        if (filtered.isEmpty)
          Text(
            l10n.noItemsMatchSearch,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          )
        else
          Wrap(
            spacing: AppSpacing.xs,
            runSpacing: AppSpacing.xxs,
            children: filtered.map<Widget>((item) {
              return FilterChip(
                label: Text(item.displayName),
                selected: selectedIds.contains(item.id),
                onSelected: (_) => onToggle(item.id),
                visualDensity: VisualDensity.compact,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              );
            }).toList(),
          ),
      ],
    );
  }
}
