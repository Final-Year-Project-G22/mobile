import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../application/providers/community_mutations_provider.dart';
import '../../domain/entities/attachment.dart';
import '../../domain/entities/discussion_post.dart';

class ReplyInputBar extends ConsumerStatefulWidget {
  const ReplyInputBar({
    required this.threadId,
    required this.replyTarget,
    required this.editTarget,
    required this.onClearMode,
    super.key,
  });

  final String threadId;
  final DiscussionPost? replyTarget;
  final DiscussionPost? editTarget;
  final VoidCallback onClearMode;

  @override
  ConsumerState<ReplyInputBar> createState() => _ReplyInputBarState();
}

class _ReplyInputBarState extends ConsumerState<ReplyInputBar> {
  final _controller = TextEditingController();

  final List<Attachment> _attachments = [];
  final List<String> _removeAttachmentIds = [];
  bool _isSubmitting = false;
  bool _isUploading = false;
  bool _removeExistingAttachments = false;

  @override
  void initState() {
    super.initState();
    _syncFromEditTarget();
  }

  @override
  void didUpdateWidget(covariant ReplyInputBar oldWidget) {
    super.didUpdateWidget(oldWidget);

    final oldId = oldWidget.editTarget?.id;
    final newId = widget.editTarget?.id;
    if (oldId != newId) {
      _syncFromEditTarget();
    }

    if (oldWidget.replyTarget?.id != widget.replyTarget?.id &&
        widget.editTarget == null &&
        _controller.text.trim().isEmpty) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _syncFromEditTarget() {
    final editTarget = widget.editTarget;
    if (editTarget != null) {
      _controller.text = editTarget.content;
      _attachments.clear();
      _removeAttachmentIds.clear();
      _removeExistingAttachments = false;
    } else {
      _controller.clear();
      _attachments.clear();
      _removeAttachmentIds.clear();
      _removeExistingAttachments = false;
    }
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _showAttachmentPicker() async {
    await showModalBottomSheet<void>(
      context: context,
      builder: (ctx) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.image),
              title: const Text('Choose images'),
              onTap: () async {
                Navigator.of(ctx).pop();
                await _pickImages();
              },
            ),
            ListTile(
              leading: const Icon(Icons.insert_drive_file),
              title: const Text('Choose files'),
              onTap: () async {
                Navigator.of(ctx).pop();
                await _pickFiles();
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImages() async {
    final picker = ImagePicker();
    final picked = await picker.pickMultiImage();
    if (picked.isNotEmpty && mounted) {
      await _uploadFiles(picked);
    }
  }

  Future<void> _pickFiles() async {
    final result = await FilePicker.pickFiles(
      allowMultiple: true,
      withData: true,
    );
    if (result == null || result.files.isEmpty || !mounted) return;

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
    final rawContent = _controller.text;
    final editTarget = widget.editTarget;
    final replyTarget = widget.replyTarget;

    final canSubmit = rawContent.trim().isNotEmpty || _attachments.isNotEmpty;
    if (!canSubmit) return;

    setState(() => _isSubmitting = true);

    try {
      final attachmentIds = _attachments.isNotEmpty
          ? _attachments.map((a) => a.id).join(',')
          : null;

      if (editTarget != null) {
        final result = await ref
            .read(communityMutationsProvider.notifier)
            .updatePost(
              editTarget.id,
              widget.threadId,
              content: rawContent,
              attachmentIds: attachmentIds,
              removeAllAttachments: _removeExistingAttachments,
              removeAttachmentIds: _removeAttachmentIds.isNotEmpty
                  ? _removeAttachmentIds.join(',')
                  : null,
            );

        if (!mounted) return;

        result.fold(
          (failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Failed to update post: $failure')),
            );
          },
          (_) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Post updated successfully')),
            );
            _controller.clear();
            setState(() {
              _attachments.clear();
              _removeAttachmentIds.clear();
              _removeExistingAttachments = false;
            });
            widget.onClearMode();
          },
        );
      } else if (replyTarget != null) {
        final result = await ref
            .read(communityMutationsProvider.notifier)
            .replyToPost(
              threadId: widget.threadId,
              postId: replyTarget.id,
              content: rawContent,
              attachmentIds: attachmentIds,
            );

        if (!mounted) return;

        result.fold(
          (failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Failed to reply: $failure')),
            );
          },
          (_) {
            _controller.clear();
            setState(_attachments.clear);
            widget.onClearMode();
          },
        );
      } else {
        final result = await ref
            .read(communityMutationsProvider.notifier)
            .createPost(
              threadId: widget.threadId,
              content: rawContent,
              attachmentIds: attachmentIds,
            );

        if (!mounted) return;

        result.fold(
          (failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Failed to post: $failure')),
            );
          },
          (_) {
            _controller.clear();
            setState(_attachments.clear);
            widget.onClearMode();
          },
        );
      }
    } on Exception catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.editTarget != null;
    final isReplying = widget.replyTarget != null;
    final existingAttachments = widget.editTarget?.attachments;
    final showExistingAttachments =
        isEditing &&
        existingAttachments != null &&
        existingAttachments.isNotEmpty;

