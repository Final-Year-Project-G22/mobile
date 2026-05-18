import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/l10n/generated/app_localizations.dart';
import '../../../../../shared/widgets/adisu_progress_indicator.dart';
import '../../../../../shared/widgets/styled_filter_chip.dart';
import '../../../taxonomy/application/providers/taxonomy_providers.dart';
import '../../../taxonomy/domain/entities/sector.dart';
import '../../../taxonomy/domain/entities/tag.dart';

class TaxonomyChipSelector extends ConsumerWidget {
  const TaxonomyChipSelector({
    required this.selectedSectorIds,
    required this.selectedTagIds,
    required this.onToggleSector,
    required this.onToggleTag,
    super.key,
  });

  final Set<String> selectedSectorIds;
  final Set<String> selectedTagIds;
  final ValueChanged<String> onToggleSector;
  final ValueChanged<String> onToggleTag;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final sectorsAsync = ref.watch(sectorsProvider);
    final tagsAsync = ref.watch(tagsProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sectorsAsync.when(
          data: (sectors) => _buildSectorChips(context, sectors, l10n),
          loading: () => const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Center(child: AdisuProgressIndicator.small()),
          ),
          error: (e, s) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              l10n.failedToLoadFilters,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        tagsAsync.when(
          data: (tags) => _buildTagChips(context, tags, l10n),
          loading: () => const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Center(child: AdisuProgressIndicator.small()),
          ),
          error: (e, s) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              l10n.failedToLoadFilters,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSectorChips(
    BuildContext context,
    List<Sector> sectors,
    AppLocalizations l10n,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.sectorsOptional,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: sectors.map((sector) {
            final isSelected = selectedSectorIds.contains(sector.id);
            return _buildChip(
              context,
              label: sector.name,
              isSelected: isSelected,
              onSelected: (_) => onToggleSector(sector.id),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildTagChips(
    BuildContext context,
    List<Tag> tags,
    AppLocalizations l10n,
  ) {
    final grouped = <String, List<Tag>>{};
    for (final tag in tags) {
      grouped.putIfAbsent(tag.group, () => []).add(tag);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.tagsOptional,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: 8),
        ...grouped.entries.map((entry) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                entry.key,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: entry.value.map((tag) {
                  final isSelected = selectedTagIds.contains(tag.id);
                  return _buildChip(
                    context,
                    label: tag.name,
                    isSelected: isSelected,
                    onSelected: (_) => onToggleTag(tag.id),
                  );
                }).toList(),
              ),
              const SizedBox(height: 8),
            ],
          );
        }),
      ],
    );
  }

  Widget _buildChip(
    BuildContext context, {
    required String label,
    required bool isSelected,
    required ValueChanged<bool> onSelected,
  }) {
    return StyledFilterChip(
      label: label,
      isSelected: isSelected,
      onSelected: onSelected,
    );
  }
}
