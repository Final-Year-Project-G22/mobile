import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../../core/di/notification_providers.dart';
import 'notification_preference_state.dart';

part 'notification_preference_notifier.g.dart';

@riverpod
class NotificationPreferenceNotifier
    extends _$NotificationPreferenceNotifier {
  @override
  Future<NotificationPreferenceState> build() async {
    final repo = ref.read(notificationPreferenceRepositoryProvider);
    final result = await repo.get();
    return result.fold(
      (failure) => NotificationPreferenceState(failure: failure),
      (preference) => NotificationPreferenceState(preference: preference),
    );
  }

  Future<void> updatePreferences({
    required bool emailEnabled,
    required bool pushEnabled,
  }) async {
    final previous = state.asData?.value.preference;
    state = AsyncValue.data(
      NotificationPreferenceState(
        preference: state.asData?.value.preference?.copyWith(
          emailEnabled: emailEnabled,
          pushEnabled: pushEnabled,
        ),
      ),
    );

    final repo = ref.read(notificationPreferenceRepositoryProvider);
    final result = await repo.update(
      emailEnabled: emailEnabled,
      pushEnabled: pushEnabled,
    );
    result.fold(
      (failure) {
        state = AsyncValue.data(
          NotificationPreferenceState(
            preference: previous,
            failure: failure,
          ),
        );
      },
      (preference) {
        state = AsyncValue.data(
          NotificationPreferenceState(preference: preference),
        );
      },
    );
  }
}
