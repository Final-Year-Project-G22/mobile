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
  final _connectionStateController = StreamController<ConnectionState>.broadcast();

  bool _isDisposed = false;
  bool _isConnecting = false;
  int _reconnectAttempt = 0;
  final _pendingMessages = <String>[];

  Stream<Map<String, dynamic>> get messages => _controller.stream;
  Stream<ConnectionState> get connectionState => _connectionStateController.stream;

  Future<void> connect(Uri uri) async {
    if (_isDisposed) return;
    if (_channel != null || _isConnecting) {
      debugPrint('[WS] Already connected or connecting, skipping');
      return;
    }

    _isConnecting = true;

    final token = await _tokenProvider();
    if (token == null || token.isEmpty) {
      debugPrint('[WS] No token available, will retry connect');
      _isConnecting = false;
      _connectionStateController.add(ConnectionState.disconnected);
      _scheduleReconnect(uri);
      return;
    }

    final uriWithToken = uri.replace(
      queryParameters: {
        ...uri.queryParameters,
        'token': token,
      },
    );

    _connectionStateController.add(ConnectionState.connecting);
    debugPrint('[WS] Connecting to $uriWithToken');

    try {
      _channel = WebSocketChannel.connect(uriWithToken);

      _connectionStateController.add(ConnectionState.connected);
      _reconnectAttempt = 0;
      _isConnecting = false;
      debugPrint('[WS] Connected');

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
            debugPrint('[WS] Received: $message');
            _controller.add(message);
          } on FormatException catch (e) {
            debugPrint('[WS] Failed to parse message: $e');
          }
        },
        onError: (Object error, StackTrace stackTrace) {
          debugPrint('[WS] Error: $error');
          _handleDisconnect();
          _scheduleReconnect(uri);
        },
        onDone: () {
          debugPrint('[WS] Connection closed');
          _handleDisconnect();
          _scheduleReconnect(uri);
        },
      );
    } on Exception catch (e) {
      debugPrint('[WS] Connect failed: $e');
      _isConnecting = false;
      _connectionStateController.add(ConnectionState.disconnected);
      _scheduleReconnect(uri);
    }
  }

  void _handleDisconnect() {
    _channel = null;
    _subscription = null;
    _connectionStateController.add(ConnectionState.disconnected);
  }

  void _scheduleReconnect(Uri uri) {
    if (_isDisposed) return;

    final delay = _reconnectDelay(_reconnectAttempt);
    _reconnectAttempt++;
    debugPrint('[WS] Reconnecting in ${delay.inSeconds}s (attempt $_reconnectAttempt)');

    unawaited(Future.delayed(delay, () => connect(uri)));
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
      debugPrint('[WS] Queuing message until connected: $message');
      _pendingMessages.add(data);
    }
  }

  void dispose() {
    _isDisposed = true;
    _pendingMessages.clear();
    unawaited(_subscription?.cancel());
    unawaited(_channel?.sink.close(status.goingAway));
    unawaited(_controller.close());
    unawaited(_connectionStateController.close());
  }
}

enum ConnectionState { connected, connecting, disconnected }
