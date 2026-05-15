# AI & Guide Module — API Update Implementation Plan

## Context
The backend AI and Guide modules have evolved since the mobile app was last synced. The OpenAPI spec on disk is stale. Three areas need attention:
1. **Guide sector/tag taxonomy** — the old "category" concept is replaced by sectors and tags; guide cards must display and support browsing by taxonomy
2. **AI conversations/chat history** — pagination, archive, and language tracking are missing from the current implementation
3. **Stale OpenAPI spec** — needs regenerating to capture all current endpoints, DTOs, and query params

## Principles
- **List guides** stays personalized by business profile (backend-driven)
- **Search guides** stays global keyword search (backend-driven, no taxonomy filter)
- **Sector/tag browsing** is backend-driven via query params (not client-side filtering)
- **AI conversations** need pagination, archive capability, and language tracking
- All changes follow Clean Architecture: domain → infrastructure → application → presentation

---

## Phase 1: Spec Regeneration + API Client Update

**Goal**: Regenerate the OpenAPI spec from the backend and update all generated Dart clients. This unblocks every subsequent phase.

### Step 1.1: Regenerate OpenAPI Spec
1. Navigate to `backend/core-backend/`
2. Run `make spec` — this generates the spec (likely at `docs/openapi.json` or stdout)
3. Copy the output to `mobile/api_client/openapi/openapi.json` (overwrite)
4. Inspect the diff to identify what changed:
   - New/removed endpoints
   - New/removed DTO fields
   - New query params (especially on `listGuides`, `searchGuides`, `listConversations`, `getConversation`)

### Step 1.2: Regenerate Dart API Clients
1. Navigate to `mobile/api_client/`
2. Run `dart run build_runner build --delete-conflicting-outputs`
3. Verify generated clients compile:
   - `GuidesClient` — check for new query params
   - `AiConversationsClient` — check for pagination params (`limit`, `offset`, `messageLimit`, `messageOffset`)
   - `TaxonomyClient` — verify sector/tag list endpoints
   - All model DTOs — check for new fields
4. Navigate to `mobile/` and run `flutter pub get`

### Step 1.3: Audit Generated Types
1. Check `GuideCardDto` — confirm `sectorIds` and `tagIds` are present (already confirmed in current spec)
2. Check `PersonalizedStepDto` — confirm all fields needed for step detail
3. Check `ConversationDto` — confirm `language` field is present (already confirmed)
4. Check `MessageDto` — confirm `citations`, `usage` fields
5. Check `SectorResponse` and `TagResponse` — confirm fields for display (nameEn, nameAm, slug, icon, etc.)
6. Check if `listGuides` and `searchGuides` have new `sectorIds`/`tagIds` query params in the generated client

### Step 1.4: Fix Compilation Errors
1. Run `dart analyze` in `mobile/` — fix any breakage from regenerated types
2. Run `dart analyze` in `mobile/api_client/` — fix any breakage there
3. Commit the spec + regenerated clients as a single commit

**Done Criteria:**
- [ ] `make spec` produces valid OpenAPI JSON
- [ ] `openapi/openapi.json` is updated
- [ ] `dart run build_runner build` succeeds in `api_client/`
- [ ] `flutter pub get` succeeds in `mobile/`
- [ ] `dart analyze` passes in both packages
- [ ] Identified which endpoints have new query params for sector/tag filtering

**Dependencies:** Backend must be buildable (`make spec` works). No mobile-side blocking issues.

---

## Phase 2: AI Conversations — Pagination, Archive, Language Tracking

**Goal**: Fix the AI conversation list and message history to support pagination, add archive capability, and track conversation language.

### Step 2.1: Domain Layer Updates

**File: `lib/app/features/ai/domain/entities/conversation_summary.dart`**
- Add `language` field to `ConversationSummary`
- Current: `{ id, title, updatedAt }`
- New: `{ id, title, updatedAt, language }`

**File: `lib/app/features/ai/domain/entities/chat_message.dart`**
- No changes needed — already has `citations`, `createdAt`

**File: `lib/app/features/ai/domain/i_ai_repository.dart`**
- Update `listConversations()` signature to support pagination:
  ```dart
  Future<Either<AiFailure, ConversationListResult>> listConversations({
    int limit = 20,
    int offset = 0,
  });
  ```
- Create `ConversationListResult` entity: `{ List<ConversationSummary> sessions, int total }`
- Update `getConversation()` signature:
  ```dart
  Future<Either<AiFailure, ConversationResult>> getConversation(
    String sessionId, {
    int messageLimit = 50,
    int messageOffset = 0,
  });
  ```
