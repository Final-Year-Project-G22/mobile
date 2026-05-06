import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../application/providers/community_data_providers.dart';
import '../../application/providers/community_state_providers.dart';
import '../widgets/create_thread_sheet.dart';

class CommunityHomePage extends ConsumerWidget {
  const CommunityHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesAsync = ref.watch(categoriesProvider);
    final threadsAsync = ref.watch(filteredThreadsProvider);
    final selectedCategoryId = ref.watch(selectedCategoryIdProvider);
    final searchText = ref.watch(searchTextProvider);

    return Scaffold(
      appBar: AppBar(
        // title: const Text('Community -hhh'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(10),
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
      body: Column(
        children: [
          // Category chips
          categoriesAsync.when(
            data: (categories) {
              if (categories.isEmpty) return const SizedBox.shrink();

              return Container(
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    final isSelected = selectedCategoryId == category.id;

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: FilterChip(
                        label: Text(category.name),
                        selected: isSelected,
                        onSelected: (selected) {
                          ref
                              .read(selectedCategoryIdProvider.notifier)
                              .setCategoryId(
                                selected ? category.id : null,
                              );
                        },
                      ),
                    );
                  },
                ),
              );
            },
            loading: () => const SizedBox(
              height: 50,
              child: Center(child: LinearProgressIndicator()),
            ),
            error: (error, stackTrace) => const SizedBox.shrink(),
          ),

          // Thread list
          Expanded(
            child: threadsAsync.when(
              data: (threads) {
                if (threads.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.forum, size: 64, color: Colors.grey),
                        const SizedBox(height: 16),
                        Text(
                          searchText != null && searchText.isNotEmpty
                              ? 'No threads found for "$searchText"'
                              : selectedCategoryId != null
                              ? 'No threads in this category'
                              : 'No threads available yet',
                          style: Theme.of(context).textTheme.titleMedium,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
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
                                  color:
                                      Theme.of(
                                        context,
                                      ).colorScheme.onSurface.withValues(
                                        alpha: 0.6,
                                      ),
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
                                  color:
                                      Theme.of(
                                        context,
                                      ).colorScheme.onSurface.withValues(
                                        alpha: 0.6,
                                      ),
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
                        trailing: thread.isPinned
                            ? Icon(
                                Icons.push_pin,
                                color: Theme.of(context).colorScheme.primary,
                              )
                            : null,
                        onTap: () async {
                          await GoRouter.of(
                            context,
                          ).push<void>('/community/thread/${thread.id}');

                          if (!context.mounted) {
                            return;
                          }

                          ref.invalidate(filteredThreadsProvider);
                        },
                      ),
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(
                child: Text('Error loading threads: $error'),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final threadId = await showModalBottomSheet<String>(
            context: context,
            isScrollControlled: true,
            builder: (_) => const CreateThreadSheet(),
          );

          if (threadId != null && context.mounted) {
            await context.push<void>('/community/thread/$threadId');
            if (context.mounted) {
              ref.invalidate(filteredThreadsProvider);
            }
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
