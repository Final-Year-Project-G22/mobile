// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'calendar_entry_response.freezed.dart';
part 'calendar_entry_response.g.dart';

@Freezed()
abstract class CalendarEntryResponse with _$CalendarEntryResponse {
  const factory CalendarEntryResponse({
    required DateTime date,
    required int daysRemaining,
    required String id,
    required String status,
    required String title,
    required String type,
    String? referenceNumber,
  }) = _CalendarEntryResponse;

  factory CalendarEntryResponse.fromJson(Map<String, Object?> json) =>
      _$CalendarEntryResponseFromJson(json);
}
