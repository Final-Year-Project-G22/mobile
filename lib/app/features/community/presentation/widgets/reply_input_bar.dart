import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/l10n/generated/app_localizations.dart';
import '../../../../../shared/widgets/adisu_progress_indicator.dart';
import '../../../../constants/app_spacing.dart';
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

  Future<void> _showAttachmentPicker(AppLocalizations l10n) async {
    await showModalBottomSheet<void>(
      context: context,
      builder: (ctx) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.image),
              title: Text(l10n.addImages),
              onTap: () async {
                Navigator.of(ctx).pop();
                await _pickImages();
              },
            ),
            ListTile(
              leading: const Icon(Icons.insert_drive_file),
              title: Text(l10n.addFiles),
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
    final l10n = AppLocalizations.of(context);
    setState(() => _isUploading = true);
    try {
      final result = await ref
          .read(communityMutationsProvider.notifier)
          .uploadAttachments(files);

      result.fold(
        (failure) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(l10n.failedWithError('$failure'))),
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

  Future<void> _submit() async {
    final l10n = AppLocalizations.of(context);
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
              SnackBar(content: Text(l10n.failedWithError('$failure'))),
            );
          },
          (_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(l10n.postUpdated)),
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
              SnackBar(content: Text(l10n.failedWithError('$failure'))),
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
              SnackBar(content: Text(l10n.failedWithError('$failure'))),
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
          SnackBar(content: Text(l10n.failedWithError('$e'))),
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
    final l10n = AppLocalizations.of(context);
    final isEditing = widget.editTarget != null;
    final isReplying = widget.replyTarget != null;
    final existingAttachments = widget.editTarget?.attachments;
    final showExistingAttachments =
        isEditing &&
        existingAttachments != null &&
        existingAttachments.isNotEmpty;

    final replyToName =
        widget.replyTarget?.authorDisplayName ??
        widget.replyTarget?.authorUsername ??
        (widget.replyTarget != null
            ? 'User ${widget.replyTarget!.authorId.length >= 6 ? widget.replyTarget!.authorId.substring(0, 6) : widget.replyTarget!.authorId}'
            : '');

    final modeLabel = isEditing
        ? l10n.editingPost
        : isReplying
        ? l10n.replyingTo(replyToName)
        : l10n.newPost;

    final hintText = isEditing
        ? l10n.updateYourPost
        : isReplying
        ? l10n.writeYourReply
        : l10n.writeAPost;

    final buttonLabel = isEditing
        ? l10n.edit
        : isReplying
        ? l10n.reply
        : l10n.post;

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xs,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border(
          top: BorderSide(color: colorScheme.outlineVariant),
        ),
      ),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isEditing || isReplying)
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: AppSpacing.xs),
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: AppSpacing.xs,
                ),
                decoration: BoxDecoration(
                  borderRadius: AppSpacing.borderRadiusSm,
                  color: colorScheme.surfaceContainerHighest,
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
                      tooltip: 'Cancel reply',
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
                margin: const EdgeInsets.only(bottom: AppSpacing.xs),
                padding: const EdgeInsets.all(AppSpacing.xs),
                decoration: BoxDecoration(
                  borderRadius: AppSpacing.borderRadiusSm,
                  color: colorScheme.surfaceContainerHighest,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.newAttachments(_attachments.length),
                      style: theme.textTheme.bodySmall,
                    ),
                    const SizedBox(height: AppSpacing.xxs),
                    for (var i = 0; i < _attachments.length; i++)
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: AppSpacing.xxs,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              _getFileIcon(_attachments[i].fileName),
                              size: 16,
                              color: colorScheme.primary,
                            ),
                            const SizedBox(width: AppSpacing.xs),
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
                              tooltip: 'Remove attachment',
                              onPressed: () => _removeAttachment(i),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(
                                minWidth: 48,
                                minHeight: 48,
                              ),
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
                margin: const EdgeInsets.only(bottom: AppSpacing.xs),
                padding: const EdgeInsets.all(AppSpacing.xs),
                decoration: BoxDecoration(
                  borderRadius: AppSpacing.borderRadiusSm,
                  color: colorScheme.surfaceContainerHighest,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.existingAttachments(existingAttachments.length),
                      style: theme.textTheme.bodySmall,
                    ),
                    const SizedBox(height: AppSpacing.xxs),
                    for (var i = 0; i < existingAttachments.length; i++)
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: AppSpacing.xxs,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              _getFileIcon(existingAttachments[i].fileName),
                              size: 16,
                              color:
                                  _removeAttachmentIds.contains(
                                    existingAttachments[i].id,
                                  )
                                  ? colorScheme.onSurfaceVariant
                                  : colorScheme.primary,
                            ),
                            const SizedBox(width: AppSpacing.xs),
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
                              constraints: const BoxConstraints(
                                minWidth: 48,
                                minHeight: 48,
                              ),
                              tooltip:
                                  _removeAttachmentIds.contains(
                                    existingAttachments[i].id,
                                  )
                                  ? l10n.undoRemove
                                  : l10n.removeThisAttachment,
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
                        child: Text(l10n.removeAll),
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
                        child: Text(l10n.removeAll),
                      ),
                  ],
                ),
              ),

            if (_removeExistingAttachments)
              Container(
                margin: const EdgeInsets.only(bottom: AppSpacing.xs),
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: AppSpacing.xs,
                ),
                decoration: BoxDecoration(
                  borderRadius: AppSpacing.borderRadiusSm,
                  color: colorScheme.tertiaryContainer,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(l10n.attachmentsRemovedOnUpdate),
                    ),
                    TextButton(
                      onPressed: (_isSubmitting || _isUploading)
                          ? null
                          : () => setState(
                              () => _removeExistingAttachments = false,
                            ),
                      child: Text(l10n.undoRemove),
                    ),
                  ],
                ),
              ),

            Row(
              children: [
                IconButton(
                  icon: _isUploading
                      ? const AdisuProgressIndicator.small()
                      : const Icon(Icons.attach_file),
                  tooltip: 'Add attachment',
                  style: IconButton.styleFrom(
                    minimumSize: const Size(48, 48),
                  ),
                  onPressed: (_isSubmitting || _isUploading)
                      ? null
                      : () => _showAttachmentPicker(l10n),
                ),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    enabled: !_isSubmitting,
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: hintText,
                      filled: true,
                      fillColor: colorScheme.surfaceContainerHigh,
                      border: OutlineInputBorder(
                        borderRadius: AppSpacing.borderRadiusMd,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                        vertical: AppSpacing.xs,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.xs),
                if (_isSubmitting)
                  const Padding(
                    padding: EdgeInsets.all(12),
                    child: AdisuProgressIndicator.small(),
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
