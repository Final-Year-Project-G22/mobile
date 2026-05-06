import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../application/providers/downloads_notifier.dart';

class DownloadsPage extends ConsumerWidget {
  const DownloadsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final downloadsAsync = ref.watch(myDownloadsNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Downloads'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await ref.read(myDownloadsNotifierProvider.notifier).refresh();
        },
        child: downloadsAsync.when(
          data: (state) {
            if (state.items.isEmpty) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.download_done, size: 64, color: Colors.grey),
                    SizedBox(height: 16),
                    Text('No downloads yet'),
                  ],
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: state.items.length + (state.isLoadingMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index >= state.items.length) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                final item = state.items[index];
                return Card(
                  child: ListTile(
                    leading: item.thumbnailUrl != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: Image.network(
                              item.thumbnailUrl!,
                              width: 48,
                              height: 48,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) =>
                                  const Icon(Icons.insert_drive_file),
                            ),
                          )
                        : const Icon(Icons.insert_drive_file),
                    title: Text(item.title ?? 'Template'),
                    subtitle: Text(
                      item.downloadedAt.toLocal().toString(),
                    ),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      if (item.slug != null) {
                        context.push('/templates/${item.slug}');
                      }
                    },
                  ),
                );
              },
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Center(child: Text('Error: $error')),
        ),
      ),
    );
  }
}
