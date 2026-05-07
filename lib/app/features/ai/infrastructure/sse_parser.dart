import 'dart:async';
import 'dart:convert';

import 'package:api_client/api_client.dart';

import '../domain/i_ai_repository.dart';

class SseParser {
  const SseParser();

  Stream<SseEvent> parse(Stream<List<int>> byteStream) {
    final buffer = StringBuffer();
    var incompleteLineLength = 0;

    return byteStream.transform(utf8.decoder).expand((chunk) {
      buffer.write(chunk);
      final data = buffer.toString();
      buffer.clear();

      final events = <SseEvent>[];
      final lines = data.split('\n');

      var eventType = '';
      var eventData = '';

      for (var i = 0; i < lines.length; i++) {
        var line = lines[i];

        if (i == 0 && incompleteLineLength > 0) {
          line = '${' ' * incompleteLineLength}$line';
          incompleteLineLength = 0;
        }

        if (line.startsWith('event: ')) {
          eventType = line.substring(7).trim();
        } else if (line.startsWith('data: ')) {
          eventData = line.substring(6);
        } else if (line.isEmpty) {
          if (eventType.isNotEmpty && eventData.isNotEmpty) {
            final event = _parseEvent(eventType, eventData);
            if (event != null) {
              events.add(event);
            }
          }

          eventType = '';
          eventData = '';
        }
      }

      if (eventType.isNotEmpty && eventData.isNotEmpty) {
        final event = _parseEvent(eventType, eventData);
        if (event != null) {
          events.add(event);
        }
      }

      if (!chunk.endsWith('\n') && lines.isNotEmpty) {
        buffer.write(lines.last);
        for (var i = 0; i < lines.length - 1; i++) {
          if (i == lines.length - 1) break;
        }
      }

      return events;
    });
  }

  SseEvent? _parseEvent(String eventType, String eventData) {
    try {
      final json = jsonDecode(eventData) as Map<String, dynamic>;

      switch (eventType) {
        case 'chunk':
          return SseEvent(
            type: SseEventType.chunk,
            text: json['text'] as String?,
          );
        case 'citations':
          final citationsList = json['citations'] as List<dynamic>?;
          return SseEvent(
            type: SseEventType.citations,
            citations: citationsList?.map((c) => CitationDto.fromJson(c as Map<String, dynamic>)).toList(),
          );
        case 'done':
          return SseEvent(
            type: SseEventType.done,
            sessionId: json['sessionId'] as String?,
          );
        case 'error':
          return SseEvent(
            type: SseEventType.error,
            error: json['message'] as String? ?? 'An error occurred',
          );
        default:
          return null;
      }
    } on FormatException {
      return null;
    }
  }
}
