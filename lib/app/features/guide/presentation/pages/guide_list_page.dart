import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/l10n/generated/app_localizations.dart';
import '../../../../constants/app_colors.dart';
import '../../../../constants/app_spacing.dart';
import '../../application/guide_list_notifier.dart';
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: isDark
          ? AppColors.backgroundDark
          : AppColors.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.md,
                AppSpacing.md,
                AppSpacing.md,
                AppSpacing.sm,
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (value) {
                  ref.read(guideListProvider.notifier).search(value);
                },
                decoration: InputDecoration(
                  hintText: l10n.guideSearchHint,
                  prefixIcon: const Icon(Icons.search, size: 20),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear, size: 18),
                          onPressed: () {
                            _searchController.clear();
                            ref.read(guideListProvider.notifier).search('');
                          },
                        )
                      : null,
                  filled: true,
                  fillColor: isDark
                      ? AppColors.inputFillDark
                      : AppColors.inputFillLight,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: AppSpacing.borderRadiusMd,
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            if (state.recentGuides.isNotEmpty)
              RecentGuideRail(guides: state.recentGuides),
            if (state.recentGuides.isNotEmpty) AppSpacing.gapVerticalSm,
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
            if (state.hasActiveFilters)
              Padding(
                padding: const EdgeInsets.only(
                  left: AppSpacing.md,
                  right: AppSpacing.md,
                  bottom: AppSpacing.xs,
                ),
                child: Row(
                  children: [
                    Text(
                      l10n.guideFiltered,
                      style: TextStyle(
                        fontSize: 12,
                        color: isDark
                            ? AppColors.textSecondaryDark
                            : AppColors.textSecondaryLight,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        ref.read(guideListProvider.notifier).clearFilters();
                      },
                      child: Text(
                        l10n.guideClearAll,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.accent,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.xs,
              ),
              child: Row(
                children: [
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      ref.read(guideListProvider.notifier).toggleBookmarked();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: state.showBookmarked
                            ? AppColors.accent
                            : (isDark
                                  ? AppColors.slate700
                                  : AppColors.slate100),
                        borderRadius: AppSpacing.borderRadiusFull,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            state.showBookmarked
                                ? Icons.bookmark
                                : Icons.bookmark_border,
                            size: 16,
                            color: state.showBookmarked
                                ? Colors.white
                                : (isDark
                                      ? AppColors.textSecondaryDark
                                      : AppColors.textSecondaryLight),
                          ),
                          AppSpacing.gapHorizontalXxs,
                          Text(
                            l10n.guideBookmarked,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: state.showBookmarked
                                  ? FontWeight.w600
                                  : FontWeight.w500,
                              color: state.showBookmarked
                                  ? Colors.white
                                  : (isDark
                                        ? AppColors.textSecondaryDark
                                        : AppColors.textSecondaryLight),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: state.showBookmarked
                  ? _buildBookmarksList(isDark, l10n)
                  : _buildGuidesList(isDark, l10n),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGuidesList(bool isDark, AppLocalizations l10n) {
    final state = ref.watch(guideListProvider);
    if (state.guides.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.search_off,
              size: 48,
              color: isDark ? AppColors.slate600 : AppColors.slate400,
            ),
            AppSpacing.gapVerticalSm,
            Text(
              l10n.guideNoGuidesFound,
              style: TextStyle(
                fontSize: 15,
                color: isDark
                    ? AppColors.textSecondaryDark
                    : AppColors.textSecondaryLight,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(AppSpacing.md),
      itemCount: state.guides.length,
      separatorBuilder: (_, _) => AppSpacing.gapVerticalSm,
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

  Widget _buildBookmarksList(bool isDark, AppLocalizations l10n) {
    final state = ref.watch(guideListProvider);
    if (state.bookmarks.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.bookmark_border,
              size: 48,
              color: isDark ? AppColors.slate600 : AppColors.slate400,
            ),
            AppSpacing.gapVerticalSm,
            Text(
              l10n.guideNoBookmarks,
              style: TextStyle(
                fontSize: 15,
                color: isDark
                    ? AppColors.textSecondaryDark
                    : AppColors.textSecondaryLight,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(AppSpacing.md),
      itemCount: state.bookmarks.length,
      separatorBuilder: (_, _) => AppSpacing.gapVerticalSm,
      itemBuilder: (context, index) {
        final bkmk = state.bookmarks[index];
        return Card(
          elevation: 0,
          color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
          shape: RoundedRectangleBorder(
            borderRadius: AppSpacing.borderRadiusMd,
            side: BorderSide(
              color: isDark ? AppColors.borderDark : AppColors.borderLight,
            ),
          ),
          child: Padding(
            padding: AppSpacing.paddingMd,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.bookmark,
                      size: 16,
                      color: AppColors.accent,
                    ),
                    AppSpacing.gapHorizontalXs,
                    Expanded(
                      child: Text(
                        bkmk.stepTitle,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: isDark
                              ? AppColors.textPrimaryDark
                              : AppColors.textPrimaryLight,
                        ),
                      ),
                    ),
                  ],
                ),
                AppSpacing.gapVerticalXxs,
                Text(
                  bkmk.guideName,
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark
                        ? AppColors.textSecondaryDark
                        : AppColors.textSecondaryLight,
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
