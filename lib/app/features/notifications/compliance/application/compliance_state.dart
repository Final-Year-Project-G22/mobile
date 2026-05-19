import 'package:freezed_annotation/freezed_annotation.dart';

import '../domain/entities/calendar_entry.dart';
import '../domain/entities/compliance_entry.dart';

part 'compliance_state.freezed.dart';

@freezed
abstract class ComplianceState with _$ComplianceState {
  const factory ComplianceState({
    @Default([]) List<ComplianceEntry> entries,
    @Default([]) List<CalendarEntry> calendar,
    @Default(false) bool isLoading,
    String? errorMessage,
    String? successMessage,
  }) = _ComplianceState;

  factory ComplianceState.initial() => const ComplianceState();
}
