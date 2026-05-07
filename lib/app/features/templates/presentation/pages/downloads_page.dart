import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../application/providers/downloads_notifier.dart';

class DownloadsPage extends ConsumerStatefulWidget {
  const DownloadsPage({super.key});

  @override
  ConsumerState<DownloadsPage> createState() => _DownloadsPageState();
}

class _DownloadsPageState extends ConsumerState<DownloadsPage> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      unawaited(ref.read(myDownloadsProvider.notifier).loadMore());
    }
  }

  @override
  Widget build(BuildContext context) {
    final downloadsAsync = ref.watch(myDownloadsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Downloads'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await ref.read(myDownloadsProvider.notifier).refresh();
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
              controller: _scrollController,
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
                  margin: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 4,
                  ),
                  child: ListTile(
                    leading: item.thumbnailUrl != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: Image.network(
                              item.thumbnailUrl!,
                              width: 48,
                              height: 48,
                              fit: BoxFit.cover,
                              errorBuilder: (_context, _error, _stackTrace) => const Icon(
                                Icons.insert_drive_file,
                              ),
                            ),
                          )
                        : const Icon(Icons.insert_drive_file),
                    title: Text(item.title ?? 'Template'),
                    subtitle: Text(
                      _formatDate(item.downloadedAt),
                    ),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      context.push('/templates/${item.groupId}');
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

  String _formatDate(DateTime date) {
    final local = date.toLocal();
    return '${local.day}/${local.month}/${local.year} ${local.hour}:${local.minute.toString().padLeft(2, '0')}';
  }
}
