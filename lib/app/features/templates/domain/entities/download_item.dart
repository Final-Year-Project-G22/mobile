import 'package:freezed_annotation/freezed_annotation.dart';

part 'download_item.freezed.dart';

@freezed
abstract class DownloadItem with _$DownloadItem {
  const factory DownloadItem({
    required String id,
    required String templateId,
    required String groupId,
    required DateTime downloadedAt,
  }) = _DownloadItem;
}