- Create `ConversationResult` entity: `{ ConversationSummary session, List<ChatMessage> messages, int totalMsgs }`
- Add `archiveConversation()` method:
  ```dart
  Future<Either<AiFailure, Unit>> archiveConversation(String sessionId);
  ```

**File: `lib/app/features/ai/domain/failures/ai_failures.dart`**
- No changes needed

### Step 2.2: Infrastructure Layer Updates

**File: `lib/app/features/ai/infrastructure/ai_repository_impl.dart`**
- Update `listConversations()`:
  - Pass `limit` and `offset` to `AiConversationsClient.listConversations()`
  - Map `sessions` (List<dynamic>) to `List<ConversationDto>` then to `List<ConversationSummary>`
  - Return `ConversationListResult` with `total`
- Update `getConversation()`:
  - Pass `messageLimit` and `messageOffset` to `AiConversationsClient.getConversation()`
  - Map `session` to `ConversationSummary` (include `language`)
  - Map `messages` to `List<ChatMessage>`
  - Return `ConversationResult`
- Add `archiveConversation()`:
  - Call `AiConversationsClient.archiveConversation(sessionId: sessionId)`
  - Return `right(unit)` on success, map DioException on failure

**File: `lib/app/features/ai/infrastructure/sse_parser.dart`**
- No changes needed

### Step 2.3: Application Layer Updates

**File: `lib/app/features/ai/application/providers/ai_conversation_list_provider.dart`**
- Replace `FutureProvider` with a `NotifierProvider` that supports pagination:
  ```dart
  @riverpod
  class ConversationListNotifier extends _$ConversationListNotifier {
    static const pageSize = 20;
    var _allLoaded = false;

    @override
    AsyncValue<ConversationListResult> build() {
      return _loadPage(limit: pageSize, offset: 0);
    }

    Future<AsyncValue<ConversationListResult>> _loadPage({
      required int limit,
      required int offset,
    }) async {
      // ... fetch and append
    }

    Future<void> loadMore() async {
      // load next page if !_allLoaded
    }

    Future<void> refresh() async {
      _allLoaded = false;
      state = await _loadPage(limit: pageSize, offset: 0);
    }

    Future<void> removeConversation(String sessionId) async {
      final repo = ref.read(aiRepositoryProvider);
      final result = await repo.archiveConversation(sessionId);
      result.fold(
        (failure) => /* show error */,
        (_) => ref.invalidateSelf(),
      );
    }
  }
  ```

**File: `lib/app/features/ai/application/providers/ai_chat_notifier.dart`**
- Update `loadConversation()`:
  - Use new `getConversation()` signature with pagination params
  - Store `language` from the session for follow-up messages
- Update `sendMessage()`:
  - Pass `language` from the current conversation's language when continuing a session
  - On new session, default to the app's current locale
- Add stream error recovery:
  - On stream error in an existing conversation, remove the partial assistant message and allow retry
  - Do not corrupt the conversation state with half-streamed content

**File: `lib/app/features/ai/application/providers/ai_providers.dart`**
- No changes needed

### Step 2.4: Presentation Layer Updates

**File: `lib/app/features/ai/presentation/widgets/conversation_history_drawer.dart`**
- Replace `aiConversationListProvider` watch with `conversationListNotifierProvider`
- Add infinite scroll: when user scrolls near bottom, call `loadMore()`
- Add swipe-to-delete or long-press menu to archive conversations:
  - `Dismissible` wrapper with archive icon
  - On dismiss, call `removeConversation(sessionId)` then `ref.invalidate()`
- Update conversation tile to show language indicator (e.g., "EN"/"አማ" badge)

**File: `lib/app/features/ai/presentation/pages/ai_chat_page.dart`**
- No structural changes needed
- Stream error handling: when retry is tapped, remove the partial assistant message and re-send the last user query

### Step 2.5: Localization
Add keys to `app_en.arb` and `app_am.arb`:
| Key | English |
|---|---|
| `aiArchiveConversation` | Archive conversation |
| `aiConversationArchived` | Conversation archived |
| `aiLoadMore` | Load more |
| `aiLanguageEn` | EN |
| `aiLanguageAm` | አማ |

**Done Criteria:**
- [ ] Conversation list supports pagination (infinite scroll in drawer)
- [ ] Conversation archive works (swipe-to-delete or long-press menu)
- [ ] Conversation language is tracked and displayed
- [ ] Stream error recovery works (partial message removed on retry)
- [ ] `dart analyze` passes clean

