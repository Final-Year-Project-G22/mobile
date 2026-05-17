import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/l10n/generated/app_localizations.dart';
import '../../../taxonomy/application/providers/taxonomy_providers.dart';
import '../../../taxonomy/domain/entities/sector.dart';
import '../../../taxonomy/domain/entities/tag.dart';
import '../../application/providers/community_mutations_provider.dart';
import '../../domain/entities/attachment.dart';

class CreateThreadPage extends ConsumerStatefulWidget {
  const CreateThreadPage({super.key});

  @override
  ConsumerState<CreateThreadPage> createState() => _CreateThreadPageState();
}

class _CreateThreadPageState extends ConsumerState<CreateThreadPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _initialPostController = TextEditingController();

  final List<Attachment> _attachments = [];
  final Set<String> _selectedSectorIds = {};
  final Set<String> _selectedTagIds = {};
  bool _isSubmitting = false;
  bool _isUploading = false;

  @override
  void dispose() {
    _titleController.dispose();
    _initialPostController.dispose();
    super.dispose();
  }

  String _buildSlug(String title) {
    final normalized = title
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9\s-]'), '')
        .trim()
        .replaceAll(RegExp(r'\s+'), '-');
    return '$normalized-${DateTime.now().millisecondsSinceEpoch}';
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickMultiImage();
    if (picked.isNotEmpty && mounted) {
      unawaited(_uploadFiles(picked));
    }
  }

  Future<void> _pickFile() async {
    final result = await FilePicker.pickFiles(
      allowMultiple: true,
      withData: true,
    );
    if (result != null && result.files.isNotEmpty && mounted) {
      final files = <XFile>[];
      for (final file in result.files) {
        if (file.bytes != null && file.bytes!.isNotEmpty) {
          files.add(
            XFile.fromData(
              file.bytes!,
              name: file.name,
            ),
          );
        } else if (file.path != null) {
          files.add(XFile(file.path!));
        }
      }
      if (files.isNotEmpty) {
        unawaited(_uploadFiles(files));
      }
    }
  }

  Future<void> _uploadFiles(List<XFile> files) async {
    setState(() => _isUploading = true);
    try {
      debugPrint('Uploading ${files.length} files...');
      final result = await ref
          .read(communityMutationsProvider.notifier)
          .uploadAttachments(files);

      result.fold(
        (failure) {
          debugPrint('Upload failed: $failure');
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Failed to upload: $failure')),
            );
          }
        },
        (attachments) {
          debugPrint('Upload success: ${attachments.length} files');
          setState(() {
            _attachments.addAll(attachments);
          });
        },
      );
    } on Exception catch (e) {
      debugPrint('Upload error: $e');
    } finally {
      if (mounted) setState(() => _isUploading = false);
    }
  }

  void _removeAttachment(int index) {
    setState(() => _attachments.removeAt(index));
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
    debugPrint('Submit tapped. Validating form...');
    if (_formKey.currentState == null) {
      debugPrint('Form key currentState is null!');
      return;
    }
    final isValid = _formKey.currentState!.validate();
    debugPrint('Form validation result: $isValid');
    if (!isValid) return;

    setState(() => _isSubmitting = true);

    try {
      final title = _titleController.text.trim();
      final initialPost = _initialPostController.text;
      debugPrint('Title: $title, Post: $initialPost');

      final attachmentIds = _attachments.isNotEmpty
          ? _attachments.map((a) => a.id).join(',')
          : null;
      final sectorIds = _selectedSectorIds.isNotEmpty
          ? _selectedSectorIds.toList()
          : null;
      final tagIds = _selectedTagIds.isNotEmpty
          ? _selectedTagIds.toList()
          : null;

      debugPrint(
        'Submitting thread with sectorIds: $sectorIds, tagIds: $tagIds, attachmentIds: $attachmentIds',
      );

      final result = await ref
          .read(communityMutationsProvider.notifier)
          .createThread(
            title: title,
            slug: _buildSlug(title),
            description: '',
            initialPostContent: initialPost,
            sectorIds: sectorIds,
            tagIds: tagIds,
            attachmentIds: attachmentIds,
          );

      if (!mounted) return;

      result.fold(
        (failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed: $failure')),
          );
        },
        (threadId) {
          Navigator.of(context).pop(threadId);
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

  IconData _getFileIcon(String filename) {
    final ext = filename.split('.').last.toLowerCase();
    if (['jpg', 'jpeg', 'png', 'gif', 'webp'].contains(ext)) {
      return Icons.image;
    } else if (ext == 'pdf') {
      return Icons.picture_as_pdf;
    } else if (['doc', 'docx'].contains(ext)) {
      return Icons.description;
    }
    return Icons.insert_drive_file;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final sectorsAsync = ref.watch(sectorsProvider);
    final tagsAsync = ref.watch(tagsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.createThread),
        actions: [
          TextButton(
            onPressed: (_isSubmitting || _isUploading) ? null : _submit,
            child: _isSubmitting
                ? SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: theme.colorScheme.onPrimary,
                    ),
                  )
                : Text(l10n.post),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
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

            const SizedBox(height: 12),

            TextFormField(
              controller: _initialPostController,
              enabled: !_isSubmitting,
              minLines: 4,
              maxLines: 6,
              decoration: InputDecoration(
                labelText: l10n.initialPost,
                border: const OutlineInputBorder(),
              ),
              validator: (v) =>
                  (v?.trim().isEmpty ?? true) ? l10n.postRequired : null,
            ),

            const SizedBox(height: 16),

            sectorsAsync.when(
              data: (sectors) => _buildSectorChips(sectors, l10n),
              loading: () => const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (e, s) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  'Failed to load sectors: $e',
                  style: TextStyle(color: theme.colorScheme.error),
                ),
              ),
            ),

            const SizedBox(height: 12),

            tagsAsync.when(
              data: (tags) => _buildTagChips(tags, l10n),
              loading: () => const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (e, s) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  'Failed to load tags: $e',
                  style: TextStyle(color: theme.colorScheme.error),
                ),
              ),
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: (_isSubmitting || _isUploading)
                        ? null
                        : _pickImage,
                    icon: _isUploading
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.image),
                    label: Text(l10n.addImages),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: (_isSubmitting || _isUploading)
                        ? null
                        : _pickFile,
                    icon: const Icon(Icons.attach_file),
                    label: Text(l10n.addFiles),
                  ),
                ),
              ],
            ),

            if (_attachments.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                'Attachments (${_attachments.length}):',
                style: theme.textTheme.bodySmall,
              ),
              const SizedBox(height: 4),
              ...List.generate(_attachments.length, (index) {
                final att = _attachments[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 4),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: theme.colorScheme.surfaceContainerHighest.withValues(
                      alpha: 0.5,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        _getFileIcon(att.fileName),
                        size: 20,
                        color: theme.colorScheme.primary,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              att.fileName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              '${(att.fileSize / 1024).toStringAsFixed(1)} KB',
                              style: theme.textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, size: 16),
                        onPressed: () => _removeAttachment(index),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                );
              }),
            ],

            const SizedBox(height: 32),
          ],
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
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
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
                  final isSelected = _selectedTagIds.contains(tag.id);
                  return FilterChip(
                    label: Text(tag.name),
                    selected: isSelected,
                    onSelected: (_) => _toggleTag(tag.id),
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
}
