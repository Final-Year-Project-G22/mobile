// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'template_item.freezed.dart';
part 'template_item.g.dart';

@Freezed()
abstract class TemplateItem with _$TemplateItem {
  const factory TemplateItem({
    /// MIME type
    required String contentType,

    /// File size in bytes
    required int fileSize,

    /// Template ID
    required String id,

    /// Active flag
    required bool isActive,

    /// Language code
    required String language,

    /// Template title
    required String title,

    /// Version number
    required int version,

    /// Template description
    String? description,
  }) = _TemplateItem;

  factory TemplateItem.fromJson(Map<String, Object?> json) => _$TemplateItemFromJson(json);
}
