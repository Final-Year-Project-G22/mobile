import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../app/router/routes.dart';
import '../../application/providers/templates_data_providers.dart';
import '../../application/providers/templates_providers.dart';
import '../../domain/entities/language_variant.dart';
import '../../domain/entities/template_group_detail.dart';
import '../../domain/failures/template_failure.dart';
import '../widgets/tier_badge.dart';

const _langNames = {
  'en': 'English',
  'am': 'Amharic',
  'fr': 'French',
  'om': 'Oromo',
  'ti': 'Tigrinya',
  'so': 'Somali',
};

String _formatFileSize(int bytes) {
  if (bytes < 1024) return '$bytes B';
  if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
  return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
}

String _formatContentType(String ct) {
  if (ct == 'application/pdf') return 'PDF';
  if (ct.contains('wordprocessingml')) return 'DOCX';
  if (ct.contains('spreadsheetml')) return 'XLSX';
  if (ct.startsWith('image/')) return ct.split('/').last.toUpperCase();
  return ct;
}

class PdfPreviewScreen extends StatefulWidget {
  const PdfPreviewScreen({required this.url, required this.title, super.key});
  final String url;
  final String title;

  @override
  State<PdfPreviewScreen> createState() => _PdfPreviewScreenState();
}

class _PdfPreviewScreenState extends State<PdfPreviewScreen> {
  String? _localPath;
  bool _isLoading = true;
  String? _error;

  @override
  Future<void> initState() async {
    super.initState();
    await _downloadPdf();
  }

  Future<void> _downloadPdf() async {
    try {
      final dir = await getTemporaryDirectory();
      final localPath = '${dir.path}/preview_temp.pdf';
      final dio = Dio();

      await dio.download(widget.url, localPath);

      if (mounted) {
        setState(() {
          _localPath = localPath;
          _isLoading = false;
        });
      }
    } on DioException catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  Text('Failed to load PDF: $_error'),
                  const SizedBox(height: 16),
                  FilledButton.icon(
                    onPressed: () => launchUrl(Uri.parse(widget.url), mode: LaunchMode.externalApplication),
                    icon: const Icon(Icons.open_in_new),
                    label: const Text('Open in Browser'),
                  ),
                ],
              ),
            )
          : PDFView(
              filePath: _localPath,
              fitPolicy: FitPolicy.BOTH,
            ),
    );
  }
}

class TemplateDetailPage extends ConsumerStatefulWidget {
  const TemplateDetailPage({required this.groupId, super.key});

  final String groupId;

  @override
  ConsumerState<TemplateDetailPage> createState() => _TemplateDetailPageState();
}

class _TemplateDetailPageState extends ConsumerState<TemplateDetailPage> {
  final Set<String> _downloadingLanguages = {};

