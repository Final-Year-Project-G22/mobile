import 'dart:async';
import 'dart:convert';

import 'package:api_client/api_client.dart';
import 'package:flutter/foundation.dart';

import '../domain/i_ai_repository.dart';

class SseParser {
  const SseParser();

  Stream<SseEvent> parse(Stream<List<int>> byteStream) {
    final controller = StreamController<SseEvent>();
    var eventType = '';
    var eventData = '';

    byteStream
        .transform(utf8.decoder)
        .transform(const LineSplitter())
        .listen(
          (line) {
            final cleanLine = line.endsWith('\r') ? line.substring(0, line.length - 1) : line;

            if (cleanLine.isEmpty) {
              if (eventType.isNotEmpty && eventData.isNotEmpty) {
                final event = _parseEvent(eventType, eventData);
                debugPrint(
                  '[SSE Parser] parsed: type=$eventType data=$eventData',
                );
                if (event != null) {
                  controller.add(event);
                }
              }
              eventType = '';
              eventData = '';
            } else if (cleanLine.startsWith('event: ')) {
              eventType = cleanLine.substring(7);
            } else if (cleanLine.startsWith('data: ')) {
              if (eventData.isNotEmpty) {
                eventData += '\n';
              }
              eventData += cleanLine.substring(6);
            }
          },
          onError: controller.addError,
          onDone: controller.close,
          cancelOnError: true,
        );

    return controller.stream;
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
    } on FormatException catch (e) {
      debugPrint('[SSE Parser] JSON parse error on type="$eventType": $e');
      return null;
    }
  }
}
