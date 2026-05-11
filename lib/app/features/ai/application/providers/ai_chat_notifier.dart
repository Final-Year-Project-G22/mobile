import 'dart:async';

import 'package:api_client/api_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/chat_message.dart';
import '../../domain/i_ai_repository.dart';
import 'ai_chat_state.dart';
import 'ai_providers.dart';

final aiChatNotifierProvider = NotifierProvider<AiChatNotifier, AiChatState>(
  AiChatNotifier.new,
);

class AiChatNotifier extends Notifier<AiChatState> {
  StreamSubscription<SseEvent>? _streamSubscription;
  CancelToken? _cancelToken;
  int _idCounter = 0;

  final List<SseEvent> _eventQueue = [];
  bool _frameScheduled = false;

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

    _cancelToken = CancelToken();

    _streamSubscription = repository
        .askStream(
          query: query,
          sessionId: state.sessionId,
          title: isNewSession ? _truncateTitle(query) : null,
          cancelToken: _cancelToken,
        )
        .listen(
          (event) {
            debugPrint(
              '[AI Notifier] event: ${event.type.name} text=${event.text}',
            );
            _eventQueue.add(event);
            _scheduleFrameProcess();
          },
          onError: (Object error) {
            debugPrint(
              '[AI Notifier] stream onError: $error (${error.runtimeType})',
            );
            _handleStreamError();
          },
          onDone: () {
            debugPrint('[AI Notifier] stream onDone');
            _handleStreamDone();
          },
        );
  }

  void _scheduleFrameProcess() {
    if (_frameScheduled) return;
    _frameScheduled = true;
    SchedulerBinding.instance.scheduleFrameCallback((_) {
      _processNextEvent();
    });
  }

  void _processNextEvent() {
    if (_eventQueue.isEmpty) {
      _frameScheduled = false;
      return;
    }

    final event = _eventQueue.removeAt(0);

    if (state.isStreaming) {
      _handleSseEvent(event);
    }

    if (_eventQueue.isNotEmpty || state.isStreaming) {
      SchedulerBinding.instance.scheduleFrameCallback((_) {
        _processNextEvent();
      });
    } else {
      _frameScheduled = false;
    }
  }

  void stopStreaming() {
    _cancelToken?.cancel();
    _cancelToken = null;
    unawaited(_streamSubscription?.cancel());
    _streamSubscription = null;
    _eventQueue.clear();
    _frameScheduled = false;

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
    _cancelToken?.cancel();
    _cancelToken = null;
    unawaited(_streamSubscription?.cancel());
    _streamSubscription = null;
    _eventQueue.clear();
    _frameScheduled = false;

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
    _cancelToken?.cancel();
    _cancelToken = null;
    unawaited(_streamSubscription?.cancel());
    _streamSubscription = null;
    _eventQueue.clear();
    _frameScheduled = false;
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
        _cancelToken = null;
      case SseEventType.error:
        _handleStreamError(message: event.error);
    }
  }

  void _handleStreamDone() {
    _cancelToken = null;
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
    _cancelToken = null;
    _eventQueue.clear();
    _frameScheduled = false;
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
