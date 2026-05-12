// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'attachment_dto.freezed.dart';
part 'attachment_dto.g.dart';

@Freezed()
abstract class AttachmentDto with _$AttachmentDto {
  const factory AttachmentDto({
    required String fileName,
    required String fileType,
    required String fileUrl,
    required String id,
    int? fileSize,
  }) = _AttachmentDto;

  factory AttachmentDto.fromJson(Map<String, Object?> json) => _$AttachmentDtoFromJson(json);
}
