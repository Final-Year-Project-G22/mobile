import 'package:freezed_annotation/freezed_annotation.dart';

part 'download_result.freezed.dart';

@freezed
class DownloadResult with _$DownloadResult {
  const factory DownloadResult({
    required String presignedUrl,
    required DateTime expiresAt,
    required String filename,
  }) = _DownloadResult;
}
