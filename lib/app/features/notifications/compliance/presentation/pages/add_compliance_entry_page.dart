import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../constants/app_spacing.dart';
import '../../../../../../core/di/infra_providers.dart';
import '../../../../../../core/l10n/generated/app_localizations.dart';
import '../../../../business_profile/application/business_profile_notifier.dart';
import '../../application/compliance_notifier.dart';
import '../../domain/failures/compliance_failure.dart';

class _TypeOption {
  const _TypeOption({required this.slug, required this.label});
  final String slug;
  final String label;
}

class AddComplianceEntryPage extends ConsumerStatefulWidget {
  const AddComplianceEntryPage({super.key});

  @override
  ConsumerState<AddComplianceEntryPage> createState() =>
      _AddComplianceEntryPageState();
}

class _AddComplianceEntryPageState
    extends ConsumerState<AddComplianceEntryPage> {
  String _selectedType = '';
  final _refController = TextEditingController();
  final _reminderController = TextEditingController(text: '30');
  DateTime _expiryDate = DateTime.now().add(const Duration(days: 365));
  bool _isSaving = false;
  List<_TypeOption> _types = [];

  @override
  void initState() {
    super.initState();
    unawaited(_loadTypes());
  }

  Future<void> _loadTypes() async {
    final apiClient = ref.read(apiClientProvider);
    final dio = apiClient.dio;
    try {
      final response = await dio.get<dynamic>('/api/v1/compliance/types');
      final rawData = response.data as Map<String, dynamic>;
      final data = rawData['data'] as List<dynamic>;
      final types = data.map((t) {
        final item = t as Map<String, dynamic>;
        return _TypeOption(
          slug: item['slug'] as String,
          label: item['label'] as String,
        );
      }).toList();
      setState(() {
        _types = types;
        if (_selectedType.isEmpty && types.isNotEmpty) {
          _selectedType = types.first.slug;
        }
      });
    } on Exception {
      // Silently fail — dropdown stays empty
    }
  }

  @override
  void dispose() {
    _refController.dispose();
    _reminderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final asyncBP = ref.watch(businessProfileProvider);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context);

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

    if (asyncBP.isLoading) {
      return Scaffold(
        appBar: AppBar(title: Text(l10n.addComplianceEntry)),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    final bp = asyncBP.value;
    if (bp == null) {
      return Scaffold(
        appBar: AppBar(title: Text(l10n.addComplianceEntry)),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.business_center_outlined,
                size: 48,
                color: colorScheme.onSurfaceVariant,
              ),
              const SizedBox(height: 16),
              Text(
                l10n.businessProfileRequired,
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 8),
              Text(
                l10n.complianceCreateProfileDesc,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: () => context.push('/onboarding'),
                child: Text(l10n.createBusinessProfile),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.addComplianceEntry),
        actions: [
          TextButton(
            onPressed: _isSaving ? null : () => _save(bp.id),
            child: Text(l10n.save),
          ),
        ],
      ),
      body: ListView(
        padding: AppSpacing.paddingLg,
        children: [
          Text(l10n.complianceType, style: theme.textTheme.titleSmall),
          AppSpacing.gapVerticalSm,
          DropdownButtonFormField<String>(
            initialValue: _selectedType,
            decoration: const InputDecoration(border: OutlineInputBorder()),
            items: _types
                .map(
                  (t) => DropdownMenuItem(
                    value: t.slug,
                    child: Text(t.label),
                  ),
                )
                .toList(),
            onChanged: (v) {
              if (v != null) setState(() => _selectedType = v);
            },
          ),
          AppSpacing.gapVerticalLg,
          Text(l10n.referenceNumber, style: theme.textTheme.titleSmall),
          AppSpacing.gapVerticalSm,
          TextFormField(
            controller: _refController,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: l10n.enterReferenceNumber,
            ),
          ),
          AppSpacing.gapVerticalLg,
          Text(l10n.expiryDate, style: theme.textTheme.titleSmall),
          AppSpacing.gapVerticalSm,
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.calendar_today),
            title: Text(
              '${_expiryDate.month}/${_expiryDate.day}/${_expiryDate.year}',
            ),
            trailing: const Icon(Icons.edit),
            onTap: () async {
              final date = await showDatePicker(
                context: context,
                initialDate: _expiryDate,
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 3650)),
              );
              if (date != null) setState(() => _expiryDate = date);
            },
          ),
          AppSpacing.gapVerticalLg,
          Text(l10n.remindBeforeDays, style: theme.textTheme.titleSmall),
          AppSpacing.gapVerticalSm,
          TextFormField(
            controller: _reminderController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: '30',
            ),
            keyboardType: TextInputType.number,
          ),
        ],
      ),
    );
  }

  Future<void> _save(String businessProfileId) async {
    setState(() => _isSaving = true);
    await ref
        .read(complianceProvider.notifier)
        .createEntry(
          businessProfileId: businessProfileId,
          complianceType: _selectedType,
          referenceNumber: _refController.text.isNotEmpty
              ? _refController.text
              : null,
          expiryDate: _expiryDate.toUtc(),
          reminderDaysBefore: int.tryParse(_reminderController.text) ?? 30,
        );
    setState(() => _isSaving = false);
    await ref.read(complianceProvider.notifier).loadEntries(businessProfileId);
    if (mounted) context.pop();
  }
}
