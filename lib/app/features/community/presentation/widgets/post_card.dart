import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gal/gal.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

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
    this.onReply,
    this.onEdit,
    this.onDelete,
    this.onReport,
    this.onReportUser,
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
  final VoidCallback? onReply;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onReport;
  final VoidCallback? onReportUser;
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

  String _formatTime(DateTime? time) {
    if (time == null) return '';

    final now = DateTime.now();
    final diff = now.difference(time);

    if (diff.inMinutes < 1) return 'just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m';
    if (diff.inHours < 24) return '${diff.inHours}h';
    return '${diff.inDays}d';
  }

  Future<void> _downloadAndSaveImage(BuildContext context, String url) async {
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
          const SnackBar(content: Text('Image saved to gallery!')),
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

  Future<void> _showImageActionDialog(BuildContext context, String url) async {
    await showModalBottomSheet<void>(
      context: context,
      builder: (ctx) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.download),
              title: const Text('Save to Gallery'),
              onTap: () {
                Navigator.of(ctx).pop();
                unawaited(_downloadAndSaveImage(context, url));
              },
            ),
            if (onReply != null)
              ListTile(
                leading: const Icon(Icons.reply),
                title: const Text('Reply'),
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
    final safeNesting = nestingLevel > 3 ? 3 : nestingLevel;
    final indentation = safeNesting * 12;

    return Padding(
      padding: EdgeInsets.only(left: indentation.toDouble()),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onLongPress: onReply,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onLongPress: onReportUser,
                      child: Tooltip(
                        message: onReportUser != null ? 'Long-press to report user' : '',
                        child: CircleAvatar(
                          backgroundImage: authorAvatarUrl != null && authorAvatarUrl!.isNotEmpty
                              ? NetworkImage(authorAvatarUrl!)
                              : null,
                          child: (authorAvatarUrl == null || authorAvatarUrl!.isEmpty) ? const Icon(Icons.person) : null,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            authorDisplayName,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            _formatTime(createdAt),
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),

                    if (isEdited)
                      Text(
                        'edited',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    if (onEdit != null || onDelete != null || onReport != null)
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
                          }
                        },
                        itemBuilder: (context) => [
                          if (onReply != null)
                            const PopupMenuItem(
                              value: 'reply',
                              child: Text('Reply'),
                            ),
                          if (onEdit != null)
                            const PopupMenuItem(
                              value: 'edit',
                              child: Text('Edit'),
                            ),
                          if (onDelete != null)
                            const PopupMenuItem(
                              value: 'delete',
                              child: Text(
                                'Delete',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          if (onReport != null)
                            const PopupMenuItem(
                              value: 'report',
                              child: Text(
                                'Report',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                        ],
                      )
                    else if (onReply != null)
                      IconButton(
                        onPressed: onReply,
                        icon: const Icon(Icons.reply, size: 20),
                        tooltip: 'Reply',
                      ),
                  ],
                ),
                if (parentPreview != null && parentPreview!.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.4),
                      borderRadius: BorderRadius.circular(8),
                      border: Border(
                        left: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                          width: 3,
                        ),
                      ),
                    ),
                    child: Text(
                      parentPreview!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ],
                const SizedBox(height: 8),
                Text(content),
                if (attachments != null && attachments!.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  ...attachments!.map((att) {
                    final isImage = _isImage(att.fileType);
                    return Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                        border: Border.all(
                          color: Theme.of(
                            context,
                          ).colorScheme.outline.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                _getFileIcon(att.fileType, att.fileName),
                                color: Theme.of(context).colorScheme.primary,
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
                                  ),
                                  tooltip: 'Save image',
                                )
                              else
                                IconButton(
                                  icon: const Icon(Icons.download, size: 20),
                                  onPressed: () => _launchUrl(att.fileUrl),
                                  tooltip: 'Download',
                                ),
                            ],
                          ),
                          if (isImage) const SizedBox(height: 8),
                          if (isImage)
                            GestureDetector(
                              onLongPress: () => unawaited(
                                _showImageActionDialog(context, att.fileUrl),
                              ),
                              child: ConstrainedBox(
                                constraints: const BoxConstraints(
                                  maxHeight: 250,
                                  minWidth: double.infinity,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    att.fileUrl,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) => const Text('Failed to load image'),
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
                  const SizedBox(height: 8),
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
