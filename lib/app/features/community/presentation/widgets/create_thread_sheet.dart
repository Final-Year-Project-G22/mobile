import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../application/providers/community_mutations_provider.dart';
import '../../domain/entities/attachment.dart';

class CreateThreadSheet extends ConsumerStatefulWidget {
  const CreateThreadSheet({super.key});

  @override
  ConsumerState<CreateThreadSheet> createState() => _CreateThreadSheetState();
}

class _CreateThreadSheetState extends ConsumerState<CreateThreadSheet> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _initialPostController = TextEditingController();

  final List<Attachment> _attachments = [];
  bool _isSubmitting = false;
  bool _isUploading = false;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
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
      withData: true, // Get bytes directly for web
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

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);

    try {
      final title = _titleController.text.trim();
      final description = _descriptionController.text.trim();
      final initialPost = _initialPostController.text.trim();

      final attachmentIds = _attachments.isNotEmpty
          ? _attachments.map((a) => a.id).join(',')
          : null;

      debugPrint('Submitting thread with attachmentIds: $attachmentIds');

      final result = await ref
          .read(communityMutationsProvider.notifier)
          .createThread(
            title: title,
            slug: _buildSlug(title),
            description: description,
            initialPostContent: initialPost,
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
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.fromLTRB(16, 16, 16, bottomInset + 16),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Create Thread',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),

              // Title
              TextFormField(
                controller: _titleController,
                enabled: !_isSubmitting,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
                validator: (v) {
                  final t = v?.trim() ?? '';
                  if (t.isEmpty) return 'Title required';
                  if (t.length < 5) return 'Min 5 chars';
                  return null;
                },
              ),

              const SizedBox(height: 12),

              // Description
              TextFormField(
                controller: _descriptionController,
                enabled: !_isSubmitting,
                minLines: 2,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Thread Summary',
                  border: OutlineInputBorder(),
                ),
                validator: (v) =>
                    (v?.trim().isEmpty ?? true) ? 'Summary required' : null,
              ),

              const SizedBox(height: 12),

              // Initial post
              TextFormField(
                controller: _initialPostController,
                enabled: !_isSubmitting,
                minLines: 4,
                maxLines: 6,
                decoration: const InputDecoration(
                  labelText: 'Initial Post',
                  border: OutlineInputBorder(),
                ),
                validator: (v) =>
                    (v?.trim().isEmpty ?? true) ? 'Post required' : null,
              ),

              const SizedBox(height: 12),

              // Attachment buttons
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
                      label: const Text('Add Images'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: (_isSubmitting || _isUploading)
                          ? null
                          : _pickFile,
                      icon: const Icon(Icons.attach_file),
                      label: const Text('Add Files'),
                    ),
                  ),
                ],
              ),

              // Uploaded attachments list
              if (_attachments.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  'Attachments (${_attachments.length}):',
                  style: Theme.of(context).textTheme.bodySmall,
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
                      color: Theme.of(context)
                          .colorScheme
                          .surfaceContainerHighest
                          .withValues(alpha: 0.5),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          _getFileIcon(att.fileName),
                          size: 20,
                          color: Theme.of(context).colorScheme.primary,
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
                                style: Theme.of(context).textTheme.bodySmall,
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

              const SizedBox(height: 16),

              // Submit button
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: (_isSubmitting || _isUploading) ? null : _submit,
                  child: _isSubmitting
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text('Post Thread'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
