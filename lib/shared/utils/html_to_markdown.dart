/// Converts HTML content to Markdown for rendering with flutter_markdown.
///
/// Handles ordered/unordered lists, paragraphs, inline formatting,
/// links, headings, blockquotes, and code blocks.
String htmlToMarkdown(String html) {
  if (html.isEmpty) return '';

  var text = html;

  // Normalize line endings
  text = text.replaceAll('\r\n', '\n').replaceAll('\r', '\n');

  // Handle <br> tags
  text = text.replaceAll(RegExp(r'<br\s*/?>'), '\n');

  // Handle headings before stripping tags
  for (var i = 6; i >= 1; i--) {
    final prefix = '#' * i;
    text = text.replaceAllMapped(
      RegExp('<h$i[^>]*>(.*?)</h$i>', caseSensitive: false),
      (m) => '\n$prefix ${m.group(1)!.trim()}\n',
    );
  }

  // Handle blockquotes
  text = text.replaceAllMapped(
    RegExp(
      '<blockquote[^>]*>(.*?)</blockquote>',
      dotAll: true,
      caseSensitive: false,
    ),
    (m) {
      final lines = m.group(1)!.trim().split('\n');
      return '\n${lines.map((l) => '> ${l.trim()}').join('\n')}\n';
    },
  );

  // Handle <p> tags — convert to double newlines
  text = text.replaceAll(RegExp('<p[^>]*>'), '\n');
  text = text.replaceAll(RegExp('</p>'), '\n');

  // Handle <pre> blocks
  text = text.replaceAllMapped(
    RegExp('<pre[^>]*>(.*?)</pre>', dotAll: true, caseSensitive: false),
    (m) => '\n```\n${m.group(1)!.trim()}\n```\n',
  );

  // Handle inline <code>
  text = text.replaceAllMapped(
    RegExp('<code[^>]*>(.*?)</code>', caseSensitive: false),
    (m) => '`${m.group(1)}`',
  );

  // Handle ordered lists
  text = _processLists(text, ordered: true);

  // Handle unordered lists
  text = _processLists(text, ordered: false);

  // Handle inline formatting
  text = text.replaceAllMapped(
    RegExp(r'<(strong|b)[^>]*>(.*?)</\1>', caseSensitive: false),
    (m) => '**${m.group(2)}**',
  );
  text = text.replaceAllMapped(
    RegExp(r'<(em|i)[^>]*>(.*?)</\1>', caseSensitive: false),
    (m) => '*${m.group(2)}*',
  );

  // Handle links
  text = text.replaceAllMapped(
    RegExp(r'<a\s+[^>]*href="([^"]*)"[^>]*>(.*?)</a>', caseSensitive: false),
    (m) => '[${m.group(2)}](${m.group(1)})',
  );

  // Handle superscript
  text = text.replaceAllMapped(
    RegExp('<sup[^>]*>(.*?)</sup>', caseSensitive: false),
    (m) => '^${m.group(1)}',
  );

  // Strip remaining HTML tags
  text = text.replaceAll(RegExp('<[^>]*>'), '');

  // Decode HTML entities
  text = text
      .replaceAll('&nbsp;', ' ')
      .replaceAll('&amp;', '&')
      .replaceAll('&lt;', '<')
      .replaceAll('&gt;', '>')
      .replaceAll('&#39;', "'")
      .replaceAll('&quot;', '"');

  // Collapse 3+ newlines to 2
  text = text.replaceAll(RegExp(r'\n{3,}'), '\n\n');

  return text.trim();
}

/// Processes ordered or unordered lists, converting <li> items to
/// numbered or bulleted markdown list items.
String _processLists(String text, {required bool ordered}) {
  final tag = ordered ? 'ol' : 'ul';
  final pattern = RegExp(
    '<$tag[^>]*>(.*?)</$tag>',
    dotAll: true,
    caseSensitive: false,
  );

  return text.replaceAllMapped(pattern, (match) {
    final listContent = match.group(1)!;
    final items = <String>[];

    // Extract <li> items
    final liPattern = RegExp(
      '<li[^>]*>(.*?)</li>',
      dotAll: true,
      caseSensitive: false,
    );

    var counter = 0;
    for (final liMatch in liPattern.allMatches(listContent)) {
      counter++;
      final itemContent = liMatch.group(1)!.trim();
      // Strip any remaining tags from item content
      final cleanContent = itemContent.replaceAll(RegExp('<[^>]*>'), '').trim();
      final prefix = ordered ? '$counter. ' : '- ';
      items.add('$prefix$cleanContent');
    }

    if (items.isEmpty) return '';
    return '\n${items.join('\n')}\n';
  });
}
