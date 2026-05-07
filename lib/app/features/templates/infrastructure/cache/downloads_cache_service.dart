import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class DownloadsCacheService {
  static const _key = 'templates_downloads_cache';

  DownloadsCacheService(this._prefs);
  final SharedPreferences _prefs;

  Future<void> addDownload({
    required String downloadId,
    required String templateId,
    required String groupId,
    required String slug,
    required String title,
    required DateTime downloadedAt,
    String? thumbnailUrl,
  }) async {
    final entries = _getRawEntries()
      ..add({
        'downloadId': downloadId,
        'templateId': templateId,
        'groupId': groupId,
        'slug': slug,
        'title': title,
        'thumbnailUrl': thumbnailUrl,
        'downloadedAt': downloadedAt.toIso8601String(),
      });
    await _prefs.setString(_key, jsonEncode(entries));
  }

  List<DownloadCacheEntry> getDownloads() {
    final entries = _getRawEntries();
    return entries.map(DownloadCacheEntry.fromJson).toList()..sort((a, b) => b.downloadedAt.compareTo(a.downloadedAt));
  }

  DownloadCacheEntry? findByGroupId(String groupId) {
    final downloads = getDownloads();
    for (final d in downloads) {
      if (d.groupId == groupId) return d;
    }
    return null;
  }

  Future<void> clear() async {
    await _prefs.remove(_key);
  }

  List<Map<String, dynamic>> _getRawEntries() {
    final raw = _prefs.getString(_key);
    if (raw == null || raw.isEmpty) return [];
    try {
      final decoded = jsonDecode(raw) as List<dynamic>;
      return decoded.whereType<Map<String, dynamic>>().toList();
    } on Exception {
      return [];
    }
  }
}

class DownloadCacheEntry {
  DownloadCacheEntry({
    required this.downloadId,
    required this.templateId,
    required this.groupId,
    required this.slug,
    required this.title,
    this.thumbnailUrl,
    required this.downloadedAt,
  });

  factory DownloadCacheEntry.fromJson(Map<String, dynamic> json) {
    return DownloadCacheEntry(
      downloadId: json['downloadId'] as String,
      templateId: json['templateId'] as String,
      groupId: json['groupId'] as String,
      slug: json['slug'] as String,
      title: json['title'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String?,
      downloadedAt: DateTime.parse(json['downloadedAt'] as String),
    );
  }

  final String downloadId;
  final String templateId;
  final String groupId;
  final String slug;
  final String title;
  final String? thumbnailUrl;
  final DateTime downloadedAt;
}
