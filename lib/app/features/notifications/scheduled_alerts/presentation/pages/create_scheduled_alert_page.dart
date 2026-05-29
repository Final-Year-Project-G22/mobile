import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../app/router/routes.dart';
import '../../../../../../core/l10n/generated/app_localizations.dart';
import '../../../../../../shared/widgets/styled_filter_chip.dart';
import '../../../../payment/application/providers/subscription_provider.dart';
import '../../application/scheduled_alert_notifier.dart';
import '../../application/scheduled_alert_state.dart';
import '../../domain/entities/scheduled_alert_template.dart';
import '../../domain/failures/scheduled_alert_failure.dart';

class CreateScheduledAlertPage extends ConsumerStatefulWidget {
  const CreateScheduledAlertPage({super.key});

  @override
  ConsumerState<CreateScheduledAlertPage> createState() =>
      _CreateScheduledAlertPageState();
}

class _CreateScheduledAlertPageState
    extends ConsumerState<CreateScheduledAlertPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();

  ScheduledAlertTemplate? _selectedTemplate;
  final Set<String> _selectedChannels = {'in_app'};
  DateTime _selectedDate = DateTime.now().add(const Duration(days: 1));

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final asyncState = ref.watch(scheduledAlertProvider);
    final state = asyncState.value ?? ScheduledAlertState.initial();
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    ref.listen(scheduledAlertProvider, (previous, next) async {
      final failure = next.value?.failure;
      final prevFailure = previous?.value?.failure;
      if (failure != null && failure != prevFailure) {
        failure.when(
          maxLimitReached: (_) => _showUpgradeModal(l10n),
          serverError: (_) => _showErrorSnackBar(l10n.errorServer),
          unableToCreate: (_) => _showErrorSnackBar(l10n.unableToCreateAlert),
          unableToCancel: (_) => _showErrorSnackBar(l10n.unableToCancelAlert),
          unableToReschedule: (_) => _showErrorSnackBar(l10n.unableToRescheduleAlert),
          notFound: (_) => _showErrorSnackBar(l10n.scheduledAlertNotFound),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.newScheduledAlert),
        actions: [
          TextButton(
            onPressed: _save,
            child: Text(l10n.save),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Template picker
            DropdownButtonFormField<ScheduledAlertTemplate>(
              initialValue: _selectedTemplate,
              decoration: InputDecoration(
                labelText: l10n.template,
                border: const OutlineInputBorder(),
              ),
              isExpanded: true,
              items: [
                DropdownMenuItem<ScheduledAlertTemplate>(
                  child: Text(l10n.noneCustom),
                ),
                ...state.templates.map((t) =>
                    DropdownMenuItem<ScheduledAlertTemplate>(
                      value: t,
                      child: Text(t.name),
                    )),
              ],
              onChanged: (template) {
                setState(() {
                  _selectedTemplate = template;
                  if (template != null) {
                    _titleController.text = template.defaultTitle;
                    _bodyController.text = template.defaultBody;
                    if (template.defaultChannel != null) {
                      _selectedChannels
                        ..clear()
                        ..add(template.defaultChannel!);
                    }
                  }
                });
              },
            ),
            const SizedBox(height: 16),

            // Title
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: l10n.title,
                border: const OutlineInputBorder(),
              ),
              maxLength: 255,
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? l10n.titleRequired : null,
            ),
            const SizedBox(height: 16),

            // Body
            TextFormField(
              controller: _bodyController,
              decoration: InputDecoration(
                labelText: l10n.bodyField,
                border: const OutlineInputBorder(),
              ),
              maxLines: 3,
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? l10n.bodyRequired : null,
            ),
            const SizedBox(height: 16),

            // Channel selector
            Text(l10n.channels, style: theme.textTheme.titleSmall),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: ['in_app', 'email', 'push'].map((channel) {
                final label = switch (channel) {
                  'in_app' => l10n.inAppChannel,
                  'email' => l10n.email,
                  'push' => l10n.pushChannel,
                  _ => channel,
                };
                final selected = _selectedChannels.contains(channel);
                return StyledFilterChip(
                  label: label,
                  isSelected: selected,
                  onSelected: (on) {
                    setState(() {
                      if (on) {
                        _selectedChannels.add(channel);
                      } else {
                        _selectedChannels.remove(channel);
                      }
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 16),

            // Date/time
            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: Text(
                '${_selectedDate.month}/${_selectedDate.day}/${_selectedDate.year} '
                '${_selectedDate.hour.toString().padLeft(2, '0')}:'
                '${_selectedDate.minute.toString().padLeft(2, '0')}',
              ),
              trailing: const Icon(Icons.edit),
              onTap: _pickDateTime,
            ),
            const SizedBox(height: 16),

            // Info
            if (state.alerts.length < 3)
              Text(
                l10n.freeUserAlertCount(state.alerts.length),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickDateTime() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (date == null || !mounted) return;

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_selectedDate),
    );
    if (time == null) return;

    setState(() {
      _selectedDate = DateTime(
        date.year, date.month, date.day, time.hour, time.minute,
      );
    });
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    final state = ref.read(scheduledAlertProvider).value ?? ScheduledAlertState.initial();
    if (state.alerts.length >= 3) {
      final sub = await ref.read(subscriptionProvider.future);
      if (!mounted) return;
      final isPro = sub != null && sub.planName == 'Pro' && sub.status == 'active';
      if (!isPro) {
        await _showUpgradeModal(AppLocalizations.of(context));
        return;
      }
    }

    await ref.read(scheduledAlertProvider.notifier).createAlert(
      templateSlug: _selectedTemplate?.slug,
      title: _titleController.text.trim(),
      body: _bodyController.text.trim(),
      channels: _selectedChannels.toList(),
      scheduledFor: _selectedDate.toUtc(),
    );

    if (!mounted) return;
    final current = ref.read(scheduledAlertProvider);
    if (current.value?.failure == null) {
      context.pop();
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Theme.of(context).colorScheme.error),
    );
  }

  Future<void> _showUpgradeModal(AppLocalizations l10n) async {
    final router = GoRouter.of(context);
    final theme = Theme.of(context);
    await showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        icon: Icon(Icons.lock, color: theme.colorScheme.tertiary),
        title: Text(l10n.upgradeToPro),
        content: Text(l10n.upgradeToProDesc),
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
