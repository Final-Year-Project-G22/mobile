import 'package:freezed_annotation/freezed_annotation.dart';

import 'conversation_summary.dart';

part 'conversation_list_result.freezed.dart';

@freezed
abstract class ConversationListResult with _$ConversationListResult {
  const factory ConversationListResult({
    required List<ConversationSummary> sessions,
    required int total,
  }) = _ConversationListResult;
}
