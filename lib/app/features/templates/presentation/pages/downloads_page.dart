import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/config/app_config.dart';
import '../../../../../core/l10n/generated/app_localizations.dart';
import '../../../../../shared/utils/extensions/datetime_extensions.dart';
import '../../../../../shared/widgets/adisu_progress_indicator.dart';
import '../../../../../shared/widgets/empty_state_view.dart';
import '../../../../constants/app_spacing.dart';
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
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      unawaited(ref.read(myDownloadsProvider.notifier).loadMore());
    }
  }

  @override
  Widget build(BuildContext context) {
    final downloadsAsync = ref.watch(myDownloadsProvider);
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.myDownloads),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await ref.read(myDownloadsProvider.notifier).refresh();
        },
        child: downloadsAsync.when(
          data: (state) {
            if (state.items.isEmpty) {
              return EmptyStateView(
                icon: Icons.download_done,
                title: l10n.noDownloadsYet,
              );
            }

            return ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(AppSpacing.screenH),
              itemCount: state.items.length + (state.isLoadingMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index >= state.items.length) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: AdisuProgressIndicator(),
                    ),
                  );
                }

                final item = state.items[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    vertical: AppSpacing.xxs,
                  ),
                  child: ListTile(
                    leading: item.thumbnailUrl != null
                        ? ClipRRect(
                            borderRadius: AppSpacing.borderRadiusXs,
                            child: Image.network(
                              AppConfig.rewriteFileUrl(item.thumbnailUrl!),
                              width: 48,
                              height: 48,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(
                                    Icons.insert_drive_file,
                                  ),
                            ),
                          )
                        : const Icon(Icons.insert_drive_file),
                    title: Text(item.title ?? l10n.templates),
                    subtitle: Text(
                      item.downloadedAt.formattedDateTime,
                    ),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () async {
                      await context.push('/templates/${item.groupId}');
                    },
                  ),
                );
              },
            );
          },
          loading: () => const Center(child: AdisuProgressIndicator()),
          error: (error, _) => Center(child: Text('${l10n.error}: $error')),
        ),
      ),
    );
  }
}
