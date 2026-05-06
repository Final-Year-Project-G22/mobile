import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../application/providers/templates_data_providers.dart';
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
                            onPressed: () => _handleDownload(detail, effectiveLanguage),
                            icon: const Icon(Icons.download),
                            label: Text(
                              detail.tierAccess == 'pro' ? 'Upgrade to Download' : 'Download',
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
      _showUpgradeModal();
      return;
    }

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
  }

  Future<void> _handleDownload(TemplateGroupDetail detail, String language) async {
    if (detail.tierAccess == 'pro') {
      _showUpgradeModal();
      return;
    }

    // TODO: Phase 5 — actual file download via Dio + path_provider
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Download starting...')),
    );
  }

  void _showUpgradeModal() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
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
              // TODO: Navigate to upgrade/payment flow in v2
            },
            child: const Text('Upgrade to Pro'),
          ),
        ],
      ),
    );
  }
}
