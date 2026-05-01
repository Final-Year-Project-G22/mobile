import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../application/providers/community_mutations_provider.dart';
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

  File? _selectedAttachment;
  String? _selectedAttachmentName;
  bool _isSubmitting = false;
  bool _removeExistingAttachment = false;

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
      _selectedAttachment = null;
      _selectedAttachmentName = null;
      _removeExistingAttachment = false;
    } else {
      _controller.clear();
      _selectedAttachment = null;
      _selectedAttachmentName = null;
      _removeExistingAttachment = false;
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
              title: const Text('Choose image'),
              onTap: () async {
                Navigator.of(ctx).pop();
                await _pickImage();
              },
            ),
            ListTile(
              leading: const Icon(Icons.insert_drive_file),
              title: const Text('Choose file'),
              onTap: () async {
                Navigator.of(ctx).pop();
                await _pickFile();
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked == null || !mounted) {
      return;
    }
    setState(() {
      _selectedAttachment = File(picked.path);
      _selectedAttachmentName = picked.name;
      _removeExistingAttachment = false;
    });
  }

  Future<void> _pickFile() async {
    final result = await FilePicker.pickFiles();
    if (result == null || result.files.isEmpty || !mounted) {
      return;
    }

    final picked = result.files.first;
    if (picked.path == null) {
      return;
    }

    setState(() {
      _selectedAttachment = File(picked.path!);
      _selectedAttachmentName = picked.name;
      _removeExistingAttachment = false;
    });
  }

  Future<void> _submit() async {
    final content = _controller.text.trim();
    final editTarget = widget.editTarget;
    final replyTarget = widget.replyTarget;

    final canSubmit = content.isNotEmpty || _selectedAttachment != null;
    if (!canSubmit) {
      return;
    }

    setState(() => _isSubmitting = true);

    if (editTarget != null) {
      final result = await ref
          .read(communityMutationsProvider.notifier)
          .updatePost(
            editTarget.id,
            widget.threadId,
            content: content,
            removeAttachment: _removeExistingAttachment,
            attachment: _selectedAttachment,
          );

      if (!mounted) {
        return;
      }

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
            _selectedAttachment = null;
            _selectedAttachmentName = null;
            _removeExistingAttachment = false;
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
            content: content,
            attachment: _selectedAttachment,
          );

      if (!mounted) {
        return;
      }

      result.fold(
        (failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to reply: $failure')),
          );
        },
        (_) {
          _controller.clear();
          setState(() {
            _selectedAttachment = null;
            _selectedAttachmentName = null;
          });
          widget.onClearMode();
        },
      );
    } else {
      final result = await ref
          .read(communityMutationsProvider.notifier)
          .createPost(
            threadId: widget.threadId,
            content: content,
            attachment: _selectedAttachment,
          );

      if (!mounted) {
        return;
      }

      result.fold(
        (failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to post: $failure')),
          );
        },
        (_) {
          _controller.clear();
          setState(() {
            _selectedAttachment = null;
            _selectedAttachmentName = null;
          });
        },
      );
    }

    if (mounted) {
      setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.editTarget != null;
    final isReplying = widget.replyTarget != null;
    final existingAttachmentUrl = widget.editTarget?.attachmentUrl;
    final showExistingAttachment =
        isEditing &&
        existingAttachmentUrl != null &&
        existingAttachmentUrl.isNotEmpty;

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
                      onPressed: _isSubmitting ? null : widget.onClearMode,
                    ),
                  ],
                ),
              ),
            if (_selectedAttachment != null)
              Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                ),
                child: Row(
                  children: [
                    const Icon(Icons.attach_file),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _selectedAttachmentName ?? 'Attachment selected',
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, size: 18),
                      onPressed: () {
                        setState(() {
                          _selectedAttachment = null;
                          _selectedAttachmentName = null;
                        });
                      },
                    ),
                  ],
                ),
              ),
            if (showExistingAttachment && _selectedAttachment == null)
              Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                ),
                child: Row(
                  children: [
                    const Icon(Icons.attach_file),
                    const SizedBox(width: 8),
                    const Expanded(child: Text('Existing attachment')),
                    TextButton(
                      onPressed: _isSubmitting
                          ? null
                          : () => setState(
                              () => _removeExistingAttachment = true,
                            ),
                      child: const Text('Remove'),
                    ),
                  ],
                ),
              ),
            if (_removeExistingAttachment)
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
                      child: Text('Attachment will be removed on update'),
                    ),
                    TextButton(
                      onPressed: _isSubmitting
                          ? null
                          : () => setState(
                              () => _removeExistingAttachment = false,
                            ),
                      child: const Text('Undo'),
                    ),
                  ],
                ),
              ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.attach_file),
                  onPressed: _isSubmitting ? null : _showAttachmentPicker,
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
}
