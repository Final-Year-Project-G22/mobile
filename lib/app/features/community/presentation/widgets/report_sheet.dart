import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/l10n/generated/app_localizations.dart';
import '../../application/providers/community_mutations_provider.dart';
import '../../domain/failures/community_failure.dart';

class ReportSheet extends ConsumerStatefulWidget {
  const ReportSheet({
    required this.threadId,
    this.postId,
    this.targetUserId,
    this.targetUserName,
    super.key,
  });

  final String threadId;
  final String? postId;
  final String? targetUserId;
  final String? targetUserName;

  @override
  ConsumerState<ReportSheet> createState() => _ReportSheetState();
}

class _ReportSheetState extends ConsumerState<ReportSheet> {
  final _reasonController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isSubmitting = false;

  String get _reportType {
    if (widget.postId != null) return 'Post';
    if (widget.targetUserId != null) return 'User';
    return 'Thread';
  }

  static const _quickReasons = [
    'Spam',
    'Harassment',
    'Inappropriate Content',
    'Misinformation',
    'Other',
  ];

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  void _selectReason(String reason) {
    _reasonController.text = reason;
  }

  Future<void> _submit(AppLocalizations l10n) async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);

    final reason = _reasonController.text.trim();
    final notifier = ref.read(communityMutationsProvider.notifier);

    final Either<CommunityFailure, Unit> result;
    if (widget.postId != null) {
      result = await notifier.reportPost(
        threadId: widget.threadId,
        postId: widget.postId!,
        reason: reason,
      );
    } else if (widget.targetUserId != null) {
      result = await notifier.reportUser(
        threadId: widget.threadId,
        reportedAccountId: widget.targetUserId!,
        reason: reason,
      );
    } else {
      result = await notifier.reportThread(
        threadId: widget.threadId,
        reason: reason,
      );
    }

    if (!mounted) return;

    result.fold(
      (failure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to report: $failure')),
        );
      },
      (_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.reportedSuccessfully(_reportType))),
        );
        Navigator.of(context).pop();
      },
    );

    if (mounted) setState(() => _isSubmitting = false);
  }

  String _reasonLabel(String reason, AppLocalizations l10n) {
    switch (reason) {
      case 'Spam':
        return l10n.reasonSpam;
      case 'Harassment':
        return l10n.reasonHarassment;
      case 'Inappropriate Content':
        return l10n.reasonInappropriate;
      case 'Misinformation':
        return l10n.reasonMisinformation;
      case 'Other':
        return l10n.reasonOther;
      default:
        return reason;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.fromLTRB(16, 16, 16, bottomInset + 16),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${l10n.report} $_reportType',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              if (widget.targetUserId != null &&
                  widget.targetUserName != null) ...[
                const SizedBox(height: 4),
                Text(
                  'Reporting @${widget.targetUserName}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
              const SizedBox(height: 16),

              Text(
                l10n.selectReason,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _quickReasons.map((reason) {
                  final isSelected = _reasonController.text == reason;
                  return ChoiceChip(
                    label: Text(_reasonLabel(reason, l10n)),
                    selected: isSelected,
                    onSelected: (_) => _selectReason(reason),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _reasonController,
                minLines: 3,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: 'Reason',
                  hintText: l10n.reasonHint,
                  border: const OutlineInputBorder(),
                ),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) {
                    return 'Please enter a reason';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _isSubmitting ? null : () => _submit(l10n),
                  child: _isSubmitting
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Text(l10n.submitReport),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
