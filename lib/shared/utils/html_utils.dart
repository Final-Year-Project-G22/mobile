String stripHtml(String html) {
  return html
      .replaceAll(RegExp(r'<br\s*/?>'), '\n')
      .replaceAll(RegExp('</p>'), '\n')
      .replaceAll(RegExp('</li>'), '\n')
      .replaceAll(RegExp('</ul>'), '\n')
      .replaceAll(RegExp('</ol>'), '\n')
      .replaceAll(RegExp('</blockquote>'), '\n')
      .replaceAll(RegExp('</div>'), '\n')
      .replaceAll(RegExp('<[^>]*>'), '')
      .replaceAll('&nbsp;', ' ')
      .replaceAll('&amp;', '&')
      .replaceAll('&lt;', '<')
      .replaceAll('&gt;', '>')
      .replaceAll(RegExp(r'\n{3,}'), '\n\n')
      .trim();
}
