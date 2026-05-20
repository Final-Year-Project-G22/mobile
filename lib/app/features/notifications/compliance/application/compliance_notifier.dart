import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../../core/di/notification_providers.dart';
import 'compliance_state.dart';

part 'compliance_notifier.g.dart';

@riverpod
class ComplianceNotifier extends _$ComplianceNotifier {
  @override
  Future<ComplianceState> build() async {
    final repository = ref.read(complianceRepositoryProvider);
    final result = await repository.getCalendar();
    return result.fold(
      (failure) => ComplianceState.initial(),
      (calendar) => ComplianceState.initial().copyWith(calendar: calendar),
    );
  }

  Future<void> loadEntries(String businessProfileId) async {
    final repository = ref.read(complianceRepositoryProvider);
    final result = await repository.list(businessProfileId: businessProfileId);
    result.fold(
      (failure) {
        state = AsyncValue.data(
          state.value!.copyWith(failure: failure),
        );
      },
      (entries) {
        state = AsyncValue.data(
          state.value!.copyWith(entries: entries),
        );
      },
    );
  }

  Future<void> createEntry({
    required String businessProfileId,
    required String complianceType,
    required DateTime expiryDate,
    required int reminderDaysBefore,
    String? referenceNumber,
    DateTime? issuedDate,
  }) async {
    final repository = ref.read(complianceRepositoryProvider);
    final result = await repository.create(
      businessProfileId: businessProfileId,
      complianceType: complianceType,
      referenceNumber: referenceNumber,
      issuedDate: issuedDate,
      expiryDate: expiryDate,
      reminderDaysBefore: reminderDaysBefore,
    );
    result.fold(
      (failure) {
        state = AsyncValue.data(
          state.value!.copyWith(failure: failure),
        );
      },
      (_) {
        ref.invalidateSelf();
      },
    );
  }

  Future<void> updateEntry(String id, {
    String? referenceNumber,
    DateTime? expiryDate,
    int? reminderDaysBefore,
  }) async {
    final repository = ref.read(complianceRepositoryProvider);
    final result = await repository.update(
      id,
      referenceNumber: referenceNumber,
      expiryDate: expiryDate,
      reminderDaysBefore: reminderDaysBefore,
    );
    result.fold(
      (failure) {
        state = AsyncValue.data(
          state.value!.copyWith(failure: failure),
        );
      },
      (_) {
        if (state.hasValue) {
          state = AsyncValue.data(
            state.value!.copyWith(success: 'updated'),
          );
        }
      },
    );
  }

  Future<void> deleteEntry(String id) async {
    final repository = ref.read(complianceRepositoryProvider);
    final result = await repository.delete(id);
    result.fold(
      (failure) {
        state = AsyncValue.data(
          state.value!.copyWith(failure: failure),
        );
      },
      (_) {
        if (state.hasValue) {
          state = AsyncValue.data(
            state.value!.copyWith(success: 'deleted'),
          );
        }
      },
    );
  }

  Future<void> loadCalendar() async {
    final repository = ref.read(complianceRepositoryProvider);
    final result = await repository.getCalendar();
    result.fold(
      (failure) {
        if (state.hasValue) {
          state = AsyncValue.data(
            state.value!.copyWith(failure: failure),
          );
        }
      },
      (calendar) {
        state = AsyncValue.data(
          (state.value ?? ComplianceState.initial()).copyWith(calendar: calendar),
        );
      },
    );
  }
}
