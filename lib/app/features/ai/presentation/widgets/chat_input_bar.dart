import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../../../../core/di/app_providers.dart';
import '../../../../../core/l10n/generated/app_localizations.dart';
import '../../../../constants/app_spacing.dart';

class ChatInputBar extends ConsumerStatefulWidget {
  const ChatInputBar({
    required this.onSend,
    required this.onStop,
    required this.isStreaming,
    super.key,
  });

  final void Function(String text) onSend;
  final VoidCallback onStop;
  final bool isStreaming;

  @override
  ConsumerState<ChatInputBar> createState() => _ChatInputBarState();
}

class _ChatInputBarState extends ConsumerState<ChatInputBar> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  final _speech = SpeechToText();
  bool _hasText = false;
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    unawaited(_speech.cancel());
    _controller
      ..removeListener(_onTextChanged)
      ..dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    final hasText = _controller.text.trim().isNotEmpty;
    if (hasText != _hasText) {
      setState(() => _hasText = hasText);
    }
  }

  void _handleSend() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    _controller.clear();
    setState(() => _hasText = false);
    widget.onSend(text);
  }

  void _handleStop() {
    widget.onStop();
  }

  Future<void> _toggleListening() async {
    if (_isListening) {
      await _speech.stop();
      setState(() => _isListening = false);
      return;
    }

    final available = await _speech.initialize(
      onError: (error) {
        if (mounted) {
          setState(() => _isListening = false);
        }
      },
      onStatus: (status) {
        if (status == 'done' || status == 'notListening') {
          if (mounted) {
            setState(() => _isListening = false);
          }
        }
      },
    );

    if (!mounted) return;

    if (!available) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context).speechNotAvailable),
          ),
        );
      }
      return;
    }

    setState(() {
      _isListening = true;
    });

    final locale = ref.read(localeProvider);
    final localeId = locale?.languageCode == 'am' ? 'am_ET' : 'en_US';

    await _speech.listen(
      onResult: _onSpeechResult,
      listenOptions: SpeechListenOptions(
        localeId: localeId,
        listenFor: const Duration(seconds: 30),
        pauseFor: const Duration(seconds: 3),
      ),
    );
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    if (result.recognizedWords.isNotEmpty && mounted) {
      setState(() {
        _controller.text = result.recognizedWords;
        _controller.selection = TextSelection.fromPosition(
          TextPosition(offset: _controller.text.length),
        );
        _hasText = _controller.text.trim().isNotEmpty;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(
          top: BorderSide(
            color: theme.colorScheme.outlineVariant.withValues(alpha: 0.3),
          ),
        ),
      ),
      padding: const EdgeInsets.only(
        left: 12,
        right: 8,
        top: 8,
        bottom: 8,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
              constraints: const BoxConstraints(maxHeight: 160),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest,
                borderRadius: AppSpacing.borderRadiusXl,
              ),
              child: TextField(
                controller: _controller,
                focusNode: _focusNode,
                maxLines: 6,
                minLines: 1,
                textInputAction: TextInputAction.send,
                onSubmitted: (_) => _handleSend(),
                decoration: InputDecoration(
                  hintText: l10n.aiGuideInputHint,
                  hintStyle: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.sm,
                  ),
                ),
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ),
          ),
          const SizedBox(width: 4),
          if (_isListening)
            IconButton.filled(
              onPressed: _toggleListening,
              tooltip: l10n.stopListening,
              icon: const Icon(Icons.mic, size: 20),
              style: IconButton.styleFrom(
                backgroundColor: theme.colorScheme.error,
                foregroundColor: theme.colorScheme.onError,
              ),
            )
          else
            IconButton(
              onPressed: widget.isStreaming ? null : _toggleListening,
              tooltip: l10n.voiceInput,
              icon: const Icon(Icons.mic_none_rounded, size: 20),
              color: theme.colorScheme.onSurfaceVariant,
            ),
          if (widget.isStreaming)
            IconButton.filled(
              onPressed: _handleStop,
              tooltip: 'Stop',
              icon: const Icon(Icons.stop_rounded, size: 20),
              style: IconButton.styleFrom(
                backgroundColor: theme.colorScheme.error,
                foregroundColor: theme.colorScheme.onError,
              ),
            )
          else
            IconButton.filled(
              onPressed: _hasText ? _handleSend : null,
              tooltip: 'Send',
              icon: const Icon(Icons.arrow_upward_rounded, size: 20),
              style: IconButton.styleFrom(
                backgroundColor: _hasText
                    ? theme.colorScheme.primary
                    : theme.colorScheme.surfaceContainerHighest,
                foregroundColor: _hasText
                    ? theme.colorScheme.onPrimary
                    : theme.colorScheme.onSurface.withValues(alpha: 0.3),
              ),
            ),
        ],
      ),
    );
  }
}
