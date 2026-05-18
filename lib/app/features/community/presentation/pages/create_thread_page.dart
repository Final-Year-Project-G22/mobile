import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/l10n/generated/app_localizations.dart';
import '../../../../../shared/widgets/adisu_progress_indicator.dart';
import '../../application/providers/community_mutations_provider.dart';
import '../../domain/entities/attachment.dart';
import '../widgets/taxonomy_chip_selector.dart';

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
      final result = await ref.read(communityMutationsProvider.notifier).uploadAttachments(files);

      result.fold(
        (failure) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Failed to upload: $failure')),
            );
          }
        },
        (attachments) {
          setState(() {
            _attachments.addAll(attachments);
          });
        },
      );
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
    if (_formKey.currentState == null) {
      return;
    }
    final isValid = _formKey.currentState!.validate();
    if (!isValid) return;

    setState(() => _isSubmitting = true);

    try {
      final title = _titleController.text.trim();
      final initialPost = _initialPostController.text;

      final attachmentIds = _attachments.isNotEmpty ? _attachments.map((a) => a.id).join(',') : null;
      final sectorIds = _selectedSectorIds.isNotEmpty ? _selectedSectorIds.toList() : null;
      final tagIds = _selectedTagIds.isNotEmpty ? _selectedTagIds.toList() : null;

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

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.createThread),
        actions: [
          TextButton(
            onPressed: (_isSubmitting || _isUploading) ? null : _submit,
            child: _isSubmitting ? const AdisuProgressIndicator.small() : Text(l10n.post),
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
              validator: (v) => (v?.trim().isEmpty ?? true) ? l10n.postRequired : null,
            ),

            const SizedBox(height: 16),

            TaxonomyChipSelector(
              selectedSectorIds: _selectedSectorIds,
              selectedTagIds: _selectedTagIds,
              onToggleSector: _toggleSector,
              onToggleTag: _toggleTag,
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: (_isSubmitting || _isUploading) ? null : _pickImage,
                    icon: _isUploading ? const AdisuProgressIndicator.small() : const Icon(Icons.image),
                    label: Text(l10n.addImages),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: (_isSubmitting || _isUploading) ? null : _pickFile,
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
                        constraints: const BoxConstraints(
                          minWidth: 48,
                          minHeight: 48,
                        ),
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

}
