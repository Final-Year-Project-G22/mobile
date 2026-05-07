import 'inbox_entry.dart';

class ListInboxResult {
  const ListInboxResult({
    required this.entries,
    required this.page,
    required this.totalPages,
    required this.total,
    required this.pageSize,
  });

  final List<InboxEntry> entries;
  final int page;
  final int totalPages;
  final int total;
  final int pageSize;
}
