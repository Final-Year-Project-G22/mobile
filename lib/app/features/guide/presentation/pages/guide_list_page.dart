import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/l10n/generated/app_localizations.dart';
import '../../../../../shared/widgets/adisu_progress_indicator.dart';
import '../../../../../shared/widgets/empty_state_view.dart';
import '../../../../../shared/widgets/error_view.dart';
import '../../../../../shared/widgets/styled_filter_chip.dart';
import '../../../../constants/app_spacing.dart';
import '../../application/guide_list_notifier.dart';
import '../../application/guide_state.dart';
import '../widgets/guide_card.dart';
import '../widgets/recent_guide_rail.dart';
import '../widgets/taxonomy_filter_bar.dart';

class GuideListPage extends ConsumerStatefulWidget {
  const GuideListPage({super.key});

  @override
  ConsumerState<GuideListPage> createState() => _GuideListPageState();
}

class _GuideListPageState extends ConsumerState<GuideListPage> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(guideListProvider);
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // ── Search field ────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.screenH,
                AppSpacing.md,
                AppSpacing.screenH,
                AppSpacing.sm,
              ),
              child: ValueListenableBuilder<TextEditingValue>(
                valueListenable: _searchController,
                builder: (context, value, _) {
                  return TextField(
                    controller: _searchController,
                    onChanged: (query) {
                      ref.read(guideListProvider.notifier).search(query);
                    },
                    decoration: InputDecoration(
                      hintText: l10n.guideSearchHint,
                      prefixIcon: const Icon(Icons.search, size: 20),
                      suffixIcon: value.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear, size: 18),
                              tooltip: 'Clear search',
                              onPressed: () {
                                _searchController.clear();
                                ref.read(guideListProvider.notifier).search('');
                              },
                            )
                          : null,
                      // Uses InputDecorationTheme from AppTheme
                    ),
                  );
                },
              ),
            ),

            // ── For You / All tabs ──────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.screenH,
              ),
              child: Row(
                children: [
                  _GuideTabChip(
                    label: l10n.guideTabForYou,
                    isSelected: state.selectedTab == GuideTab.forYou,
                    onTap: () {
                      ref
                          .read(guideListProvider.notifier)
                          .switchTab(GuideTab.forYou);
                    },
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  _GuideTabChip(
                    label: l10n.guideTabAll,
                    isSelected: state.selectedTab == GuideTab.all,
                    onTap: () {
                      ref
                          .read(guideListProvider.notifier)
                          .switchTab(GuideTab.all);
                    },
                  ),
                ],
              ),
            ),
            AppSpacing.gapVerticalSm,

            // ── Recent rail ─────────────────────────────────────────
            if (state.recentGuides.isNotEmpty)
              RecentGuideRail(guides: state.recentGuides),
            if (state.recentGuides.isNotEmpty) AppSpacing.gapVerticalSm,

            // ── Taxonomy filters ────────────────────────────────────
            TaxonomyFilterBar(
              selectedSectorId: state.selectedSectorId,
              selectedTagIds: state.selectedTagIds,
              onSectorSelected: (id) {
                ref.read(guideListProvider.notifier).selectSector(id);
              },
              onTagToggled: (id) {
                ref.read(guideListProvider.notifier).toggleTag(id);
              },
              onClearFilters: () {
                ref.read(guideListProvider.notifier).clearFilters();
              },
            ),

            // ── Active filter indicator ─────────────────────────────
            if (state.hasActiveFilters)
              Padding(
                padding: const EdgeInsets.only(
                  left: AppSpacing.screenH,
                  right: AppSpacing.screenH,
                  bottom: AppSpacing.xs,
                ),
                child: Row(
                  children: [
                    Text(
                      l10n.guideFiltered,
                      style: textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        ref.read(guideListProvider.notifier).clearFilters();
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        l10n.guideClearAll,
                        style: textTheme.labelMedium?.copyWith(
                          color: colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            // ── Bookmark toggle ─────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.screenH,
                vertical: AppSpacing.xs,
              ),
              child: Row(
                children: [
                  const Spacer(),
                  StyledFilterChip(
                    avatar: Icon(
                      state.showBookmarked
                          ? Icons.bookmark
                          : Icons.bookmark_border,
                      size: 18,
                    ),
                    label: l10n.guideBookmarked,
                    isSelected: state.showBookmarked,
                    onSelected: (_) {
                      ref.read(guideListProvider.notifier).toggleBookmarked();
                    },
                  ),
                ],
              ),
            ),

            // ── Content ─────────────────────────────────────────────
            Expanded(
              child: _buildContent(l10n),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(AppLocalizations l10n) {
    final state = ref.watch(guideListProvider);

    // ── Bookmarks tab ─────────────────────────────────────────────
    if (state.showBookmarked) {
      return _buildBookmarksList(l10n);
    }

    // ── Loading state (initial load, no cached data) ──────────────
    if (state.isLoading && state.guides.isEmpty) {
      return const Center(child: AdisuProgressIndicator.large());
    }

    // ── Error state (load failed, nothing to show) ──────────────
    if (!state.isLoading && state.guides.isEmpty && state.hasError) {
      return ErrorView.inline(
        message: l10n.errorGeneric,
        retryLabel: l10n.retry,
        onRetry: () => ref.read(guideListProvider.notifier).refresh(),
      );
    }

    // ── Empty state (no guides available) ─────────────────────
    if (!state.isLoading && state.guides.isEmpty) {
      return EmptyStateView(
        icon: Icons.menu_book_outlined,
        title: l10n.guideEmptyState,
      );
    }

    // ── Guides list ───────────────────────────────────────────────
    return ListView.separated(
      padding: const EdgeInsets.all(AppSpacing.screenH),
      itemCount: state.guides.length,
      separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.cardGap),
      itemBuilder: (context, index) {
        final guide = state.guides[index];
        return GuideCardWidget(
          guide: guide,
          onTap: () {
            unawaited(context.push('/guides/${guide.slug}'));
          },
        );
      },
    );
  }

  Widget _buildBookmarksList(AppLocalizations l10n) {
    final state = ref.watch(guideListProvider);
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    if (state.isLoading && state.bookmarks.isEmpty) {
      return const Center(child: AdisuProgressIndicator.large());
    }

    if (state.bookmarks.isEmpty) {
      return EmptyStateView(
        icon: Icons.bookmark_border,
        title: l10n.guideNoBookmarks,
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(AppSpacing.screenH),
      itemCount: state.bookmarks.length,
      separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.cardGap),
      itemBuilder: (context, index) {
        final bkmk = state.bookmarks[index];
        return Card(
          child: Padding(
            padding: AppSpacing.paddingMd,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.bookmark,
                      size: 16,
                      color: colorScheme.secondary,
                    ),
                    AppSpacing.gapHorizontalXs,
                    Expanded(
                      child: Text(
                        bkmk.stepTitle,
                        style: textTheme.titleSmall?.copyWith(
                          color: colorScheme.onSurface,
                        ),
                      ),
                    ),
                  ],
                ),
                AppSpacing.gapVerticalXxs,
                Text(
                  bkmk.guideName,
                  style: textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _GuideTabChip extends StatelessWidget {
  const _GuideTabChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? colorScheme.primaryContainer : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? colorScheme.primary
                : colorScheme.outlineVariant,
          ),
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: isSelected
                ? colorScheme.onPrimaryContainer
                : colorScheme.onSurfaceVariant,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
