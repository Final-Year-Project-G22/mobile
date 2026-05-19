import 'package:freezed_annotation/freezed_annotation.dart';

part 'calendar_entry.freezed.dart';

@freezed
abstract class CalendarEntry with _$CalendarEntry {
  const factory CalendarEntry({
    required String id,
    required String type,
    required String title,
    required DateTime date,
    required int daysRemaining,
    required String status,
    String? referenceNumber,
  }) = _CalendarEntry;
}
