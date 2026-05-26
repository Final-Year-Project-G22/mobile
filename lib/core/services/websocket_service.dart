import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketService {
  WebSocketService({required Future<String?> Function() tokenProvider})
    : _tokenProvider = tokenProvider;

  final Future<String?> Function() _tokenProvider;
  WebSocketChannel? _channel;
  StreamSubscription<dynamic>? _subscription;
  final _controller = StreamController<Map<String, dynamic>>.broadcast();
  final _connectionStateController =
      StreamController<ConnectionState>.broadcast();

  bool _isDisposed = false;
  bool _isConnecting = false;
  int _reconnectAttempt = 0;
  final _pendingMessages = <String>[];
  Uri? _lastUri;
  final _subscribedThreadIds = <String>{};

  Stream<Map<String, dynamic>> get messages => _controller.stream;
  Stream<ConnectionState> get connectionState =>
      _connectionStateController.stream;

  void subscribeThread(String threadId) {
    _subscribedThreadIds.add(threadId);
    send({'type': 'subscribe', 'threadId': threadId});
  }

  void unsubscribeThread(String threadId) {
    _subscribedThreadIds.remove(threadId);
    send({'type': 'unsubscribe', 'threadId': threadId});
  }

  Future<void> connect(Uri uri) async {
    if (_isDisposed) return;
    if (_channel != null || _isConnecting) {
      if (kDebugMode) {
        debugPrint('[WS] Already connected or connecting, skipping');
      }
      return;
    }

    _isConnecting = true;
    _lastUri = uri;

    final token = await _tokenProvider();
    if (token == null || token.isEmpty) {
      if (kDebugMode) debugPrint('[WS] No token available, will retry connect');
      _isConnecting = false;
      _connectionStateController.add(ConnectionState.disconnected);
      _scheduleReconnect();
      return;
    }

    final uriWithToken = uri.replace(
      queryParameters: {
        ...uri.queryParameters,
        'token': token,
      },
    );

    _connectionStateController.add(ConnectionState.connecting);
    if (kDebugMode) debugPrint('[WS] Connecting to $uriWithToken');

    try {
      _channel = WebSocketChannel.connect(uriWithToken);

      _connectionStateController.add(ConnectionState.connected);
      _reconnectAttempt = 0;
      _isConnecting = false;
      if (kDebugMode) debugPrint('[WS] Connected');

      // Re-subscribe to all active threads
      for (final threadId in _subscribedThreadIds) {
        _channel!.sink.add(jsonEncode({
          'type': 'subscribe',
          'threadId': threadId,
        }));
      }

      // Flush any messages that were sent before connection established.
      final sink = _channel?.sink;
      if (sink != null) {
        _pendingMessages.forEach(sink.add);
      }
      _pendingMessages.clear();

      _subscription = _channel!.stream.listen(
        (data) {
          try {
            final message = jsonDecode(data as String) as Map<String, dynamic>;
            if (kDebugMode) debugPrint('[WS] Received: $message');
            _controller.add(message);
          } on FormatException catch (e) {
            if (kDebugMode) debugPrint('[WS] Failed to parse message: $e');
          }
        },
        onError: (Object error, StackTrace stackTrace) {
          if (kDebugMode) debugPrint('[WS] Error: $error');
          _handleDisconnect();
          _scheduleReconnect();
        },
        onDone: () {
          if (kDebugMode) debugPrint('[WS] Connection closed');
          _handleDisconnect();
          _scheduleReconnect();
        },
      );
    } on Exception catch (e) {
      if (kDebugMode) debugPrint('[WS] Connect failed: $e');
      _isConnecting = false;
      _connectionStateController.add(ConnectionState.disconnected);
      _scheduleReconnect();
    }
  }

  void _handleDisconnect() {
    _channel = null;
    _subscription = null;
    _connectionStateController.add(ConnectionState.disconnected);
  }

  void _scheduleReconnect() {
    if (_isDisposed || _lastUri == null) return;

    final delay = _reconnectDelay(_reconnectAttempt);
    _reconnectAttempt++;
    if (kDebugMode) {
      debugPrint(
        '[WS] Reconnecting in ${delay.inSeconds}s (attempt $_reconnectAttempt)',
      );
    }

    unawaited(Future.delayed(delay, () => connect(_lastUri!)));
  }

  Duration _reconnectDelay(int attempt) {
    const delays = [1, 2, 4, 8, 16];
    final index = min(attempt, delays.length - 1);
    return Duration(seconds: delays[index]);
  }

  void send(Map<String, dynamic> message) {
    final data = jsonEncode(message);
    if (_channel != null) {
      _channel!.sink.add(data);
    } else {
      if (kDebugMode) {
        debugPrint('[WS] Queuing message until connected: $message');
      }
      _pendingMessages.add(data);
    }
  }

  void dispose() {
    _isDisposed = true;
    _subscribedThreadIds.clear();
    _pendingMessages.clear();
    unawaited(_subscription?.cancel());
    unawaited(_channel?.sink.close(status.goingAway));
    unawaited(_controller.close());
    unawaited(_connectionStateController.close());
  }
}

enum ConnectionState { connected, connecting, disconnected }
