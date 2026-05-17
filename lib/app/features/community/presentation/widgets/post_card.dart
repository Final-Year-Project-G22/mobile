import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gal/gal.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/l10n/generated/app_localizations.dart';
import '../../../../constants/app_spacing.dart';
import '../../domain/entities/attachment.dart';

class PostCard extends StatelessWidget {
  const PostCard({
    required this.authorId,
    required this.authorDisplayName,
    required this.content,
    this.upvoteCount,
    this.attachments,
    this.authorAvatarUrl,
    this.parentPreview,
    this.nestingLevel = 0,
    this.isEdited = false,
    this.isSolution = false,
    this.onReply,
    this.onEdit,
    this.onDelete,
    this.onReport,
    this.onReportUser,
    this.onParentPreviewTap,
    this.onMarkSolution,
    this.createdAt,
    super.key,
  });

  final String authorId;
  final String authorDisplayName;
  final String? authorAvatarUrl;
  final String content;
  final int? upvoteCount;
  final List<Attachment>? attachments;
  final String? parentPreview;
  final int nestingLevel;
  final bool isEdited;
  final bool isSolution;
  final VoidCallback? onReply;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onReport;
  final VoidCallback? onReportUser;
  final VoidCallback? onParentPreviewTap;
  final VoidCallback? onMarkSolution;
  final DateTime? createdAt;

  Future<void> _launchUrl(String urlString) async {
    final url = Uri.parse(urlString);
    if (!await launchUrl(url)) {
      debugPrint('Could not launch $urlString');
    }
  }

  bool _isImage(String? fileType) {
    return fileType != null && fileType.startsWith('image/');
  }

  IconData _getFileIcon(String? fileType, String fileName) {
    if (fileType != null && fileType.startsWith('image/')) {
      return Icons.image;
    }
    final ext = fileName.split('.').last.toLowerCase();
    if (['jpg', 'jpeg', 'png', 'gif', 'webp'].contains(ext)) {
      return Icons.image;
    } else if (fileType == 'application/pdf' || ext == 'pdf') {
      return Icons.picture_as_pdf;
    } else if (['doc', 'docx'].contains(ext)) {
      return Icons.description;
    } else if (['xls', 'xlsx'].contains(ext)) {
      return Icons.table_chart;
    } else if (['ppt', 'pptx'].contains(ext)) {
      return Icons.slideshow;
    } else if (['zip', 'rar', '7z'].contains(ext)) {
      return Icons.archive;
    } else if (ext == 'txt') {
      return Icons.text_snippet;
    }
    return Icons.insert_drive_file;
  }

  String _formatTime(DateTime? time, AppLocalizations l10n) {
    if (time == null) return '';

    final now = DateTime.now();
    final diff = now.difference(time);

    if (diff.inMinutes < 1) return l10n.justNow;
    if (diff.inMinutes < 60) return l10n.timeMinutesShort(diff.inMinutes);
    if (diff.inHours < 24) return l10n.timeHoursShort(diff.inHours);
    return l10n.timeDaysShort(diff.inDays);
  }

