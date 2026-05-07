import 'dart:async';

import 'package:api_client/api_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/chat_message.dart';
import '../../domain/i_ai_repository.dart';
import 'ai_chat_state.dart';
import 'ai_providers.dart';

final aiChatNotifierProvider = NotifierProvider<AiChatNotifier, AiChatState>(AiChatNotifier.new);

class AiChatNotifier extends Notifier<AiChatState> {
  StreamSubscription<SseEvent>? _streamSubscription;
  int _idCounter = 0;

  String get _nextId => '${DateTime.now().millisecondsSinceEpoch}-${_idCounter++}';

  @override
  AiChatState build() => const AiChatState();

  Future<void> sendMessage(String query) async {
    if (state.isStreaming) return;

    final userMessage = ChatMessage(
      id: _nextId,
      role: ChatRole.user,
      content: query,
      createdAt: DateTime.now(),
    );

    final assistantMessage = ChatMessage(
      id: _nextId,
      role: ChatRole.assistant,
      content: '',
      isStreaming: true,
    );

    state = state.copyWith(
      messages: [...state.messages, userMessage, assistantMessage],
      isStreaming: true,
      streamError: null,
    );

    final repository = ref.read(aiRepositoryProvider);
    final isNewSession = state.sessionId == null;

    _streamSubscription = repository
        .askStream(
          query: query,
          sessionId: state.sessionId,
          title: isNewSession ? _truncateTitle(query) : null,
        )
        .listen(
          _handleSseEvent,
          onError: (_) => _handleStreamError(),
          onDone: _handleStreamDone,
        );
  }

  void stopStreaming() {
    unawaited(_streamSubscription?.cancel());
    _streamSubscription = null;

    if (!state.isStreaming) return;

    final messages = List<ChatMessage>.from(state.messages);
    if (messages.isNotEmpty && messages.last.role == ChatRole.assistant) {
      final last = messages.last;
      messages[messages.length - 1] = last.copyWith(isStreaming: false);
    }

    state = state.copyWith(
      messages: messages,
      isStreaming: false,
    );
  }

  Future<void> loadConversation(String sessionId) async {
    unawaited(_streamSubscription?.cancel());
    _streamSubscription = null;

    final repository = ref.read(aiRepositoryProvider);
    final result = await repository.getConversation(sessionId);

    result.fold(
      (_) {
        state = state.copyWith(
          streamError: 'Failed to load conversation',
        );
      },
      (messages) {
        state = AiChatState(
          messages: messages,
          sessionId: sessionId,
        );
      },
    );
  }

  void startNewChat() {
    unawaited(_streamSubscription?.cancel());
    _streamSubscription = null;
    state = const AiChatState();
  }

  void clearStreamError() {
    state = state.copyWith(streamError: null);
  }

  void _handleSseEvent(SseEvent event) {
    switch (event.type) {
      case SseEventType.chunk:
        _appendText(event.text ?? '');
      case SseEventType.citations:
        _setCitations(event.citations ?? []);
      case SseEventType.done:
        _finalizeMessage();
        if (event.sessionId != null) {
          state = state.copyWith(sessionId: event.sessionId);
        }
      case SseEventType.error:
        _handleStreamError(message: event.error);
    }
  }

  void _handleStreamDone() {
    if (!state.isStreaming) return;
    final messages = List<ChatMessage>.from(state.messages);
    if (messages.isNotEmpty && messages.last.role == ChatRole.assistant) {
      final last = messages.last;
      if (last.isStreaming) {
        messages[messages.length - 1] = last.copyWith(isStreaming: false);
      }
    }
    state = state.copyWith(
      messages: messages,
      isStreaming: false,
    );
  }

  void _handleStreamError({String? message}) {
    final messages = List<ChatMessage>.from(state.messages);
    if (messages.isNotEmpty && messages.last.role == ChatRole.assistant) {
      final last = messages.last;
      messages[messages.length - 1] = last.copyWith(isStreaming: false);
    }
    state = state.copyWith(
      messages: messages,
      isStreaming: false,
      streamError: message ?? 'Something went wrong. Tap to retry.',
    );
  }

  void _appendText(String text) {
    if (!state.isStreaming) return;
    final messages = List<ChatMessage>.from(state.messages);
    if (messages.isEmpty) return;

    final last = messages.last;
    if (last.role != ChatRole.assistant) return;

    messages[messages.length - 1] = last.copyWith(
      content: last.content + text,
    );

    state = state.copyWith(messages: messages);
  }

  void _setCitations(List<CitationDto> citations) {
    if (!state.isStreaming) return;
    final messages = List<ChatMessage>.from(state.messages);
    if (messages.isEmpty) return;

    final last = messages.last;
    if (last.role != ChatRole.assistant) return;

    messages[messages.length - 1] = last.copyWith(citations: citations);
    state = state.copyWith(messages: messages);
  }

  void _finalizeMessage() {
    if (!state.isStreaming) return;
    final messages = List<ChatMessage>.from(state.messages);
    if (messages.isEmpty) return;

    final last = messages.last;
    if (last.role != ChatRole.assistant) return;

    messages[messages.length - 1] = last.copyWith(isStreaming: false);
    state = state.copyWith(messages: messages, isStreaming: false);
  }

  String _truncateTitle(String query) {
    if (query.length <= 40) return query;
    return '${query.substring(0, 40)}...';
  }
}
