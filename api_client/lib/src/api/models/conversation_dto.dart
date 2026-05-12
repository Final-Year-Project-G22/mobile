// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'conversation_dto.freezed.dart';
part 'conversation_dto.g.dart';

@Freezed()
abstract class ConversationDto with _$ConversationDto {
  const factory ConversationDto({
    required String accountId,
    required DateTime createdAt,
    required String id,
    required String language,
    required String title,
    required DateTime updatedAt,
  }) = _ConversationDto;

  factory ConversationDto.fromJson(Map<String, Object?> json) =>
      _$ConversationDtoFromJson(json);
}