  Future<void> _downloadAndSaveImage(
    BuildContext context,
    String url,
    AppLocalizations l10n,
  ) async {
    try {
      final hasAccess = await Gal.hasAccess(toAlbum: true);
      if (!hasAccess) {
        final request = await Gal.requestAccess(toAlbum: true);
        if (!request) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Gallery permission denied')),
            );
          }
          return;
        }
      }

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Downloading image...')),
        );
      }

      final tempDir = await getTemporaryDirectory();
      final uri = Uri.parse(url);
      var filename = uri.pathSegments.last;
      if (filename.isEmpty || !filename.contains('.')) {
        filename = 'image_${DateTime.now().millisecondsSinceEpoch}.jpg';
      }
      final savePath = '${tempDir.path}/$filename';

      await Dio().download(url, savePath);
      await Gal.putImage(savePath);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.imageSaved)),
        );
      }
    } on Exception catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save image: $e')),
        );
      }
    }
  }

  Future<void> _showImageActionDialog(
    BuildContext context,
    String url,
    AppLocalizations l10n,
  ) async {
    await showModalBottomSheet<void>(
      context: context,
      builder: (ctx) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.download),
              title: Text(l10n.saveToGallery),
              onTap: () {
                Navigator.of(ctx).pop();
                unawaited(_downloadAndSaveImage(context, url, l10n));
              },
            ),
            if (onReply != null)
              ListTile(
                leading: const Icon(Icons.reply),
                title: Text(l10n.reply),
                onTap: () {
                  Navigator.of(ctx).pop();
                  onReply?.call();
                },
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final safeNesting = nestingLevel > 3 ? 3 : nestingLevel;
    final indentation = safeNesting * 12;

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: EdgeInsets.only(left: indentation.toDouble()),
      child: Card(
        margin: const EdgeInsets.symmetric(
          horizontal: AppSpacing.screenH,
          vertical: AppSpacing.xs,
        ),
        child: InkWell(
          borderRadius: AppSpacing.borderRadiusMd,
          onLongPress: onReply,
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onLongPress: onReportUser,
                      child: Tooltip(
                        message: onReportUser != null
                            ? 'Long-press to report user'
                            : '',
                        child: CircleAvatar(
                          backgroundImage:
                              authorAvatarUrl != null &&
                                  authorAvatarUrl!.isNotEmpty
                              ? NetworkImage(authorAvatarUrl!)
                              : null,
                          child:
                              (authorAvatarUrl == null ||
                                  authorAvatarUrl!.isEmpty)
                              ? const Icon(Icons.person)
                              : null,
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            authorDisplayName,
                            style: theme.textTheme.titleSmall,
                          ),
                          const SizedBox(height: AppSpacing.xxs),
                          Text(
                            _formatTime(createdAt, l10n),
                            style: theme.textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),

                    if (isSolution)
                      Container(
                        margin: const EdgeInsets.only(right: AppSpacing.xs),
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.xs,
                          vertical: AppSpacing.xxs,
                        ),
                        decoration: BoxDecoration(
                          color: colorScheme.tertiaryContainer,
                          borderRadius: AppSpacing.borderRadiusSm,
                          border: Border.all(color: colorScheme.tertiary),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: colorScheme.tertiary,
                              size: 14,
                            ),
                            const SizedBox(width: AppSpacing.xxs),
                            Text(
                              l10n.solved,
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: colorScheme.onTertiaryContainer,
                              ),
                            ),
                          ],
                        ),
                      ),
                    if (isEdited)
                      Text(
                        'edited',
                        style: theme.textTheme.bodySmall,
                      ),
                    if (onEdit != null ||
                        onDelete != null ||
                        onReport != null ||
                        onMarkSolution != null)
                      PopupMenuButton<String>(
                        onSelected: (value) {
                          if (value == 'edit') {
                            onEdit?.call();
                          } else if (value == 'delete') {
                            onDelete?.call();
                          } else if (value == 'reply') {
                            onReply?.call();
                          } else if (value == 'report') {
                            onReport?.call();
                          } else if (value == 'markSolution') {
                            onMarkSolution?.call();
                          }
                        },
                        itemBuilder: (context) => [
                          if (onReply != null)
                            PopupMenuItem(
                              value: 'reply',
                              child: Text(l10n.reply),
                            ),
                          if (onMarkSolution != null)
                            PopupMenuItem(
                              value: 'markSolution',
                              child: Text(
                                l10n.markAsSolution,
                                style: TextStyle(color: colorScheme.tertiary),
                              ),
                            ),
                          if (onEdit != null)
                            PopupMenuItem(
                              value: 'edit',
                              child: Text(l10n.edit),
                            ),
                          if (onDelete != null)
                            PopupMenuItem(
                              value: 'delete',
                              child: Text(
                                l10n.delete,
                                style: TextStyle(color: colorScheme.error),
                              ),
                            ),
                          if (onReport != null)
                            PopupMenuItem(
                              value: 'report',
                              child: Text(
                                l10n.report,
                                style: TextStyle(color: colorScheme.error),
                              ),
                            ),
                        ],
                      )
                    else if (onReply != null)
                      IconButton(
                        onPressed: onReply,
                        icon: const Icon(Icons.reply, size: 20),
                        tooltip: l10n.reply,
                      ),
                  ],
                ),
                if (parentPreview != null && parentPreview!.isNotEmpty) ...[
                  const SizedBox(height: AppSpacing.xs),
                  InkWell(
                    onTap: onParentPreviewTap,
                    borderRadius: AppSpacing.borderRadiusSm,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.sm,
                        vertical: AppSpacing.xs,
                      ),
                      decoration: BoxDecoration(
                        color: colorScheme.surfaceContainerHighest.withValues(
                          alpha: 0.4,
                        ),
                        borderRadius: AppSpacing.borderRadiusSm,
                        border: Border(
                          left: BorderSide(
                            color: colorScheme.primary,
                            width: 3,
                          ),
                        ),
                      ),
                      child: Text(
                        parentPreview!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodySmall,
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: AppSpacing.xs),
                Text(content),
                if (attachments != null && attachments!.isNotEmpty) ...[
                  const SizedBox(height: AppSpacing.xs),
                  ...attachments!.map((att) {
                    final isImage = _isImage(att.fileType);
                    return Container(
                      margin: const EdgeInsets.only(bottom: AppSpacing.xs),
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.sm,
                        vertical: AppSpacing.xs,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: AppSpacing.borderRadiusSm,
                        color: colorScheme.surfaceContainerHighest.withValues(
                          alpha: 0.5,
                        ),
                        border: Border.all(
                          color: colorScheme.outline.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                _getFileIcon(att.fileType, att.fileName),
                                color: colorScheme.primary,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      att.fileName,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      att.fileType,
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodySmall,
                                    ),
                                  ],
                                ),
                              ),
                              if (isImage)
                                IconButton(
                                  icon: const Icon(Icons.visibility, size: 20),
                                  onPressed: () => _showImageActionDialog(
                                    context,
                                    att.fileUrl,
                                    l10n,
                                  ),
                                  tooltip: l10n.saveToGallery,
                                )
                              else
                                IconButton(
                                  icon: const Icon(Icons.download, size: 20),
                                  onPressed: () => _launchUrl(att.fileUrl),
                                  tooltip: l10n.download,
                                ),
                            ],
                          ),
                          if (isImage) const SizedBox(height: AppSpacing.xs),
                          if (isImage)
                            GestureDetector(
                              onLongPress: () => unawaited(
                                _showImageActionDialog(
                                  context,
                                  att.fileUrl,
                                  l10n,
                                ),
                              ),
                              child: ConstrainedBox(
                                constraints: const BoxConstraints(
                                  maxHeight: 250,
                                  minWidth: double.infinity,
                                ),
                                child: ClipRRect(
                                  borderRadius: AppSpacing.borderRadiusSm,
                                  child: Image.network(
                                    att.fileUrl,
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            const Text('Failed to load image'),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    );
                  }),
                ],
                if (upvoteCount != null) ...[
                  const SizedBox(height: AppSpacing.xs),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.thumb_up_alt_outlined),
                        iconSize: 20,
                        onPressed: () {},
                      ),
                      Text('$upvoteCount'),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
