import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../application/providers/templates_data_providers.dart';
import '../../application/providers/templates_providers.dart';
import '../../domain/entities/template_group_detail.dart';
import '../widgets/language_selector.dart';
import '../widgets/tier_badge.dart';

class TemplateDetailPage extends ConsumerStatefulWidget {
  const TemplateDetailPage({required this.slug, super.key});

  final String slug;

  @override
  ConsumerState<TemplateDetailPage> createState() => _TemplateDetailPageState();
}

class _TemplateDetailPageState extends ConsumerState<TemplateDetailPage> {
  String? _selectedLanguage;
  bool _isDownloading = false;

  @override
  Widget build(BuildContext context) {
    final detailAsync = ref.watch(templateDetailProvider(widget.slug));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Template Details'),
      ),
      body: detailAsync.when(
        data: (detail) => _buildContent(detail),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
      ),
    );
  }

  Widget _buildContent(TemplateGroupDetail detail) {
    final theme = Theme.of(context);
    final languages = detail.languages;
    final effectiveLanguage = _selectedLanguage ?? detail.defaultLanguage;
    final selectedVariant = languages.firstWhere(
      (l) => l.language == effectiveLanguage,
      orElse: () => languages.first,
    );

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Thumbnail
              if (detail.thumbnailUrl != null)
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.network(
                    detail.thumbnailUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: theme.colorScheme.surfaceContainerHighest,
                      child: const Center(
                        child: Icon(Icons.image, size: 64),
                      ),
                    ),
                  ),
                )
              else
                Container(
                  height: 200,
                  color: theme.colorScheme.surfaceContainerHighest,
                  child: const Center(
                    child: Icon(Icons.insert_drive_file, size: 64),
                  ),
                ),

              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title + tier
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            detail.name,
                            style: theme.textTheme.headlineSmall,
                          ),
                        ),
                        TierBadge(tierAccess: detail.tierAccess),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // Meta row
                    Wrap(
                      spacing: 12,
                      children: [
                        Chip(
                          label: Text(detail.format.toUpperCase()),
                          visualDensity: VisualDensity.compact,
                        ),
                        Chip(
                          avatar: const Icon(Icons.download, size: 16),
                          label: Text('${detail.downloadCount}'),
                          visualDensity: VisualDensity.compact,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Description from selected language variant
                    if (selectedVariant.description != null) ...[
                      Text(
                        selectedVariant.description!,
                        style: theme.textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 16),
                    ],

                    // Language selector
                    if (languages.length > 1) ...[
                      Text(
                        'Languages',
                        style: theme.textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      LanguageSelector(
                        languages: languages.map((l) => l.language).toList(),
                        selected: effectiveLanguage,
                        onSelect: (lang) => setState(() => _selectedLanguage = lang),
                      ),
                      const SizedBox(height: 24),
                    ],

                    // Actions
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () => _handlePreview(detail, effectiveLanguage),
                            icon: const Icon(Icons.visibility),
                            label: const Text('Preview'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: FilledButton.icon(
                            onPressed: _isDownloading
                                ? null
                                : () => _handleDownload(detail, effectiveLanguage),
                            icon: _isDownloading
                                ? const SizedBox(
                                    width: 18,
                                    height: 18,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                : const Icon(Icons.download),
                            label: Text(
                              detail.tierAccess == 'pro'
                                  ? 'Upgrade to Download'
                                  : 'Download',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _handlePreview(TemplateGroupDetail detail, String language) async {
    if (detail.tierAccess == 'pro') {
      await _showUpgradeModal();
      return;
    }

    try {
      final result = await ref.read(
        downloadTemplateProvider(slug: widget.slug, language: language).future,
      );

      final uri = Uri.parse(result.presignedUrl);
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Could not open preview')),
          );
        }
      }
    } on Exception catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Preview failed: $e')),
        );
      }
    }
  }

  Future<void> _handleDownload(TemplateGroupDetail detail, String language) async {
    if (detail.tierAccess == 'pro') {
      await _showUpgradeModal();
      return;
    }

    setState(() => _isDownloading = true);

    try {
      // 1. Get presigned URL
      final result = await ref.read(
        downloadTemplateProvider(slug: widget.slug, language: language).future,
      );

      // 2. Download file bytes via Dio (no auth needed for presigned URL)
      final dio = Dio();
      final dir = await getApplicationDocumentsDirectory();
      final filePath = '${dir.path}/${result.filename}';
      await dio.download(result.presignedUrl, filePath);

      // 3. Cache download metadata
      final cache = await ref.read(downloadsCacheServiceProvider.future);
      await cache.addDownload(
        downloadId: result.filename,
        templateId: detail.id,
        groupId: detail.id,
        slug: detail.slug,
        title: detail.name,
        thumbnailUrl: detail.thumbnailUrl,
        downloadedAt: DateTime.now(),
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Downloaded to ${result.filename}'),
            action: SnackBarAction(
              label: 'Open',
              onPressed: () async {
                final uri = Uri.file(filePath);
                await launchUrl(uri, mode: LaunchMode.externalApplication);
              },
            ),
          ),
        );
      }
    } on DioException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Download failed: ${e.message}')),
        );
      }
    } on Exception catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Download failed: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isDownloading = false);
      }
    }
  }

  Future<void> _showUpgradeModal() async {
    await showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        icon: const Icon(Icons.lock, color: Colors.amber),
        title: const Text('Pro Template'),
        content: const Text(
          'This template is available with a Pro subscription. Upgrade to download and preview.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Maybe Later'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Upgrade to Pro'),
          ),
        ],
      ),
    );
  }
}
