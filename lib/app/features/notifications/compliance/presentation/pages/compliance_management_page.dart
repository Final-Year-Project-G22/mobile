import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../app/constants/app_spacing.dart';
import '../../../../../../app/features/business_profile/application/business_profile_notifier.dart';
import '../../../../../../core/l10n/generated/app_localizations.dart';
import '../../application/compliance_notifier.dart';
import '../../application/compliance_state.dart';
import '../../domain/entities/compliance_entry.dart';
import '../../domain/failures/compliance_failure.dart';

class ComplianceManagementPage extends ConsumerStatefulWidget {
  const ComplianceManagementPage({super.key});

  @override
  ConsumerState<ComplianceManagementPage> createState() => _ComplianceManagementPageState();
}

class _ComplianceManagementPageState extends ConsumerState<ComplianceManagementPage> {
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) return;
      if (_initialized) return;
      _initialized = true;
      final bp = ref.read(businessProfileProvider).value;
      if (bp != null) {
        await ref.read(complianceProvider.notifier).loadEntries(bp.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final asyncState = ref.watch(complianceProvider);
    final state = asyncState.value ?? ComplianceState.initial();
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context);

    final hasBP = ref.read(businessProfileProvider).value != null;
    ref.listen(complianceProvider, (previous, next) {
      final failure = next.value?.failure;
      final prevFailure = previous?.value?.failure;
      if (failure != null && failure != prevFailure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              failure.when(
                serverError: (_) => l10n.errorServer,
                unableToCreate: (_) => l10n.complianceUnableToCreate,
                unableToUpdate: (_) => l10n.complianceUnableToUpdate,
                unableToDelete: (_) => l10n.complianceUnableToDelete,
                notFound: (_) => l10n.complianceNotFound,
              ),
            ),
            backgroundColor: colorScheme.error,
          ),
        );
      }
    });
    final entries = state.entries;
    final autoEntries = entries.where((e) => e.source == 'auto').toList();
    final manualEntries = entries.where((e) => e.source == 'manual').toList();

    return Scaffold(
      appBar: AppBar(title: Text(l10n.compliance)),
      body: asyncState.isLoading && entries.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: AppSpacing.paddingLg,
              children: [
                if (autoEntries.isNotEmpty) ...[
                  Text(l10n.complianceAutoTracked, style: theme.textTheme.titleMedium?.copyWith(color: colorScheme.primary)),
                  AppSpacing.gapVerticalSm,
                  ...autoEntries.map(
                    (e) => _ComplianceTile(entry: e, onTap: () => context.push('/compliance/manage/${e.id}')),
                  ),
                  AppSpacing.gapVerticalLg,
                ],
                if (manualEntries.isNotEmpty) ...[
                  Text(l10n.complianceManual, style: theme.textTheme.titleMedium?.copyWith(color: colorScheme.primary)),
                  AppSpacing.gapVerticalSm,
                  ...manualEntries.map(
                    (e) => _ComplianceTile(entry: e, onTap: () => context.push('/compliance/manage/${e.id}')),
                  ),
                  AppSpacing.gapVerticalLg,
                ],
                if (autoEntries.isEmpty && manualEntries.isEmpty && hasBP)
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppSpacing.gapVerticalLg,
                        Icon(Icons.assignment_late, size: 48, color: colorScheme.onSurfaceVariant),
                        AppSpacing.gapVerticalSm,
                        Text(l10n.complianceNoEntries, style: theme.textTheme.bodyLarge),
                        AppSpacing.gapVerticalSm,
                        Text(
                          l10n.complianceAutoTrackedDesc,
                          style: theme.textTheme.bodySmall?.copyWith(color: colorScheme.onSurfaceVariant),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                if (autoEntries.isEmpty && manualEntries.isEmpty && !hasBP)
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppSpacing.gapVerticalLg,
                        Icon(Icons.business_center_outlined, size: 48, color: colorScheme.onSurfaceVariant),
                        AppSpacing.gapVerticalSm,
                        Text(l10n.businessProfileRequired, style: theme.textTheme.bodyLarge),
                        AppSpacing.gapVerticalSm,
                        Text(
                          l10n.complianceCreateProfileDesc,
                          style: theme.textTheme.bodySmall?.copyWith(color: colorScheme.onSurfaceVariant),
                          textAlign: TextAlign.center,
                        ),
                        AppSpacing.gapVerticalMd,
                        FilledButton(
                          onPressed: () => context.push('/onboarding'),
                          child: Text(l10n.createBusinessProfile),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/compliance/manage/add'),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _ComplianceTile extends StatelessWidget {
  const _ComplianceTile({required this.entry, this.onTap});

  final ComplianceEntry entry;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isExpired = entry.status == 'expired';
    final isUrgent = !isExpired && entry.expiryDate.difference(DateTime.now()).inDays <= entry.reminderDaysBefore;

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(
          isExpired
              ? Icons.error_outline
              : isUrgent
              ? Icons.warning_amber
              : Icons.check_circle_outline,
          color: isExpired
              ? colorScheme.error
              : isUrgent
              ? Colors.orange
              : colorScheme.primary,
        ),
        title: Text(_typeLabel(entry.complianceType), style: theme.textTheme.bodyMedium),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (entry.referenceNumber != null) Text(entry.referenceNumber!, style: theme.textTheme.bodySmall),
            Text(
              '${l10n.expires} ${_formatDate(entry.expiryDate)}',
              style: theme.textTheme.bodySmall?.copyWith(
                color: isExpired ? colorScheme.error : colorScheme.onSurfaceVariant,
              ),
            ),
            if (entry.source == 'auto')
              Text(l10n.autoGenerated, style: theme.textTheme.labelSmall?.copyWith(color: colorScheme.onSurfaceVariant)),
          ],
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }

  String _typeLabel(String type) => switch (type) {
    'tax_registration' => 'Tax Registration',
    'trade_license' => 'Trade License',
    'business_registration' => 'Business Registration',
    _ => type,
  };

  String _formatDate(DateTime date) => '${date.month}/${date.day}/${date.year}';
}
