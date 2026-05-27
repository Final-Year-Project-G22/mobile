# Thread Muting — Mobile Implementation Plan

## UX

Add a **Mute/Unmute Thread** toggle on the thread details page, placed next to the existing follow/unfollow bell icon in the AppBar.

```
Thread Details
┌─ AppBar ────────────────────────────────┐
│  ← Back   Thread Title   🔔   👁️‍🗨        │
└─────────────────────────────────────────┘
       Follow/Unfollow   Mute/Unmute
```

### Icon mapping

| State | Icon | Tooltip |
|-------|------|---------|
| Not muted | `Icons.visibility` | "Mute Thread" |
| Muted | `Icons.visibility_off` | "Unmute Thread" |

### Behavior

- Toggle calls `POST /api/v1/threads/{id}/mute` or `DELETE /api/v1/threads/{id}/mute`
- Optimistic update: switch icon immediately, revert on failure
- Muting does NOT unfollow
- Unmuting does NOT re-follow
- Follow + Mute = valid combo (track thread, silence notifications)

### States

| Action | Success UI | Failure UI |
|--------|-----------|------------|
| Mute | Icon changes to `visibility_off` | SnackBar "Failed to mute", revert icon |
| Unmute | Icon changes to `visibility` | SnackBar "Failed to unmute", revert icon |

---

## Files to Modify

### 1. Entity — add isMuted field

**File:** `lib/app/features/community/domain/entities/discussion_thread.dart`

Add `bool isMuted` to the freezed class. Default `false`. Run build_runner to regenerate `.freezed.dart` and `.g.dart`.

```dart
@Freezed()
abstract class DiscussionThread with _$DiscussionThread {
  const factory DiscussionThread({
    // ... existing fields
    required bool isMuted,
  }) = _DiscussionThread;

  factory DiscussionThread.fromJson(Map<String, Object?> json) =>
      _$DiscussionThreadFromJson(json);
}
```

Update any existing factory mocks or test data to include `isMuted: false`.

### 2. Repository interface — add mute methods

**File:** `lib/app/features/community/domain/i_community_repository.dart`

```dart
Future<Either<CommunityFailure, void>> muteThread(String threadId);
Future<Either<CommunityFailure, void>> unmuteThread(String threadId);
```

### 3. Repository implementation — add API calls

**File:** `lib/app/features/community/infrastructure/community_repository_impl.dart`

Determine the API client to use. If the thread mute endpoints are under the community module (not notification module), they may need a new Retrofit client or raw Dio calls.

Check existing client setup — if no community client exists, add raw Dio calls:

```dart
@override
Future<Either<CommunityFailure, void>> muteThread(String threadId) async {
  try {
    await dio.post('/api/v1/threads/$threadId/mute');
    return const Right(null);
  } on DioException catch (e) {
    return Left(_mapFailure(e));
  }
}

@override
Future<Either<CommunityFailure, void>> unmuteThread(String threadId) async {
  try {
    await dio.delete('/api/v1/threads/$threadId/mute');
    return const Right(null);
  } on DioException catch (e) {
    return Left(_mapFailure(e));
  }
}
```

If there's already a generated community client, add the methods there and regenerate.

### 4. Notifier — add mute/unmute actions

**File:** `lib/app/features/community/application/providers/community_mutations_provider.dart`

```dart
Future<void> muteThread(String threadId) async {
  final thread = /* find thread in current state */;
  // Optimistic update
  _updateThreadLocally(threadId, isMuted: true);
  
  final result = await ref.read(communityRepositoryProvider).muteThread(threadId);
  result.fold(
    (failure) {
      _updateThreadLocally(threadId, isMuted: false); // revert
      state = AsyncValue.data(
        state.value!.copyWith(failure: failure),
      );
    },
    (_) {},
  );
}

Future<void> unmuteThread(String threadId) async {
  final thread = /* find thread in current state */;
  _updateThreadLocally(threadId, isMuted: false);
  
  final result = await ref.read(communityRepositoryProvider).unmuteThread(threadId);
  result.fold(
    (failure) {
      _updateThreadLocally(threadId, isMuted: true); // revert
      state = AsyncValue.data(
        state.value!.copyWith(failure: failure),
      );
    },
    (_) {},
  );
}
```

Where `_updateThreadLocally` updates the thread in the local state list without a refetch.

### 5. Thread page — add mute toggle

**File:** `lib/app/features/community/presentation/pages/thread_details_page.dart`

In the AppBar's `actions` list, after the existing follow/unfollow `IconButton`:

```dart
IconButton(
  icon: Icon(
    thread.isMuted ? Icons.visibility_off : Icons.visibility,
  ),
  tooltip: thread.isMuted ? 'Unmute Thread' : 'Mute Thread',
  onPressed: () {
    if (thread.isMuted) {
      ref.read(communityMutationsProvider.notifier).unmuteThread(thread.id);
    } else {
      ref.read(communityMutationsProvider.notifier).muteThread(thread.id);
    }
  },
)
```

### 6. API client — Retrofit methods (if using generated client)

**File:** `api_client/lib/src/api/community/community_client.dart` (or similar)

```dart
@POST('/api/v1/threads/{threadId}/mute')
Future<HttpResponse<dynamic>> muteThread(@Path('threadId') String threadId);

@DELETE('/api/v1/threads/{threadId}/mute')
Future<HttpResponse<dynamic>> unmuteThread(@Path('threadId') String threadId);
```

If no community client exists, skip and use raw Dio calls from the repository impl.

---

## What NOT to build

- No "Muted Threads" list page
- No muted threads section in settings
- No muted count badges
- No muted thread search/filter
- No migration of existing data

Mute/unmute is only accessible from the thread details page. If demand grows, a management page can be added later.

---

## Data Flow Summary

```
Tap mute icon
  → communityMutationsProvider.muteThread(id)
      → optimistic: set isMuted = true locally
      → repo.muteThread(id)
          → POST /api/v1/threads/{id}/mute
      ← success: keep optimistic state
      ← failure: revert isMuted = false, show SnackBar

Tap unmute icon
  → communityMutationsProvider.unmuteThread(id)
      → optimistic: set isMuted = false locally
      → repo.unmuteThread(id)
          → DELETE /api/v1/threads/{id}/mute
      ← success: keep optimistic state
      ← failure: revert isMuted = true, show SnackBar

Future notification from muted thread
  → Community service publishes outbox event
  → Notification ingest pipeline
  → ThreadMuteResolver.IsMuted()
      → checks user_thread_settings.is_muted == true
      → sets _isMuted: true on queue payload
  → DeliveryWorker delivers (email/push OK)
      → Inbox entry SKIPPED (muted)
      → User sees nothing in inbox
```

---

## Dependencies

This feature depends on the following backend changes being deployed first:

1. `ThreadMuteResolver` implementation + DI wiring (notification module)
2. `POST /api/v1/threads/{id}/mute` + `DELETE /api/v1/threads/{id}/mute` endpoints (community module)
3. `isMuted` field in `ThreadDTO` response (community module)
4. Community event publishing (outbox entries with itemType/itemId metadata)

The mobile thread mute UI can be built and tested independently as long as the API endpoints exist (step 2). Steps 1 and 4 are not needed for the toggle to work — they only affect whether future notifications are actually suppressed.
