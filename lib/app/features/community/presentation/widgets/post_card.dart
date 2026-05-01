import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gal/gal.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class PostCard extends StatelessWidget {
  const PostCard({
    required this.authorId,
    required this.authorDisplayName,
    required this.content,
    this.upvoteCount,
    this.attachmentUrl,
    this.attachmentType,
    this.authorAvatarUrl,
    this.parentPreview,
    this.nestingLevel = 0,
    this.isEdited = false,
    this.onReply,
    this.onEdit,
    this.onDelete,
    super.key,
  });

  final String authorId;
  final String authorDisplayName;
  final String? authorAvatarUrl;
  final String content;
  final int? upvoteCount;
  final String? attachmentUrl;
  final String? attachmentType;
  final String? parentPreview;
  final int nestingLevel;
  final bool isEdited;
  final VoidCallback? onReply;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  Future<void> _launchUrl(String urlString) async {
    final url = Uri.parse(urlString);
    if (!await launchUrl(url)) {
      debugPrint('Could not launch $urlString');
    }
  }

  bool _isImage(String? url, String? type) {
    if (type != null && type.startsWith('image/')) {
      return true;
    }
    if (url == null) {
      return false;
    }
    final lower = url.toLowerCase();
    return lower.endsWith('.jpg') ||
        lower.endsWith('.jpeg') ||
        lower.endsWith('.png') ||
        lower.endsWith('.gif') ||
        lower.endsWith('.webp');
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
                    CircleAvatar(
                      backgroundImage:
                          authorAvatarUrl != null && authorAvatarUrl!.isNotEmpty
                          ? NetworkImage(authorAvatarUrl!)
                          : null,
                      child:
                          (authorAvatarUrl == null || authorAvatarUrl!.isEmpty)
                          ? const Icon(Icons.person)
                          : null,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        authorDisplayName,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    if (isEdited)
                      Text(
                        'edited',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    if (onEdit != null || onDelete != null)
                      PopupMenuButton<String>(
                        onSelected: (value) {
                          if (value == 'edit') {
                            onEdit?.call();
                          } else if (value == 'delete') {
                            onDelete?.call();
                          } else if (value == 'reply') {
                            onReply?.call();
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
                      color:
                          Theme.of(
                            context,
                          ).colorScheme.surfaceContainerHighest.withValues(
                            alpha: 0.4,
                          ),
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
                if (attachmentUrl != null && attachmentUrl!.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  if (_isImage(attachmentUrl, attachmentType))
                    GestureDetector(
                      onLongPress: () {
                        unawaited(
                          _showImageActionDialog(context, attachmentUrl!),
                        );
                      },
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxHeight: 250,
                          minWidth: double.infinity,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            attachmentUrl!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Text('Failed to load image'),
                          ),
                        ),
                      ),
                    )
                  else
                    OutlinedButton.icon(
                      onPressed: () => _launchUrl(attachmentUrl!),
                      icon: const Icon(Icons.attach_file),
                      label: const Text('Download attachment'),
                    ),
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
