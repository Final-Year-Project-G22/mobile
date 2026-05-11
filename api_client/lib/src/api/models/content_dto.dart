// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'post_content_dto.dart';
import 'thread_content_dto.dart';
import 'user_content_dto.dart';

part 'content_dto.freezed.dart';
part 'content_dto.g.dart';

@Freezed()
abstract class ContentDto with _$ContentDto {
  const factory ContentDto({
    /// Post content
    PostContentDto? post,

    /// Thread content
    ThreadContentDto? thread,

    /// User content
    UserContentDto? user,
  }) = _ContentDto;

  factory ContentDto.fromJson(Map<String, Object?> json) => _$ContentDtoFromJson(json);
}
