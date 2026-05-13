import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class SseService {
  SseService({required Future<String?> Function() tokenProvider}) : _tokenProvider = tokenProvider;

  final Future<String?> Function() _tokenProvider;
  http.Client? _client;
  final _controller = StreamController<Map<String, dynamic>>.broadcast();
  final _connectionStateController = StreamController<ConnectionState>.broadcast();

  bool _isDisposed = false;
  bool _isConnecting = false;
  bool _intentionalDisconnect = false;
  int _reconnectAttempt = 0;
  Timer? _reconnectTimer;
  Uri? _currentUri;

  Stream<Map<String, dynamic>> get events => _controller.stream;
  Stream<ConnectionState> get connectionState => _connectionStateController.stream;

  Future<void> connect(Uri uri) async {
    if (_isDisposed) return;
    if (_isConnecting) {
      debugPrint('[SSE] Already connecting, skipping');
      return;
    }

    _isConnecting = true;
    _intentionalDisconnect = false;
    _currentUri = uri;
    _connectionStateController.add(ConnectionState.connecting);

    try {
      final token = await _tokenProvider();
      if (token == null || token.isEmpty) {
        debugPrint('[SSE] No token available, scheduling reconnect');
        _isConnecting = false;
        _connectionStateController.add(ConnectionState.disconnected);
        _scheduleReconnect();
        return;
      }

      debugPrint('[SSE] Connecting to $uri');

      _client?.close();
      _client = http.Client();

      final uriWithToken = uri.replace(
        queryParameters: {
          ...uri.queryParameters,
          'token': token,
        },
      );

      debugPrint('[SSE] Request URI: ${uriWithToken.replace(queryParameters: {'token': '***'})}');

      final request = http.Request('GET', uriWithToken);
      request.headers['Accept'] = 'text/event-stream';

      final response = await _client!.send(request);

      if (response.statusCode != 200) {
        debugPrint('[SSE] Non-200 response: ${response.statusCode}');
        _isConnecting = false;
        _connectionStateController.add(ConnectionState.disconnected);
        _client?.close();
        _client = null;
        _scheduleReconnect();
        return;
      }

      _isConnecting = false;
      _reconnectAttempt = 0;
      _connectionStateController.add(ConnectionState.connected);
      debugPrint('[SSE] Connected');

      _parseStream(response);
    } on Exception catch (e) {
      debugPrint('[SSE] Connect failed: $e');
      _isConnecting = false;
      _connectionStateController.add(ConnectionState.disconnected);
      _client?.close();
      _client = null;
      _scheduleReconnect();
    }
  }

  void _parseStream(http.StreamedResponse response) {
    String? eventName;
    final dataBuffer = StringBuffer();

    response.stream
        .transform(utf8.decoder)
        .transform(const LineSplitter())
        .listen(
          (line) {
            if (line.startsWith('event: ')) {
              eventName = line.substring(7).trim();
            } else if (line.startsWith('data: ')) {
              dataBuffer.write(line.substring(6));
            } else if (line.isEmpty) {
              if (dataBuffer.isNotEmpty) {
                final name = eventName ?? 'message';
                final data = dataBuffer.toString();
                try {
                  final parsed = jsonDecode(data) as Map<String, dynamic>;
                  _controller.add({
                    'event': name,
                    ...parsed,
                  });
                } on Exception catch (e) {
                  debugPrint('[SSE] Failed to parse event: $e');
                }
              }
              eventName = null;
              dataBuffer.clear();
            }
          },
          onError: (Object error, StackTrace stackTrace) {
            debugPrint('[SSE] Stream error: $error');
            _handleDisconnect();
          },
          onDone: () {
            debugPrint('[SSE] Stream ended');
            _handleDisconnect();
          },
          cancelOnError: false,
        );
  }

  void _handleDisconnect() {
    _client?.close();
    _client = null;
    _connectionStateController.add(ConnectionState.disconnected);
    if (!_intentionalDisconnect) {
      _scheduleReconnect();
    }
  }

  void disconnect() {
    _intentionalDisconnect = true;
    _isConnecting = false;
    _reconnectTimer?.cancel();
    _reconnectTimer = null;
    _client?.close();
    _client = null;
    _connectionStateController.add(ConnectionState.disconnected);
  }

  void _scheduleReconnect() {
    if (_isDisposed) return;
    if (_currentUri == null) return;

    final delay = _reconnectDelay(_reconnectAttempt);
    _reconnectAttempt++;
    debugPrint(
      '[SSE] Reconnecting in ${delay.inSeconds}s (attempt $_reconnectAttempt)',
    );

    _reconnectTimer?.cancel();
    _reconnectTimer = Timer(delay, () => connect(_currentUri!));
  }

  Duration _reconnectDelay(int attempt) {
    const delays = [1, 2, 4, 8, 16];
    final index = min(attempt, delays.length - 1);
    return Duration(seconds: delays[index]);
  }

  void dispose() {
    _isDisposed = true;
    _intentionalDisconnect = true;
    _reconnectTimer?.cancel();
    _reconnectTimer = null;
    _client?.close();
    _client = null;
    unawaited(_controller.close());
    unawaited(_connectionStateController.close());
  }
}

enum ConnectionState { connected, connecting, disconnected }