**Dependencies:** Phase 1 must be complete (regenerated spec with pagination params).

---

## Phase 3: Guide Sector/Tag Display

**Goal**: Display sector and tag information on guide cards so users can see why a guide is relevant to their business profile.

### Step 3.1: Domain Layer Updates

**File: `lib/app/features/guide/domain/entities/guide_card.dart`**
- Add `sectorIds` and `tagIds` fields:
  ```dart
  class GuideCard {
    const GuideCard({
      required this.id,
      required this.slug,
      required this.name,
      this.description,
      this.icon,
      this.sectorIds = const [],
      this.tagIds = const [],
    });

    final String id;
    final String slug;
    final String name;
    final String? description;
    final String? icon;
    final List<String> sectorIds;
    final List<String> tagIds;
  }
  ```

**File: `lib/app/features/guide/domain/entities/sector.dart`** (new)
- Domain entity for sector display:
  ```dart
  class Sector {
    const Sector({
      required this.id,
      required this.slug,
      required this.name,
      this.icon,
      this.description,
    });

    final String id;
    final String slug;
    final String name;
    final String? icon;
    final String? description;
  }
  ```

**File: `lib/app/features/guide/domain/entities/tag.dart`** (new)
- Domain entity for tag display:
  ```dart
  class Tag {
    const Tag({
      required this.id,
      required this.slug,
      required this.name,
      required this.group,
      this.icon,
    });

    final String id;
    final String slug;
    final String name;
    final String group;
    final String? icon;
  }
  ```

### Step 3.2: Infrastructure Layer Updates

**File: `lib/app/features/guide/infrastructure/guide_repository_impl.dart`**
- Update `_mapGuideCard()` to include `sectorIds` and `tagIds`:
  ```dart
  GuideCard _mapGuideCard(GuideCardDto dto) {
    return GuideCard(
      id: dto.id,
      slug: dto.slug,
      name: dto.name,
      description: dto.description,
      icon: dto.icon,
      sectorIds: (dto.sectorIds ?? []).map((e) => e.toString()).toList(),
      tagIds: (dto.tagIds ?? []).map((e) => e.toString()).toList(),
    );
  }
  ```

### Step 3.3: Application Layer Updates

**File: `lib/app/features/guide/application/guide_list_notifier.dart`**
- Add sector/tag cache loading on build:
  ```dart
  Future<void> _loadTaxonomy() async {
    final taxRepo = ref.read(taxonomyRepositoryProvider);
    final sectorsResult = await taxRepo.listSectors();
    final tagsResult = await taxRepo.listTags();
    // cache for display
  }
  ```
- No changes to filtering logic (backend handles personalization)

**File: `lib/core/di/` — add taxonomy provider** (new)
- Create a provider for `TaxonomyClient` that the guide feature can read:
  ```dart
  @riverpod
  TaxonomyClient taxonomyClient(Ref ref) {
    final apiClient = ref.read(apiClientProvider);
    return TaxonomyClient(apiClient.dio);
  }
  ```

### Step 3.4: Presentation Layer Updates

**File: `lib/app/features/guide/presentation/widgets/guide_card.dart`**
- Add sector/tag badges below the guide name/description:
  - Show sector icon + name (first sector only, or "N sectors" if multiple)
  - Show up to 2 tag badges with group-aware styling
  - Use compact chips with sector/tag names

**File: `lib/app/features/guide/presentation/widgets/sector_tag_badge.dart`** (new)
- Small badge widget for displaying a sector or tag:
  - Sector: icon + name, primary color
  - Tag: name only, outlined chip, color by group

### Step 3.5: Localization
Add keys to `app_en.arb` and `app_am.arb`:
| Key | English |
|---|---|
| `guideSectors` | {count} sectors |
| `guideTags` | Tags |

**Done Criteria:**
- [ ] `GuideCard` entity includes `sectorIds` and `tagIds`
- [ ] Guide cards display sector/tag badges
- [ ] `dart analyze` passes clean

**Dependencies:** Phase 1 must be complete. Does not depend on Phase 2.

---

## Phase 4: Guide Sector/Tag Browsing

**Goal**: Allow users to browse guides by selecting sectors and tags, with filtering handled by the backend.

### Step 4.1: Prerequisite Check
- Verify the regenerated `GuidesClient` has `sectorIds` and `tagIds` query params on `listGuides()` and/or `searchGuides()`
- If NOT present, this phase requires a backend change first — add optional query params to the backend endpoints

