import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const TabBar(
            tabs: [
              Tab(text: 'For You'),
              Tab(text: 'All'),
            ],
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(56),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search threads...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Theme.of(
                    context,
                  ).colorScheme.surfaceContainerHighest,
                  contentPadding: EdgeInsets.zero,
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
    super.key,
  });

  final bool useAllThreads;
  final String? searchText;
  final String? currentAccountId;
  final bool useFilteredAll;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                const Icon(Icons.forum, size: 64, color: Colors.grey),
                const SizedBox(height: 16),
                Text(
                  searchText?.isNotEmpty == true
                      ? 'No threads found for "$searchText"'
                      : (useAllThreads ? 'No threads available yet' : 'No personalized threads available yet'),
                  style: Theme.of(context).textTheme.titleMedium,
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
                : (useAllThreads ? allThreadsProvider : filteredThreadsProvider),
          ),
          child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: threads.length,
            itemBuilder: (context, index) {
              final thread = threads[index];
              return Card(
                margin: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: thread.authorAvatarUrl != null && thread.authorAvatarUrl!.isNotEmpty
                        ? NetworkImage(thread.authorAvatarUrl!)
                        : null,
                    child: (thread.authorAvatarUrl == null || thread.authorAvatarUrl!.isEmpty)
                        ? const Icon(Icons.person)
                        : null,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  title: Text(
                    thread.title,
                    style: Theme.of(context).textTheme.titleMedium,
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
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      if (thread.description != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          thread.description!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            Icons.comment,
                            size: 16,
                            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${thread.replyCount} replies',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          const SizedBox(width: 16),
                          Icon(
                            Icons.visibility,
                            size: 16,
                            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${thread.viewCount} views',
                            style: Theme.of(context).textTheme.bodySmall,
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
                                color: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                'Owned',
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimaryContainer,
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
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  constraints: const BoxConstraints(
                                    minWidth: 16,
                                    minHeight: 16,
                                  ),
                                  child: Text(
                                    '${thread.unreadCount}',
                                    style: const TextStyle(
                                      color: Colors.white,
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
                              color: Theme.of(context).colorScheme.primary,
                              size: 20,
                            ),
                            if (thread.unreadCount > 0)
                              Positioned(
                                right: -6,
                                top: -6,
                                child: Container(
                                  padding: const EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  constraints: const BoxConstraints(
                                    minWidth: 16,
                                    minHeight: 16,
                                  ),
                                  child: Text(
                                    '${thread.unreadCount}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      if (thread.hasSolution)
                        const SizedBox(height: 4),
                      if (thread.hasSolution)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.green),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.check_circle,
                                color: Colors.green,
                                size: 12,
                              ),
                              SizedBox(width: 2),
                              Text(
                                'Solved',
                                style: TextStyle(
                                  color: Colors.green,
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
                          color: Theme.of(context).colorScheme.primary,
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
        child: Text('Error loading threads: $error'),
      ),
    );
  }
}

class _FilterChipsRow extends ConsumerWidget {
  const _FilterChipsRow();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sectorsAsync = ref.watch(sectorsProvider);
    final tagsAsync = ref.watch(tagsProvider);
    final selectedSectors = ref.watch(selectedSectorIdsProvider);
    final selectedTags = ref.watch(selectedTagIdsProvider);
    final showFollowed = ref.watch(showFollowedOnlyProvider);

    final hasFilters = selectedSectors.isNotEmpty ||
        selectedTags.isNotEmpty ||
        showFollowed;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Row(
            children: [
              if (hasFilters)
                InkWell(
                  borderRadius: BorderRadius.circular(4),
                  onTap: () {
                    ref.read(selectedSectorIdsProvider.notifier).clear();
                    ref.read(selectedTagIdsProvider.notifier).clear();
                    ref.read(showFollowedOnlyProvider.notifier).toggle(value: false);
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
                    children: [
                      FilterChip(
                        avatar: Icon(
                          Icons.chat_bubble,
                          size: 14,
                          color: showFollowed
                              ? Theme.of(context).colorScheme.onPrimaryContainer
                              : null,
                        ),
                        label: const Text('Followed', style: TextStyle(fontSize: 12)),
                        selected: showFollowed,
                        onSelected: (_) {
                          ref.read(showFollowedOnlyProvider.notifier).toggle(value: !showFollowed);
                        },
                        visualDensity: VisualDensity.compact,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      ..._buildSelectedChips(ref, sectorsAsync, selectedSectors, (id) {
                        ref.read(selectedSectorIdsProvider.notifier).toggle(id);
                      }),
                      ..._buildSelectedChips(ref, tagsAsync, selectedTags, (id) {
                        ref.read(selectedTagIdsProvider.notifier).toggle(id);
                      }),
                    ].map((w) => Padding(
                          padding: const EdgeInsets.only(left: 6),
                          child: w,
                        )).toList(),
                  ),
                ),
              ),
              IconButton(
                icon: Badge(
                  isLabelVisible: hasFilters,
                  label: Text('${selectedSectors.length + selectedTags.length + (showFollowed ? 1 : 0)}'),
                  child: const Icon(Icons.filter_list),
                ),
                tooltip: 'More filters',
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
    WidgetRef ref,
    AsyncValue<List<dynamic>> dataAsync,
    Set<String> selectedIds,
    void Function(String) onRemove,
  ) {
    final data = dataAsync.asData?.value ?? const [];
    return data
        .where((item) => selectedIds.contains((item as dynamic).id as String))
        .map((item) {
      final id = (item as dynamic).id as String;
      final name = (item as dynamic).name as String;
      final slug = (item as dynamic).slug as String;
      final label = name.isNotEmpty ? name : slug;
      return ActionChip(
        label: Text(label, style: const TextStyle(fontSize: 11)),
        onPressed: () => onRemove(id),
        visualDensity: VisualDensity.compact,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: const EdgeInsets.symmetric(horizontal: 6),
      );
    }).toList();
  }

  void _openFilterSheet(BuildContext context, WidgetRef ref) {
    unawaited(
      showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => _FilterBottomSheet(),
    ));
  }
}

class _FilterBottomSheet extends ConsumerStatefulWidget {
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
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: Row(
              children: [
                const Text('Filters', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    ref.read(selectedSectorIdsProvider.notifier).clear();
                    ref.read(selectedTagIdsProvider.notifier).clear();
                    ref.read(showFollowedOnlyProvider.notifier).toggle(value: false);
                  },
                  child: const Text('Reset'),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search sectors and tags...',
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
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                filled: true,
                fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
              ),
              onChanged: (v) => setState(() => _searchText = v.toLowerCase()),
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView(
              controller: scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildFilterSection('Sectors', sectorsAsync, selectedSectors, (id) {
                  ref.read(selectedSectorIdsProvider.notifier).toggle(id);
                }),
                const SizedBox(height: 16),
                _buildFilterSection('Tags', tagsAsync, selectedTags, (id) {
                  ref.read(selectedTagIdsProvider.notifier).toggle(id);
                }),
                const SizedBox(height: 16),
                SwitchListTile(
                  title: const Text('Followed only'),
                  subtitle: const Text('Show only threads you follow'),
                  secondary: const Icon(Icons.chat_bubble),
                  value: showFollowed,
                  onChanged: (v) {
                    ref.read(showFollowedOnlyProvider.notifier).toggle(value: v);
                  },
                ),
                const SizedBox(height: 80),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection(
    String title,
    AsyncValue<List<dynamic>> dataAsync,
    Set<String> selectedIds,
    void Function(String) onToggle,
  ) {
    final data = dataAsync.asData?.value ?? const [];
    final filtered = _searchText.isEmpty
        ? data
        : data.where((item) {
            final d = item as dynamic;
            final name = (d.name as String).toLowerCase();
            final slug = (d.slug as String).toLowerCase();
            return name.contains(_searchText) || slug.contains(_searchText);
          }).toList();

    if (filtered.isEmpty && _searchText.isNotEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(height: 8),
        if (filtered.isEmpty)
          const Text('No items match your search', style: TextStyle(color: Colors.grey))
        else
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: filtered.map<Widget>((item) {
              final d = item as dynamic;
              final id = d.id as String;
              final name = d.name as String;
              final slug = d.slug as String;
              final label = name.isNotEmpty ? name : slug;
              return FilterChip(
                label: Text(label),
                selected: selectedIds.contains(id),
                onSelected: (_) => onToggle(id),
                visualDensity: VisualDensity.compact,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              );
            }).toList(),
          ),
      ],
    );
  }
}