  @override
  Widget build(BuildContext context) {
    final detailAsync = ref.watch(templateDetailProvider(widget.groupId));

    return Scaffold(
      appBar: AppBar(title: const Text('Template Details')),
      body: detailAsync.when(
        data: _buildContent,
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 64, color: Colors.grey),
                const SizedBox(height: 16),
                Text(
                  _mapErrorToMessage(error),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: () => ref.invalidate(templateDetailProvider(widget.groupId)),
                  icon: const Icon(Icons.refresh),
                  label: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(TemplateGroupDetail detail) {
    final theme = Theme.of(context);

    return ListView(
      children: [
        // Thumbnail
        if (detail.thumbnailUrl != null)
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Image.network(
              detail.thumbnailUrl!,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => ColoredBox(
                color: theme.colorScheme.surfaceContainerHighest,
                child: const Center(child: Icon(Icons.image, size: 64)),
              ),
            ),
          )
        else
          Container(
            height: 200,
            color: theme.colorScheme.surfaceContainerHighest,
            child: const Center(child: Icon(Icons.insert_drive_file, size: 64)),
          ),

        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Row(
            children: [
              Expanded(
                child: Text(detail.name, style: theme.textTheme.headlineSmall),
              ),
              TierBadge(tierAccess: detail.tierAccess),
            ],
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Wrap(
            spacing: 8,
            children: [
              Chip(
                avatar: const Icon(Icons.description, size: 16),
                label: Text(_formatContentType(detail.languages.first.contentType)),
                visualDensity: VisualDensity.compact,
              ),
              Chip(
                avatar: const Icon(Icons.download, size: 16),
                label: Text('${detail.downloadCount} downloads'),
                visualDensity: VisualDensity.compact,
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // Language variant sections
        for (final variant in detail.languages) ...[
          _buildVariantSection(detail, variant, theme),
          if (variant != detail.languages.last) const Divider(height: 1),
        ],
      ],
    );
  }

  Widget _buildVariantSection(
    TemplateGroupDetail detail,
    LanguageVariant variant,
    ThemeData theme,
  ) {
    final langName = _langNames[variant.language] ?? variant.language;
    final isDownloading = _downloadingLanguages.contains(variant.language);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(variant.title, style: theme.textTheme.titleMedium),
              ),
              Text(
                '${_formatContentType(variant.contentType)} • ${_formatFileSize(variant.fileSize)}',
                style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.translate, size: 14, color: theme.colorScheme.onSurfaceVariant),
              const SizedBox(width: 4),
              Text(langName, style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
            ],
          ),
          if (variant.description != null && variant.description!.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(variant.description!, style: theme.textTheme.bodyMedium),
          ],
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _handlePreview(detail, variant.language),
                  icon: const Icon(Icons.visibility, size: 18),
                  label: const Text('Preview'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton.icon(
                  onPressed: isDownloading ? null : () => _handleDownload(detail, variant.language),
                  icon: isDownloading
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                        )
                      : const Icon(Icons.download, size: 18),
                  label: Text(detail.tierAccess == 'pro' ? 'Upgrade' : 'Download'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  bool _isViewableInApp(String contentType) {
    return contentType == 'application/pdf' || contentType.startsWith('image/');
  }

  Future<void> _openInAppPreview(String url, String contentType) async {
    if (contentType.startsWith('image/')) {
      await showDialog<void>(
        context: context,
        builder: (_) => Dialog(
          child: InteractiveViewer(child: Image.network(url, fit: BoxFit.contain)),
        ),
      );
      return;
    }
    await Navigator.push<void>(
      context,
      MaterialPageRoute(
        builder: (_) => PdfPreviewScreen(url: url, title: 'Preview'),
      ),
    );
  }

  Future<void> _handlePreview(TemplateGroupDetail detail, String language) async {
    if (detail.tierAccess == 'pro') {
      await _showUpgradeModal();
      return;
    }
    try {
      final result = await ref.read(
        previewTemplateProvider(groupId: widget.groupId, language: language).future,
      );
      final uri = Uri.parse(result.presignedUrl);
      if (_isViewableInApp(result.contentType)) {
        await _openInAppPreview(result.presignedUrl, result.contentType);
      } else {
        if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Could not open preview')),
            );
          }
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

    setState(() => _downloadingLanguages.add(language));

    try {
      final result = await ref.read(
        downloadTemplateProvider(groupId: widget.groupId, language: language).future,
      );

      final dio = Dio();
      final dir = await getApplicationDocumentsDirectory();
      final filePath = '${dir.path}/${result.filename}';
      await dio.download(result.presignedUrl, filePath);

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
            content: Text('Downloaded ${result.filename}'),
            action: SnackBarAction(
              label: 'Open',
              onPressed: () => OpenFilex.open(filePath),
            ),
          ),
        );
      }
    } on DioException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text('Download failed: ${e.message}')));
      }
    } on Exception catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Download failed: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _downloadingLanguages.remove(language));
      }
    }
  }

  String _mapErrorToMessage(Object error) {
    if (error is TemplateFailure) {
      return error.when(
        networkError: () => 'Network error. Please check your connection.',
        notFound: () => 'Template not found.',
        unauthorized: () => 'Please log in again.',
        invalidData: () => 'This template has incomplete data.',
        serverError: (detail) => detail ?? 'Something went wrong.',
      );
    }
    return 'Error: $error';
  }

  Future<void> _showUpgradeModal() async {
    final router = GoRouter.of(context);
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
            onPressed: router.pop,
            child: const Text('Maybe Later'),
          ),
          FilledButton(
            onPressed: () => unawaited(router.push(const PlansRoute().location)),
            child: const Text('Upgrade to Pro'),
          ),
        ],
      ),
    );
  }
}