### Step 4.2: Domain Layer Updates

**File: `lib/app/features/guide/domain/i_guide_repository.dart`**
- Add new methods:
  ```dart
  Future<Either<GuideFailure, List<GuideCard>>> listGuides({
    String? locale,
    List<String>? sectorIds,
    List<String>? tagIds,
  });

  Future<Either<GuideFailure, List<Sector>>> listSectors();
  Future<Either<GuideFailure, List<Tag>>> listTags();
  ```

### Step 4.3: Infrastructure Layer Updates

**File: `lib/app/features/guide/infrastructure/guide_repository_impl.dart`**
- Implement `listGuides()` with sector/tag query params
- Implement `listSectors()`:
  - Call `TaxonomyClient.listTaxonomySectors()`
  - Map `SectorResponse` to domain `Sector`
- Implement `listTags()`:
  - Call `TaxonomyClient.listTaxonomyTags()`
  - Map `TagResponse` to domain `Tag`

### Step 4.4: Application Layer Updates

**File: `lib/app/features/guide/application/guide_state.dart`**
- Add taxonomy filter state:
  ```dart
  class GuideListState {
    // ... existing fields
    final List<Sector> sectors;
    final List<Tag> tags;
    final String? selectedSectorId;
    final List<String> selectedTagIds;
    final bool isLoadingTaxonomy;
  }
  ```

**File: `lib/app/features/guide/application/guide_list_notifier.dart`**
- Load sectors/tags on build
- Add `selectSector(String? sectorId)` method
- Add `toggleTag(String tagId)` method
- When sector/tag selection changes, call `listGuides()` with the selected filters
- Clear filters resets to personalized list

### Step 4.5: Presentation Layer Updates

**File: `lib/app/features/guide/presentation/widgets/category_filter_chips.dart`**
- Replace with `SectorFilterChips` widget:
  - Horizontal scrollable chips for sectors
  - "All" chip to clear selection
  - Uses `Sector.name` (localized based on app locale)

**File: `lib/app/features/guide/presentation/widgets/tag_filter_chips.dart`** (new)
- Horizontal scrollable chips for tags
- Grouped by tag group (e.g., Legal Structure, Tax Status)
- Multi-select support
- Uses `Tag.name` (localized)

**File: `lib/app/features/guide/presentation/pages/guide_list_page.dart`**
- Replace the empty `categories` list with sector chips from state
- Add tag filter chips below sector chips
- Wire `selectSector` and `toggleTag` to notifier
- Show loading state while taxonomy is being fetched

### Step 4.6: Localization
Add keys to `app_en.arb` and `app_am.arb`:
| Key | English |
|---|---|
| `allSectors` | All Sectors |
| `filterByTags` | Filter by tags |
| `clearFilters` | Clear filters |

**Done Criteria:**
- [ ] Sector filter chips render with data from backend
- [ ] Tag filter chips render with data from backend
- [ ] Selecting a sector filters guides (backend-driven)
- [ ] Selecting tags filters guides (backend-driven)
- [ ] "All" chip clears sector filter
- [ ] Clear filters button resets all selections
- [ ] `dart analyze` passes clean

**Dependencies:** Phase 1 (spec regeneration) AND backend must have sector/tag query params on guide endpoints. Phase 3 should be complete first.

---

## Execution Order

```
Phase 1: Spec Regeneration + API Client Update
    ↓
Phase 2: AI Conversations (pagination, archive, language)    Phase 3: Guide Sector/Tag Display
    ↓                                                            ↓
Phase 4: Guide Sector/Tag Browsing (depends on Phase 1 + 3 + backend)
```

Phases 2 and 3 can be done in parallel since they touch different feature modules. Phase 4 depends on Phase 3 (display) and Phase 1 (spec with query params).

## Risk Register

| Risk | Impact | Mitigation |
|---|---|---|
| Backend doesn't have sector/tag query params on guide endpoints | Blocks Phase 4 | Check during Phase 1. If missing, implement client-side filtering as fallback or coordinate backend change |
| Regenerated spec has breaking type changes | Compilation errors across app | Audit in Phase 1.3. Fix incrementally before proceeding |
| AI conversation pagination params missing from spec | Blocks Phase 2 | Check during Phase 1. If missing, add manual Retrofit client methods |
| Taxonomy API returns large payloads | Slow guide list load | Use pagination on sector/tag list endpoints (already supported) |
