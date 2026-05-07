import 'package:api_client/api_client.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_message.freezed.dart';

enum ChatRole { user, assistant }

@freezed
abstract class ChatMessage with _$ChatMessage {
  const factory ChatMessage({
    required String id,
    required ChatRole role,
    required String content,
    @Default([]) List<CitationDto> citations,
    @Default(false) bool isStreaming,
    DateTime? createdAt,
  }) = _ChatMessage;
}
