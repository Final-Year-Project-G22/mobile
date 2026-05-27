import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/l10n/generated/app_localizations.dart';
import '../../../../constants/app_spacing.dart';
import '../../application/providers/ai_chat_notifier.dart';
import '../../domain/entities/chat_message.dart';
import '../widgets/chat_input_bar.dart';
import '../widgets/chat_message_bubble.dart';
import '../widgets/conversation_history_drawer.dart';
import '../widgets/empty_chat_view.dart';

class AiChatPage extends ConsumerStatefulWidget {
  const AiChatPage({super.key});

  @override
  ConsumerState<AiChatPage> createState() => _AiChatPageState();
}

class _AiChatPageState extends ConsumerState<AiChatPage> {
  final _scrollController = ScrollController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _showScrollToBottom = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    final show = maxScroll - currentScroll > 200;
    if (show != _showScrollToBottom) {
      setState(() => _showScrollToBottom = show);
    }
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      unawaited(
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        ),
      );
    }
  }

  void _onNewContent() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        final maxScroll = _scrollController.position.maxScrollExtent;
        final currentScroll = _scrollController.position.pixels;
        if (maxScroll - currentScroll < 200) {
          unawaited(
            _scrollController.animateTo(
              maxScroll,
              duration: const Duration(milliseconds: 100),
              curve: Curves.easeOut,
            ),
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final chatState = ref.watch(aiChatNotifierProvider);
    final messages = chatState.messages;
    final isStreaming = chatState.isStreaming;
    final streamError = chatState.streamError;
    final hasMessages = messages.isNotEmpty;
    final l10n = AppLocalizations.of(context);

    ref.listen(aiChatNotifierProvider, (prev, next) {
      if (prev?.messages.length != next.messages.length ||
          (next.messages.isNotEmpty &&
              next.messages.last.isStreaming !=
                  prev?.messages.last.isStreaming)) {
        _onNewContent();
      }
    });

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          tooltip: l10n.back,
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            }
          },
        ),
        title: Text(l10n.aiGuideTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu_rounded),
            tooltip: l10n.aiGuideConversations,
            onPressed: () => _scaffoldKey.currentState?.openDrawer(),
          ),
          IconButton(
            icon: const Icon(Icons.add_rounded),
            tooltip: 'New chat',
            onPressed: () =>
                ref.read(aiChatNotifierProvider.notifier).startNewChat(),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: hasMessages
                ? _buildMessageList(messages, streamError)
                : const EmptyChatView(),
          ),
          ChatInputBar(
            onSend: (text) => unawaited(
              ref.read(aiChatNotifierProvider.notifier).sendMessage(text),
            ),
            onStop: () => ref.read(aiChatNotifierProvider.notifier).stopStreaming(),
            isStreaming: isStreaming,
          ),
        ],
      ),
      drawer: ConversationHistoryDrawer(
        onConversationSelected: (sessionId) {
          unawaited(
            ref
                .read(aiChatNotifierProvider.notifier)
                .loadConversation(sessionId),
          );
        },
      ),
      floatingActionButton: _showScrollToBottom
          ? FloatingActionButton.small(
              onPressed: _scrollToBottom,
              child: const Icon(Icons.keyboard_arrow_down_rounded),
            )
          : null,
    );
  }

  Widget _buildMessageList(
    List<ChatMessage> messages,
    String? streamError,
  ) {
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      itemCount: messages.length + (streamError != null ? 1 : 0),
      itemBuilder: (context, index) {
        if (index < messages.length) {
          return ChatMessageBubble(message: messages[index]);
        }
        return _buildStreamError(streamError!);
      },
    );
  }

  Widget _buildStreamError(String message) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 14,
            backgroundColor: theme.colorScheme.errorContainer,
            child: Icon(
              Icons.error_outline_rounded,
              size: 16,
              color: theme.colorScheme.onErrorContainer,
            ),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: InkWell(
              onTap: () {
                ref.read(aiChatNotifierProvider.notifier).clearStreamError();
              },
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: theme.colorScheme.errorContainer,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Text(
                        message,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onErrorContainer,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      Icons.refresh_rounded,
                      size: 16,
                      color: theme.colorScheme.onErrorContainer,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      l10n.retry,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.onErrorContainer,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
