import 'dart:async';
import 'dart:math';

import 'package:api_client/api_client.dart';
import 'package:dartz/dartz.dart';

import '../domain/entities/chat_message.dart';
import '../domain/entities/conversation_summary.dart';
import '../domain/failures/ai_failures.dart';
import '../domain/i_ai_repository.dart';

final _random = Random();

const _response1 =
    'Here are the steps to register a business in Ethiopia:\n\n'
    '1. **Reserve your company name** at the Ministry of Trade and Regional Integration.\n'
    '2. **Prepare your documents** including memorandum of association, articles of association, and ID copies.\n'
    '3. **Register for a TIN** (Tax Identification Number) with the Ministry of Revenues.\n'
    '4. **Obtain your business license** from the appropriate government body.\n'
    '5. **Register for VAT** if your annual turnover exceeds 2 million ETB.\n\n'
    'Is there a specific step you would like more detail on?';

const _response2 =
    'Tax obligations for businesses in Ethiopia include:\n\n'
    '| Tax Type | Rate | Threshold |\n'
    '|----------|------|-----------|\n'
    '| VAT | 15% | >2M ETB annual turnover |\n'
    '| Turnover Tax (TOT) | 2-10% | <2M ETB annual turnover |\n'
    '| Corporate Income Tax | 30% | All registered businesses |\n'
    '| Excise Tax | Varies | Specific goods |\n\n'
    'Remember to file monthly VAT returns by the 30th of the following month.';

const _response3 =
    'To hire employees in Ethiopia, you need to:\n\n'
    '1. Draft an **employment contract** compliant with Ethiopian Labour Proclamation No. 1156/2011.\n'
    "2. Register employees with the **Private Organization Employees' Pension Fund**.\n"
    '3. Contribute **7% employee + 11% employer** for pension.\n'
    '4. Provide **annual leave** (14 working days minimum).\n'
    "5. Enroll in **workers' compensation insurance**.\n\n"
    'Would you like a template employment contract?';

const _response4 =
    'Opening a bank account for your business in Ethiopia requires:\n\n'
    '- **Business License** (original + copy)\n'
    '- **TIN Certificate**\n'
    '- **Memorandum & Articles of Association**\n'
    '- **Board resolution** authorizing account opening (for companies)\n'
    '- **Valid ID** of authorized signatories\n\n'
    'Most major banks like CBE, Awash, Dashen, and Abyssinia offer business accounts. '
    'CBE is often required for government-related transactions.';

const _mockResponses = <String>[_response1, _response2, _response3, _response4];

final _mockConversations = <ConversationSummary>[
  ConversationSummary(
    id: 'conv-001',
    title: 'Business registration steps',
    updatedAt: DateTime.now().subtract(const Duration(minutes: 5)),
  ),
  ConversationSummary(
    id: 'conv-002',
    title: 'Tax filing deadlines 2026',
    updatedAt: DateTime.now().subtract(const Duration(hours: 2)),
  ),
  ConversationSummary(
    id: 'conv-003',
    title: 'How to hire employees',
    updatedAt: DateTime.now().subtract(const Duration(days: 1)),
  ),
  ConversationSummary(
    id: 'conv-004',
    title: 'Bank account requirements',
    updatedAt: DateTime.now().subtract(const Duration(days: 3)),
  ),
  ConversationSummary(
    id: 'conv-005',
    title: 'Import export license process',
    updatedAt: DateTime.now().subtract(const Duration(days: 7)),
  ),
];

class MockAiRepository implements IAiRepository {
  @override
  Stream<SseEvent> askStream({
    required String query,
    String? sessionId,
    String? title,
  }) async* {
    final response = _mockResponses[_random.nextInt(_mockResponses.length)];
    final words = response.split(' ');

    for (var i = 0; i < words.length; i++) {
      await Future<void>.delayed(const Duration(milliseconds: 40));
      final chunk = i < words.length - 1 ? '${words[i]} ' : words[i];
      yield SseEvent(
        type: SseEventType.chunk,
        text: chunk,
      );
    }

    yield const SseEvent(
      type: SseEventType.citations,
      citations: [
        CitationDto(
          chunkId: 'chunk-1',
          documentId: 'doc-1',
          score: 0.95,
          sourceType: 'guide',
          title: 'Business Registration Guide',
        ),
        CitationDto(
          chunkId: 'chunk-2',
          documentId: 'doc-2',
          score: 0.87,
          sourceType: 'legal',
          title: 'Ethiopian Commercial Code',
        ),
      ],
    );

    yield SseEvent(
      type: SseEventType.done,
      sessionId: sessionId ?? 'conv-${_random.nextInt(9999)}',
    );
  }

  @override
  Future<Either<AiFailure, List<ConversationSummary>>> listConversations() async {
    await Future<void>.delayed(const Duration(milliseconds: 800));
    return right(_mockConversations);
  }

  @override
  Future<Either<AiFailure, List<ChatMessage>>> getConversation(
    String sessionId,
  ) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));

    final conversation = _mockConversations.firstWhere(
      (c) => c.id == sessionId,
      orElse: () => _mockConversations.first,
    );

    return right([
      ChatMessage(
        id: 'msg-1',
        role: ChatRole.user,
        content: conversation.title,
        createdAt: conversation.updatedAt.subtract(const Duration(minutes: 5)),
      ),
      ChatMessage(
        id: 'msg-2',
        role: ChatRole.assistant,
        content: _mockResponses[_random.nextInt(_mockResponses.length)],
        citations: const [
          CitationDto(
            chunkId: 'chunk-1',
            documentId: 'doc-1',
            score: 0.95,
            sourceType: 'guide',
            title: 'Business Registration Guide',
          ),
        ],
        createdAt: conversation.updatedAt,
      ),
    ]);
  }
}