    final modeLabel = isEditing
        ? 'Editing post'
        : isReplying
        ? 'Replying to ${widget.replyTarget!.authorDisplayName ?? widget.replyTarget!.authorUsername ?? 'User ${widget.replyTarget!.authorId.length >= 6 ? widget.replyTarget!.authorId.substring(0, 6) : widget.replyTarget!.authorId}'}'
        : 'New post';

    final hintText = isEditing
        ? 'Update your post...'
        : isReplying
        ? 'Write your reply...'
        : 'Write a post...';

    final buttonLabel = isEditing
        ? 'Update'
        : isReplying
        ? 'Reply'
        : 'Post';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isEditing || isReplying)
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        modeLabel,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, size: 18),
                      onPressed: (_isSubmitting || _isUploading)
                          ? null
                          : widget.onClearMode,
                    ),
                  ],
                ),
              ),

            // Uploaded NEW attachments preview (always show if any)
            if (_attachments.isNotEmpty)
              Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'New attachments (${_attachments.length}):',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 4),
                    for (var i = 0; i < _attachments.length; i++)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Row(
                          children: [
                            Icon(
                              _getFileIcon(_attachments[i].fileName),
                              size: 16,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _attachments[i].fileName,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    '${(_attachments[i].fileSize / 1024).toStringAsFixed(1)} KB',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodySmall,
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.close, size: 16),
                              onPressed: () => _removeAttachment(i),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),

            // Existing attachments (when editing - ALWAYS show if has existing)
            if (showExistingAttachments)
              Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Existing attachments (${existingAttachments.length}):',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 4),
                    for (var i = 0; i < existingAttachments.length; i++)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Row(
                          children: [
                            Icon(
                              _getFileIcon(existingAttachments[i].fileName),
                              size: 16,
                              color:
                                  _removeAttachmentIds.contains(
                                    existingAttachments[i].id,
                                  )
                                  ? Colors.grey
                                  : Theme.of(context).colorScheme.primary,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                existingAttachments[i].fileName,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style:
                                    _removeAttachmentIds.contains(
                                      existingAttachments[i].id,
                                    )
                                    ? const TextStyle(
                                        decoration: TextDecoration.lineThrough,
                                      )
                                    : null,
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                _removeAttachmentIds.contains(
                                      existingAttachments[i].id,
                                    )
                                    ? Icons.undo
                                    : Icons.close,
                                size: 16,
                              ),
                              onPressed: (_isSubmitting || _isUploading)
                                  ? null
                                  : () {
                                      setState(() {
                                        final id = existingAttachments[i].id;
                                        if (_removeAttachmentIds.contains(id)) {
                                          _removeAttachmentIds.remove(id);
                                        } else {
                                          _removeAttachmentIds.add(id);
                                        }
                                      });
                                    },
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              tooltip:
                                  _removeAttachmentIds.contains(
                                    existingAttachments[i].id,
                                  )
                                  ? 'Undo remove'
                                  : 'Remove this attachment',
                            ),
                          ],
                        ),
                      ),
                    if (_removeAttachmentIds.isNotEmpty)
                      TextButton(
                        onPressed: (_isSubmitting || _isUploading)
                            ? null
                            : () => setState(
                                () => _removeExistingAttachments = true,
                              ),
                        child: const Text('Remove all'),
                      )
                    else
                      TextButton(
                        onPressed: (_isSubmitting || _isUploading)
                            ? null
                            : () {
                                setState(() {
                                  _removeAttachmentIds.addAll(
                                    existingAttachments.map((a) => a.id),
                                  );
                                });
                              },
                        child: const Text('Remove all'),
                      ),
                  ],
                ),
              ),

            if (_removeExistingAttachments)
              Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.orange.withValues(alpha: 0.1),
                ),
                child: Row(
                  children: [
                    const Expanded(
                      child: Text('Attachments will be removed on update'),
                    ),
                    TextButton(
                      onPressed: (_isSubmitting || _isUploading)
                          ? null
                          : () => setState(
                              () => _removeExistingAttachments = false,
                            ),
                      child: const Text('Undo'),
                    ),
                  ],
                ),
              ),

            Row(
              children: [
                IconButton(
                  icon: _isUploading
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.attach_file),
                  onPressed: (_isSubmitting || _isUploading)
                      ? null
                      : _showAttachmentPicker,
                ),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    enabled: !_isSubmitting,
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: hintText,
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                if (_isSubmitting)
                  const Padding(
                    padding: EdgeInsets.all(12),
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  )
                else
                  TextButton.icon(
                    onPressed: _submit,
                    icon: const Icon(Icons.send),
                    label: Text(buttonLabel),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
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
}
