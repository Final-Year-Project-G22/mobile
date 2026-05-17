import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/l10n/generated/app_localizations.dart';
import '../../../../constants/app_spacing.dart';
import '../../../taxonomy/application/providers/taxonomy_providers.dart';
import '../../../taxonomy/domain/entities/sector.dart';
import '../../../taxonomy/domain/entities/tag.dart';
import '../../application/providers/community_mutations_provider.dart';
import '../../domain/entities/discussion_thread.dart';

class EditThreadSheet extends ConsumerStatefulWidget {
  const EditThreadSheet({
    required this.thread,
    super.key,
  });

  final DiscussionThread thread;

  @override
  ConsumerState<EditThreadSheet> createState() => _EditThreadSheetState();
}

class _EditThreadSheetState extends ConsumerState<EditThreadSheet> {
  late final TextEditingController _titleController;
  late final Set<String> _selectedSectorIds;
  late final Set<String> _selectedTagIds;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.thread.title);
    _selectedSectorIds = {...?widget.thread.sectorIds};
    _selectedTagIds = {...?widget.thread.tagIds};
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  void _toggleSector(String sectorId) {
    setState(() {
      if (_selectedSectorIds.contains(sectorId)) {
        _selectedSectorIds.remove(sectorId);
      } else {
        _selectedSectorIds.add(sectorId);
      }
    });
  }

  void _toggleTag(String tagId) {
    setState(() {
      if (_selectedTagIds.contains(tagId)) {
        _selectedTagIds.remove(tagId);
      } else {
        _selectedTagIds.add(tagId);
      }
    });
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);

    try {
      final title = _titleController.text.trim();
      final sectorIds = _selectedSectorIds.isNotEmpty
          ? _selectedSectorIds.toList()
          : null;
      final tagIds = _selectedTagIds.isNotEmpty
          ? _selectedTagIds.toList()
          : null;

      final result = await ref
          .read(communityMutationsProvider.notifier)
          .updateThread(
            threadId: widget.thread.id,
            title: title,
            description: '',
            sectorIds: sectorIds,
            tagIds: tagIds,
          );

      if (!mounted) return;

      result.fold(
        (failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed: $failure')),
          );
        },
        (_) {
          Navigator.of(context).pop(true);
        },
      );
    } on Exception catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final sectorsAsync = ref.watch(sectorsProvider);
    final tagsAsync = ref.watch(tagsProvider);

    return Padding(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.screenH,
        AppSpacing.md,
        AppSpacing.screenH,
        bottomInset + AppSpacing.md,
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.editThread,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: AppSpacing.md),

              TextFormField(
                controller: _titleController,
                enabled: !_isSubmitting,
                decoration: InputDecoration(
                  labelText: l10n.title,
                ),
                validator: (v) {
                  final t = v?.trim() ?? '';
                  if (t.isEmpty) return l10n.titleRequired;
                  if (t.length < 5) return l10n.minChars(5);
                  return null;
                },
              ),

              const SizedBox(height: AppSpacing.md),

              sectorsAsync.when(
                data: (sectors) => _buildSectorChips(sectors, l10n),
                loading: () => const Padding(
                  padding: EdgeInsets.symmetric(vertical: AppSpacing.xs),
                  child: Center(child: CircularProgressIndicator()),
                ),
                error: (e, s) => const SizedBox.shrink(),
              ),

              const SizedBox(height: AppSpacing.sm),

              tagsAsync.when(
                data: (tags) => _buildTagChips(tags, l10n),
                loading: () => const Padding(
                  padding: EdgeInsets.symmetric(vertical: AppSpacing.xs),
                  child: Center(child: CircularProgressIndicator()),
                ),
                error: (e, s) => const SizedBox.shrink(),
              ),

              const SizedBox(height: AppSpacing.md),

              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _isSubmitting ? null : _submit,
                  child: _isSubmitting
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        )
                      : Text(l10n.save),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectorChips(List<Sector> sectors, AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.sectorsOptional,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: AppSpacing.xs),
        Wrap(
          spacing: AppSpacing.xs,
          runSpacing: AppSpacing.xs,
          children: sectors.map((sector) {
            final isSelected = _selectedSectorIds.contains(sector.id);
            return FilterChip(
              label: Text(sector.name),
              selected: isSelected,
              onSelected: (_) => _toggleSector(sector.id),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildTagChips(List<Tag> tags, AppLocalizations l10n) {
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
        const SizedBox(height: AppSpacing.xs),
        ...grouped.entries.map((entry) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                entry.key,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: AppSpacing.xxs),
              Wrap(
                spacing: AppSpacing.xs,
                runSpacing: AppSpacing.xs,
                children: entry.value.map((tag) {
                  final isSelected = _selectedTagIds.contains(tag.id);
                  return FilterChip(
                    label: Text(tag.name),
                    selected: isSelected,
                    onSelected: (_) => _toggleTag(tag.id),
                  );
                }).toList(),
              ),
              const SizedBox(height: AppSpacing.xs),
            ],
          );
        }),
      ],
    );
  }
}
