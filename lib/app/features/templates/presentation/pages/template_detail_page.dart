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
import '../../../../../core/l10n/generated/app_localizations.dart';
import '../../../../../shared/widgets/adisu_progress_indicator.dart';
import '../../../../../shared/widgets/styled_filter_chip.dart';
import '../../../../constants/app_spacing.dart';
import '../../../payment/application/providers/subscription_provider.dart';
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
  void initState() {
    super.initState();
    unawaited(_downloadPdf());
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
    final l10n = AppLocalizations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: _isLoading
          ? const Center(child: AdisuProgressIndicator())
          : _error != null
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 64,
                      color: colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Text(l10n.failedToLoadPDF(_error!)),
                    const SizedBox(height: AppSpacing.md),
                    FilledButton.icon(
                      onPressed: () => launchUrl(
                        Uri.parse(widget.url),
                        mode: LaunchMode.externalApplication,
                      ),
                      icon: const Icon(Icons.open_in_new),
                      label: Text(l10n.openInBrowser),
                    ),
                  ],
                ),
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
    final l10n = AppLocalizations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.templateDetails)),
      body: detailAsync.when(
        data: (data) => _buildContent(data, l10n),
        loading: () => const Center(child: AdisuProgressIndicator()),
        error: (error, _) => Center(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 64,
                  color: colorScheme.onSurfaceVariant,
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  _mapErrorToMessage(error, l10n),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: AppSpacing.lg),
                FilledButton.icon(
                  onPressed: () =>
                      ref.invalidate(templateDetailProvider(widget.groupId)),
                  icon: const Icon(Icons.refresh),
                  label: Text(l10n.retry),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(TemplateGroupDetail detail, AppLocalizations l10n) {
    final theme = Theme.of(context);
    final sub = ref.watch(subscriptionProvider).value;
    final isPro = sub != null && sub.planName == 'Pro' && sub.status == 'active';

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
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.screenH,
            AppSpacing.md,
            AppSpacing.screenH,
            AppSpacing.xs,
          ),
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
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenH),
          child: Wrap(
            spacing: AppSpacing.xs,
            children: [
              StyledFilterChip(
                avatar: const Icon(Icons.description, size: 16),
                label: _formatContentType(detail.languages.first.contentType),
                isSelected: false,
                onSelected: (_) {},
                compact: true,
              ),
              StyledFilterChip(
                avatar: const Icon(Icons.download, size: 16),
                label: l10n.downloadCount(detail.downloadCount),
                isSelected: false,
                onSelected: (_) {},
                compact: true,
              ),
            ],
          ),
        ),

        const SizedBox(height: AppSpacing.md),

        // Language variant sections
        for (final variant in detail.languages) ...[
          _buildVariantSection(detail, variant, theme, l10n, isPro),
          if (variant != detail.languages.last) const Divider(height: 1),
        ],
      ],
    );
  }

  Widget _buildVariantSection(
    TemplateGroupDetail detail,
    LanguageVariant variant,
    ThemeData theme,
    AppLocalizations l10n,
    bool isPro,
  ) {
    final langName = _langNames[variant.language] ?? variant.language;
    final isDownloading = _downloadingLanguages.contains(variant.language);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenH,
        vertical: AppSpacing.md,
      ),
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
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.translate,
                size: 14,
                color: theme.colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 4),
              Text(
                langName,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          if (variant.description != null &&
              variant.description!.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.xs),
            Text(variant.description!, style: theme.textTheme.bodyMedium),
          ],
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () =>
                      _handlePreview(detail, variant.language, l10n),
                  icon: const Icon(Icons.visibility, size: 18),
                  label: Text(l10n.preview),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: FilledButton.icon(
                  onPressed: isDownloading
                      ? null
                      : () => _handleDownload(detail, variant.language, l10n),
                  icon: isDownloading
                      ? const AdisuProgressIndicator.small()
                      : Icon(
                          detail.tierAccess == 'pro' && !isPro
                              ? Icons.workspace_premium_outlined
                              : Icons.download,
                          size: 18,
                        ),
                  label: Text(
                    detail.tierAccess == 'pro' && !isPro
                        ? l10n.upgrade
                        : l10n.download,
                  ),
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

  Future<void> _openInAppPreview(
    String url,
    String contentType,
    AppLocalizations l10n,
  ) async {
    if (contentType.startsWith('image/')) {
      await showDialog<void>(
        context: context,
        builder: (_) => Dialog(
          child: InteractiveViewer(
            child: Image.network(url, fit: BoxFit.contain),
          ),
        ),
      );
      return;
    }
    await Navigator.push<void>(
      context,
      MaterialPageRoute(
        builder: (_) => PdfPreviewScreen(url: url, title: l10n.preview),
      ),
    );
  }

  Future<void> _handlePreview(
    TemplateGroupDetail detail,
    String language,
    AppLocalizations l10n,
  ) async {
    if (detail.tierAccess == 'pro') {
      final sub = await ref.read(subscriptionProvider.future);
      final isPro = sub != null && sub.planName == 'Pro' && sub.status == 'active';
      if (!isPro) {
        await _showUpgradeModal(l10n);
        return;
      }
    }
    try {
      final result = await ref.read(
        previewTemplateProvider(
          groupId: widget.groupId,
          language: language,
        ).future,
      );
      final uri = Uri.parse(result.presignedUrl);
      if (_isViewableInApp(result.contentType)) {
        await _openInAppPreview(result.presignedUrl, result.contentType, l10n);
      } else {
        if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(l10n.previewFailed)),
            );
          }
        }
      }
    } on Exception catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${l10n.previewFailed}: $e')),
        );
      }
    }
  }

  Future<void> _handleDownload(
    TemplateGroupDetail detail,
    String language,
    AppLocalizations l10n,
  ) async {
    if (detail.tierAccess == 'pro') {
      final sub = await ref.read(subscriptionProvider.future);
      final isPro = sub != null && sub.planName == 'Pro' && sub.status == 'active';
      if (!isPro) {
        await _showUpgradeModal(l10n);
        return;
      }
    }

    setState(() => _downloadingLanguages.add(language));

    try {
      final result = await ref.read(
        downloadTemplateProvider(
          groupId: widget.groupId,
          language: language,
        ).future,
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
            content: Text(l10n.downloadedFile(result.filename)),
            action: SnackBarAction(
              label: l10n.open,
              onPressed: () => OpenFilex.open(filePath),
            ),
          ),
        );
      }
    } on DioException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(content: Text(l10n.downloadFailed(e.message ?? ''))),
          );
      }
    } on Exception catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.downloadFailed('$e'))),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _downloadingLanguages.remove(language));
      }
    }
  }

  String _mapErrorToMessage(Object error, AppLocalizations l10n) {
    if (error is TemplateFailure) {
      return error.when(
        networkError: () => l10n.errorNetwork,
        notFound: () => l10n.errorUnknown,
        unauthorized: () => l10n.errorUnauthorized,
        invalidData: () => l10n.errorUnknown,
        serverError: (detail) => detail ?? l10n.errorUnknown,
      );
    }
    return '${l10n.error}: $error';
  }

  Future<void> _showUpgradeModal(AppLocalizations l10n) async {
    final router = GoRouter.of(context);
    final theme = Theme.of(context);
    await showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        icon: Icon(Icons.lock, color: theme.colorScheme.tertiary),
        title: Text(l10n.proTemplateTitle),
        content: Text(l10n.proTemplateDescription),
        actions: [
          TextButton(
            onPressed: router.pop,
            child: Text(l10n.maybeLater),
          ),
          FilledButton(
            onPressed: () =>
                unawaited(router.push(const PlansRoute().location)),
            child: Text(l10n.upgradeToPro),
          ),
        ],
      ),
    );
  }
}
