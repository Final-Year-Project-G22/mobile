import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/l10n/generated/app_localizations.dart';
import '../../../../../shared/widgets/adisu_progress_indicator.dart';
import '../../application/providers/community_mutations_provider.dart';
import '../../domain/entities/discussion_thread.dart';
import '../widgets/taxonomy_chip_selector.dart';

class EditThreadPage extends ConsumerStatefulWidget {
  const EditThreadPage({
    required this.thread,
    super.key,
  });

  final DiscussionThread thread;

  @override
  ConsumerState<EditThreadPage> createState() => _EditThreadPageState();
}

class _EditThreadPageState extends ConsumerState<EditThreadPage> {
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
      final sectorIds = _selectedSectorIds.isNotEmpty ? _selectedSectorIds.toList() : null;
      final tagIds = _selectedTagIds.isNotEmpty ? _selectedTagIds.toList() : null;

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

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.editThread),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _titleController,
                enabled: !_isSubmitting,
                decoration: InputDecoration(
                  labelText: l10n.title,
                  border: const OutlineInputBorder(),
                ),
                validator: (v) {
                  final t = v?.trim() ?? '';
                  if (t.isEmpty) return l10n.titleRequired;
                  if (t.length < 5) return l10n.minChars(5);
                  return null;
                },
              ),

              const SizedBox(height: 16),

              TaxonomyChipSelector(
                selectedSectorIds: _selectedSectorIds,
                selectedTagIds: _selectedTagIds,
                onToggleSector: _toggleSector,
                onToggleTag: _toggleTag,
              ),

              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _isSubmitting ? null : _submit,
                  child: _isSubmitting ? const AdisuProgressIndicator.small() : Text(l10n.save),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
