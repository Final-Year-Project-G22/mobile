import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../router/routes.dart';
import '../../../auth/application/auth_notifier.dart';
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
            _ThreadListView(
              useAllThreads: true,
              searchText: searchText,
              currentAccountId: currentAccountId,
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
  });

  final bool useAllThreads;
  final String? searchText;
  final String? currentAccountId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final threadsAsync = ref.watch(
      useAllThreads ? allThreadsProvider : filteredThreadsProvider,
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
            useAllThreads ? allThreadsProvider : filteredThreadsProvider,
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
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
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
                      if (thread.isPinned) ...[
                        if (thread.authorId == currentAccountId ||
                            thread.isFollowed)
                          const SizedBox(width: 8),
                        Icon(
                          Icons.push_pin,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ],
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
