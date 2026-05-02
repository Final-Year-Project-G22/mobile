// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'bookmark_with_step_dto.freezed.dart';
part 'bookmark_with_step_dto.g.dart';

@Freezed()
abstract class BookmarkWithStepDto with _$BookmarkWithStepDto {
  const factory BookmarkWithStepDto({
    /// Creation timestamp
    required String createdAt,

    /// Guide name
    required String guideName,

    /// Bookmark ID
    required String id,

    /// Step ID
    required String stepId,

    /// Step title
    required String stepTitle,

    /// Bookmark note
    String? note,
  }) = _BookmarkWithStepDto;

  factory BookmarkWithStepDto.fromJson(Map<String, Object?> json) =>
      _$BookmarkWithStepDtoFromJson(json);
}
