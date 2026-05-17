import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../../domain/entities/chat_message.dart';
import 'citation_card.dart';
import 'typing_indicator.dart';

class ChatMessageBubble extends StatelessWidget {
  const ChatMessageBubble({
    required this.message,
    super.key,
  });

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isUser = message.role == ChatRole.user;
    final isStreaming = message.isStreaming;
    final isEmpty = message.content.isEmpty && isStreaming;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Row(
        mainAxisAlignment: isUser
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isUser) ...[
            CircleAvatar(
              radius: 14,
              backgroundColor: theme.colorScheme.primaryContainer,
              child: Icon(
                Icons.auto_awesome_rounded,
                size: 16,
                color: theme.colorScheme.onPrimaryContainer,
              ),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.75,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: isUser
                    ? theme.colorScheme.primaryContainer
                    : theme.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(20),
                  topRight: const Radius.circular(20),
                  bottomLeft: isUser
                      ? const Radius.circular(20)
                      : const Radius.circular(4),
                  bottomRight: isUser
                      ? const Radius.circular(4)
                      : const Radius.circular(20),
                ),
              ),
              child: isEmpty
                  ? const Padding(
                      padding: EdgeInsets.symmetric(vertical: 4),
                      child: TypingIndicator(),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (!isUser)
                          MarkdownBody(
                            data: message.content,
                            selectable: true,
                            styleSheet: MarkdownStyleSheet(
                              p: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.onSurface,
                              ),
                              strong: theme.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.onSurface,
                              ),
                              code: theme.textTheme.bodySmall?.copyWith(
                                fontFamily: 'monospace',
                                backgroundColor:
                                    theme.colorScheme.surfaceContainerLow,
                              ),
                              codeblockDecoration: BoxDecoration(
                                color: theme.colorScheme.surfaceContainerLow,
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          )
                        else
                          Text(
                            message.content,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onPrimaryContainer,
                            ),
                          ),
                        if (!isStreaming && message.citations.isNotEmpty) ...[
                          CitationCard(citations: message.citations),
                        ],
                        if (isStreaming && message.content.isNotEmpty)
                          const Padding(
                            padding: EdgeInsets.only(top: 4),
                            child: TypingIndicator(),
                          ),
                      ],
                    ),
            ),
          ),
          if (isUser) ...[
            const SizedBox(width: 8),
            CircleAvatar(
              radius: 14,
              backgroundColor: theme.colorScheme.tertiaryContainer,
              child: Icon(
                Icons.person_rounded,
                size: 16,
                color: theme.colorScheme.onTertiaryContainer,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
