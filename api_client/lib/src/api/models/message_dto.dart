// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'usage_dto.dart';

part 'message_dto.freezed.dart';
part 'message_dto.g.dart';

@Freezed()
abstract class MessageDto with _$MessageDto {
  const factory MessageDto({
    required String content,
    required DateTime createdAt,
    required String id,
    required String role,
    List<dynamic>? citations,
    UsageDto? usage,
  }) = _MessageDto;

  factory MessageDto.fromJson(Map<String, Object?> json) => _$MessageDtoFromJson(json);
}
