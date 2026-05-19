import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../shared/widgets/styled_filter_chip.dart';
import '../../application/scheduled_alert_notifier.dart';
import '../../application/scheduled_alert_state.dart';
import '../../domain/entities/scheduled_alert_template.dart';

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

    ref.listen(scheduledAlertProvider, (previous, next) async {
      final nextErr = next.value?.errorMessage;
      final prevErr = previous?.value?.errorMessage;
      if (nextErr != null && nextErr != prevErr) {
        if (nextErr.contains('Upgrade to Pro')) {
          await showDialog<void>(
            context: context,
            builder: (ctx) => AlertDialog(
              title: const Text('Upgrade to Pro'),
              content: const Text(
                "You've reached the max of 3 scheduled alerts. "
                'Upgrade to Pro for unlimited alerts.',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(ctx).pop(),
                  child: const Text('Cancel'),
                ),
                FilledButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                    unawaited(context.push('/plans'));
                  },
                  child: const Text('View Plans'),
                ),
              ],
            ),
          );
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(nextErr)));
        }
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('New Scheduled Alert'),
        actions: [
          TextButton(
            onPressed: _save,
            child: const Text('Save'),
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
              decoration: const InputDecoration(
                labelText: 'Template',
                border: OutlineInputBorder(),
              ),
              isExpanded: true,
              items: [
                const DropdownMenuItem<ScheduledAlertTemplate>(
                  child: Text('None (Custom)'),
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
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
              maxLength: 255,
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Title is required' : null,
            ),
            const SizedBox(height: 16),

            // Body
            TextFormField(
              controller: _bodyController,
              decoration: const InputDecoration(
                labelText: 'Body',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Body is required' : null,
            ),
            const SizedBox(height: 16),

            // Channel selector
            Text('Channels', style: theme.textTheme.titleSmall),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: ['in_app', 'email', 'push'].map((channel) {
                final label = switch (channel) {
                  'in_app' => 'In-App',
                  'email' => 'Email',
                  'push' => 'Push',
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
                'Free users: ${state.alerts.length} of 3 used',
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

    await ref.read(scheduledAlertProvider.notifier).createAlert(
      templateSlug: _selectedTemplate?.slug,
      title: _titleController.text.trim(),
      body: _bodyController.text.trim(),
      channels: _selectedChannels.toList(),
      scheduledFor: _selectedDate.toUtc(),
    );

    if (!mounted) return;
    final current = ref.read(scheduledAlertProvider);
    if (current.value?.errorMessage == null) {
      context.pop();
    }
  }
}
