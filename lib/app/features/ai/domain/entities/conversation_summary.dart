import 'package:freezed_annotation/freezed_annotation.dart';

part 'conversation_summary.freezed.dart';

@freezed
abstract class ConversationSummary with _$ConversationSummary {
  const factory ConversationSummary({
    required String id,
    required String title,
    required DateTime updatedAt,
  }) = _ConversationSummary;
}
