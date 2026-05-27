# Notification Preferences — Mobile Plan

## Goal

Add a page in Settings where users toggle global email and push notification preferences. In-app is always-on (no toggle). Toggles take effect immediately — no save button.

## UX

### Entry point

Settings page (`/settings`): add a `ListTile` "Notification Preferences" between Language and Theme, navigates to `/notifications/preferences`.

### Page layout

```
┌─── Notification Preferences ────┐
│                                  │
│  In-app notifications            │
│  Always enabled                  │
│                                  │
│  ● Email Notifications           │
│  ─────────────────────────────── │
│                                  │
│  ● Push Notifications            │
│  ─────────────────────────────── │
│                                  │
└──────────────────────────────────┘
```

- In-app: shown as a disabled `ListTile` with "Always enabled" subtitle — informational only
- Email/Push: `SwitchListTile` widgets. Toggle immediately fires PUT, no save button
- Error: `SnackBar` on API failure
- Loading: `CircularProgressIndicator` centered while fetching initial state

### States

| State | UI |
|-------|----|
| Loading | Centered spinner |
| Loaded | Three list tiles with toggles |
| Error (load) | Error card + Retry button |
| Error (toggle) | Snackbar "Failed to update preference", revert switch |
| Success (toggle) | Switch stays in new position |

## Files to Create/Modify

### New files

| Layer | File | Content |
|-------|------|---------|
| Entity | `domain/entities/notification_preference.dart` | Freezed: `emailEnabled`, `pushEnabled` |
| Failure | `domain/failures/notification_preference_failure.dart` | Freezed union: `apiError(String)`, `notFound`, `unknown` |
| Repository interface | `domain/i_notification_preference_repository.dart` | `get()`, `update(emailEnabled, pushEnabled)` |
| Repository impl | `infrastructure/notification_preference_repository_impl.dart` | Raw Dio calls to GET/PUT `/api/v1/notifications/global-preferences` |
| State | `application/notification_preference_state.dart` | Freezed: `preference`, `isLoading`, `failure`, `success` |
| Notifier | `application/notification_preference_notifier.dart` | Riverpod `Notifier`: load on build, `update()` → PUT → invalidate self |
| Page | `presentation/pages/notification_preferences_page.dart` | ConsumerWidget with 3 list tiles |
| ARB keys | `lib/core/l10n/app_en.arb` + `app_am.arb` | 4 new keys |

### Modified files

| File | Change |
|------|--------|
| `lib/core/di/notification_providers.dart` | Add `notificationPreferenceRepositoryProvider` |
| `lib/core/l10n/app_en.arb` | Add keys |
| `lib/core/l10n/app_am.arb` | Add Amharic translations |
| `lib/app/features/settings/presentation/pages/settings_page.dart` | Add ListTile to navigate to preferences |
| `lib/app/router/routes.dart` | Add `NotificationPreferencesRoute` → `/notifications/preferences` |

## ARB Keys

```json
// app_en.arb
"notificationPreferences": "Notification Preferences",
"emailNotifications": "Email Notifications",
"pushNotifications": "Push Notifications",
"inAppAlwaysOn": "Always enabled",

// app_am.arb
"notificationPreferences": "የማሳወቂያ ምርጫዎች",
"emailNotifications": "የኢሜይል ማሳወቂያዎች",
"pushNotifications": "የግፋ ማሳወቂያዎች",
"inAppAlwaysOn": "ሁልጊዜ ነቅቷል",
```

## API Contract

### GET /api/v1/notifications/global-preferences

```json
// 200 OK
{
  "emailEnabled": true,
  "pushEnabled": false
}
```

### PUT /api/v1/notifications/global-preferences

```json
// Request
{
  "emailEnabled": true,
  "pushEnabled": false
}

// 200 OK
{
  "emailEnabled": true,
  "pushEnabled": false
}
```

## DI

```dart
// notification_providers.dart (new provider)
@riverpod
INotificationPreferenceRepository notificationPreferenceRepository(Ref ref) {
  final apiClient = ref.read(apiClientProvider);
  return NotificationPreferenceRepositoryImpl(apiClient.dio);
}
```

## Navigation

```dart
// routes.dart
@TypedGoRoute<NotificationPreferencesRoute>(
  path: '/notifications/preferences',
)
class NotificationPreferencesRoute extends GoRouteData {
  const NotificationPreferencesRoute();
  ...
}
```

## Notifier Pattern

```dart
@riverpod
class NotificationPreferenceNotifier extends _$NotificationPreferenceNotifier {
  @override
  Future<NotificationPreference> build() async {
    final repo = ref.read(notificationPreferenceRepositoryProvider);
    return repo.get();
  }

  Future<void> update({bool? emailEnabled, bool? pushEnabled}) async {
    final repo = ref.read(notificationPreferenceRepositoryProvider);
    final current = state.requireValue;
    final updated = current.copyWith(
      emailEnabled: emailEnabled ?? current.emailEnabled,
      pushEnabled: pushEnabled ?? current.pushEnabled,
    );
    state = AsyncValue.data(updated); // optimistic
    final result = await repo.update(updated.emailEnabled, updated.pushEnabled);
    result.fold(
      (failure) {
        state = AsyncValue.data(current); // revert
        // caller shows SnackBar
      },
      (_) {},
    );
  }
}
```

Optimistic update + revert on failure ensures the switch doesn't flicker.

## Backend counterpart

See `backend/core-backend/docs/notification_preferences.md`.
