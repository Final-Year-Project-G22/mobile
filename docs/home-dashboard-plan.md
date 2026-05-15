# Home Dashboard — Design & Implementation Plan

## Goal
Replace the current Guide List Page at `/home` with a true home dashboard that gives users a quick overview of their progress, quick access to key app areas, and resumptive content via in-progress and recently viewed guides.

## Problem Statement
The app currently lands on `GuideListPage` after login, which is a search-and-browse experience. There is no centralized dashboard that surfaces the user's overall progress, provides quick actions to jump into any part of the app, or helps them resume guides they've started. New users see a guide list with no context, and returning users have no way to see their aggregate progress at a glance.

## Solution
A home dashboard page at `/home` with five vertically stacked sections:

1. **Hero Circular Completion Graph** — aggregate completion stats for the current month
2. **Business Profile Banner** — conditional prompt to complete onboarding (reuse `CompleteProfileBanner`)
3. **Quick Actions Grid** — 2×2 grid of shortcut cards to the four primary app areas
4. **Continue Where You Left Off** — horizontal rail of in-progress guides with per-guide circular progress rings
5. **Recently Viewed** — horizontal rail of recently accessed guides (reuse `RecentGuideRail`)

## User Stories

1. As a returning user, I want to see my overall completion progress at a glance, so that I know how active I've been this month.
2. As a user, I want one-tap shortcuts to Guides, AI, Community, and Templates, so that I can jump anywhere quickly.
3. As a user with in-progress guides, I want to see them with progress rings, so that I can pick up where I left off.
4. As a user, I want to see recently viewed guides, so that I can quickly revisit them.
5. As a new user with no data, I want to see a welcoming state with quick actions still available, so that I know what to do first.
6. As a user who hasn't completed onboarding, I want a nudge to complete my business profile.
7. As a user, I want pull-to-refresh on the dashboard, so that I can see fresh data.

## Out of Scope (v1)
- Drill-down stats page from the hero graph.
- Customizable quick actions (order or selection).
- Local offline caching of dashboard data.
- Push notifications triggering dashboard updates.
- Date-range picker for the hero graph.

## Navigation Changes

### Bottom Nav
Current (4 tabs):
```
Guide | Community | AI Guide | Templates
```

New (5 tabs):
```
Home | Guide | Community | AI Guide | Templates
```

### Route Changes
| Route | Before | After |
|---|---|---|
| `/home` | `GuideListPage` | **Home Dashboard** (new) |
| `/guides` | — (didn't exist) | `GuideListPage` (new route) |
| `/community` | `CommunityHomePage` | unchanged |
| `/ai-guide` | `AiChatPage` | unchanged |
| `/templates` | `TemplatesListPage` | unchanged |

### Tab Index Mapping
| Index | Tab | Route |
|---|---|---|
| 0 | Home | `/home` |
| 1 | Guide | `/guides` |
| 2 | Community | `/community` |
| 3 | AI Guide | `/ai-guide` (pushes route) |
| 4 | Templates | `/templates` |

## Visual Layout (top → bottom)

```
┌─────────────────────────────────────────┐
│  ┌─────────────────────────────────┐    │
│  │       ╭─────────╮              │    │
│  │       │  68%    │    Monthly   │    │
│  │       │  ◯◯◯◯  │  Completion  │    │
│  │       ╰─────────╯              │    │
│  │  3 completed · 2 in progress   │    │
│  └─────────────────────────────────┘    │
├─────────────────────────────────────────┤
│  ⚠ Complete your business profile  →   │  ← CompleteProfileBanner (conditional)
├─────────────────────────────────────────┤
│  Welcome! Start your first guide to     │  ← empty-state text (conditional)
│  see your progress here.                │
├─────────────────────────────────────────┤
│  Quick Actions                          │
│  ┌──────────┐  ┌──────────┐           │
│  │ 📋 Start │  │ 🤖 Ask   │           │
│  │   Guide  │  │   AI     │           │
│  ├──────────┤  ├──────────┤           │
│  │ 💬 Commu │  │ 📄 Browse│           │
│  │  -nity   │  │Templates │           │
│  └──────────┘  └──────────┘           │
├─────────────────────────────────────────┤
│  Continue Where You Left Off            │
│  ┌──────┐ ┌──────┐ ┌──────┐           │
│  │ ╭──╮ │ │ ╭──╮ │ │ ╭──╮ │           │
│  │ │45│ │ │ │72│ │ │ │10│ │           │
│  │ ╰──╯ │ │ ╰──╯ │ │ ╰──╯ │           │
│  │Guide │ │Guide │ │Guide │           │
│  │Name  │ │Name  │ │Name  │           │
│  └──────┘ └──────┘ └──────┘           │
├─────────────────────────────────────────┤
│  Recently Viewed                        │
│  [card] [card] [card] [card]           │  ← RecentGuideRail (reused)
└─────────────────────────────────────────┘
```

## Components

### 1. CircularProgressRing (shared widget)
A reusable stateless widget:
- Properties: `double percent`, `double size`, `double strokeWidth`, `Color? color`, `String? label`
- Renders a `CircularProgressIndicator`-style ring with percentage text centered inside
- Used in two places: hero graph (large, aggregate) and Continue cards (small, per-guide)

### 2. HeroCompletionGraph
- Uses `CircularProgressRing` at large size (~120px)
- Below: text line showing "X completed · Y in progress"
- Data from `GET /api/v1/guides/completion-stats`
- Tapping: no action (decorative in v1)

### 3. QuickActionsGrid
- 2×2 grid of `QuickActionCard` widgets
- Each card: icon + label, full-width tap target
- Destinations:
  - Start Guide → navigate to `/guides`
  - Ask AI → navigate to `/ai-guide`
  - Community → navigate to `/community`
  - Browse Templates → navigate to `/templates`

### 4. ContinueWhereYouLeftOffRail
- Horizontal `ListView` of cards, up to 5
- Each card: guide icon + name + `CircularProgressRing` (small, ~48px) with % inside
- Tapping → navigate to `/guides/:guideSlug`
- Hidden when empty (no in-progress guides)
- Data from `GET /api/v1/guides/in-progress`

### 5. RecentlyViewedRail
- Reuse existing `RecentGuideRail` widget unchanged
- Data from existing `GET /api/v1/guides/recent` endpoint

## Backend Endpoints

### New: `GET /api/v1/guides/in-progress`
Returns guides the user has started but not completed, with progress data.

**Response body:**
```json
{
  "guides": [
    {
      "id": "string",
      "slug": "string",
      "name": "string",
      "icon": "string?",
      "completedSteps": 3,
      "totalSteps": 7
    }
  ]
}
```

### New: `GET /api/v1/guides/completion-stats`
Returns aggregate completion statistics for the current month.

**Response body:**
```json
{
  "completedGuides": 3,
  "inProgressGuides": 2,
  "totalStepsCompleted": 28,
  "totalStepsAll": 41,
  "period": "monthly"
}
```

## Data Flow

```
HomeDashboardPage
  └── HomeDashboardNotifier (Riverpod)
        ├── repo.getCompletionStats()    → HeroCompletionGraph
        ├── repo.getInProgressGuides()   → ContinueWhereYouLeftOffRail
        ├── repo.getRecentlyViewed()     → RecentlyViewedRail
        └── businessProfileProvider      → BusinessProfileBanner
```

All three dashboard data calls fire in parallel on page load. Pull-to-refresh re-fetches all three.

## State Management

### HomeDashboardNotifier
```
@riverpod
class HomeDashboardNotifier extends _$HomeDashboardNotifier {
  @override
  Future<HomeDashboardState> build() async { ... }
}
```

### HomeDashboardState (freezed)
```dart
@freezed
class HomeDashboardState with _$HomeDashboardState {
  const factory HomeDashboardState({
    required CompletionStats? completionStats,
    required List<GuideWithProgress> inProgressGuides,
    required List<GuideCard> recentlyViewed,
  }) = _HomeDashboardState;
}
```

### GuideWithProgress (new entity)
```dart
class GuideWithProgress {
  final String id;
  final String slug;
  final String name;
  final String? icon;
  final int completedSteps;
  final int totalSteps;
  double get percent => totalSteps > 0 ? completedSteps / totalSteps : 0;
}
```

## Files to Create

| File | Layer |
|---|---|
| `lib/app/features/home/application/home_dashboard_state.dart` | Application |
| `lib/app/features/home/application/home_dashboard_notifier.dart` | Application |
| `lib/app/features/home/presentation/pages/home_dashboard_page.dart` | Presentation |
| `lib/app/features/home/presentation/widgets/home_dashboard_content.dart` | Presentation |
| `lib/app/features/home/presentation/widgets/hero_completion_graph.dart` | Presentation |
| `lib/app/features/home/presentation/widgets/quick_actions_grid.dart` | Presentation |
| `lib/app/features/home/presentation/widgets/continue_where_you_left_off.dart` | Presentation |
| `lib/app/features/home/presentation/widgets/continue_guide_card.dart` | Presentation |
| `lib/app/shared/widgets/circular_progress_ring.dart` | Shared |
| `lib/app/features/guide/domain/entities/guide_with_progress.dart` | Domain |
| `lib/app/features/guide/domain/entities/completion_stats.dart` | Domain |

## Files to Modify

| File | Change |
|---|---|
| `lib/app/features/home/application/home_tab_notifier.dart` | Add `home` tab at index 0 |
| `lib/app/features/home/presentation/pages/home_shell_page.dart` | Add Home tab, retarget Guide tab to `/guides` |
| `lib/app/router/routes.dart` | Add `/guides` route |
| `lib/app/router/routes.g.dart` | Regenerate |
| `lib/app/features/guide/domain/i_guide_repository.dart` | Add `getCompletionStats()`, `getInProgressGuides()` |
| `lib/app/features/guide/infrastructure/guide_repository_impl.dart` | Implement new methods |
| `api_client/lib/src/api/guides/guides_client.dart` | Add endpoint stubs for new APIs |
| `api_client/lib/src/api/guides/guides_client.g.dart` | Regenerate |
| `lib/core/di/guide_providers.dart` | Add provider for `HomeDashboardNotifier` if needed |

---

# Implementation Phases

## Phase 1: Shared Widget + Entity Layer
**Goal:** Build reusable primitives before assembling the page.

### Tasks
1. Create `CircularProgressRing` shared widget
2. Create `GuideWithProgress` entity
3. Create `CompletionStats` entity

### Deliverables
- `circular_progress_ring.dart` — reusable ring with percentage label
- `guide_with_progress.dart` — domain entity for in-progress guides
- `completion_stats.dart` — domain entity for aggregated stats

### Testing
- `CircularProgressRing` renders correctly at different percentages and sizes
- Entity constructors and computed properties work

---

## Phase 2: Repository + State
**Goal:** Data layer and state management for the dashboard.

### Tasks
1. Add `getCompletionStats()` and `getInProgressGuides()` to `IGuideRepository`
2. Add stub implementations in `GuideRepositoryImpl` (return empty/dummy data)
3. Update `GuidesClient` with new endpoint stubs
4. Create `HomeDashboardState` (freezed data class)
5. Create `HomeDashboardNotifier` (Riverpod async notifier)
6. Add necessary providers to `guide_providers.dart`

### Deliverables
- Repository interface methods
- Stub repository implementations returning empty lists
- API client endpoint stubs
- `HomeDashboardState` with `completionStats`, `inProgressGuides`, `recentlyViewed`
- `homeDashboardNotifierProvider` that fetches all three data sources in parallel
- `guideWithProgressProvider` and `completionStatsProvider` if needed

### Testing
- Notifier loads all three data sources on build
- Notifier handles empty/null responses gracefully
- Notifier re-fetches on refresh

---

## Phase 3: Widgets
**Goal:** Build all dashboard section widgets.

### Tasks
1. Build `HeroCompletionGraph`
2. Build `QuickActionsGrid` with four destination cards
3. Build `ContinueGuideCard` (small card with circular progress ring)
4. Build `ContinueWhereYouLeftOffRail` (horizontal list of ContinueGuideCards)
5. Build `HomeDashboardContent` (orchestrates all sections + empty state)

### Deliverables
- `hero_completion_graph.dart` — big ring + stats text, handles null/missing data
- `quick_actions_grid.dart` — 2×2 tappable grid
- `continue_guide_card.dart` — card with mini ring + guide name
- `continue_where_you_left_off.dart` — horizontal scrollable rail, hidden when empty
- `home_dashboard_content.dart` — assembles all sections with conditional visibility

### Testing
- Each widget renders with real and empty data
- Quick actions navigate to correct routes
- Continue card tap navigates to guide detail
- Empty states render correctly

---

## Phase 4: Page + Routing + Navigation
**Goal:** Wire everything together and update navigation.

### Tasks
1. Build `HomeDashboardPage` using `HomeDashboardContent`
2. Add `/guides` route to `routes.dart`
3. Regenerate `routes.g.dart`
4. Update `HomeTabIndex` to include `home` at index 0
5. Update `HomeShellPage` bottom nav to 5 tabs, first tab is Home

### Deliverables
- `home_dashboard_page.dart` — full dashboard page with Scaffold, pull-to-refresh
- Updated routes with `/guides` for `GuideListPage`
- Regenerated route code
- Updated shell page with 5-tab bottom navigation
- Home tab lands on `/home` (dashboard), Guide tab lands on `/guides`

### Testing
- Dashboard renders as default landing page after login
- Guide tab shows GuideListPage at `/guides`
- All bottom nav tabs work correctly
- Pull-to-refresh works on dashboard
- GuideListPage still works from Guide tab

---

## Phase 5: Backend Integration
**Goal:** Connect to real API data.

### Tasks
1. Implement real API calls in `GuideRepositoryImpl` for `getCompletionStats()` and `getInProgressGuides()`
2. Map API response DTOs to domain entities
3. Handle loading, error, and empty states in the dashboard
4. Error handling: show error state or toast on API failure

### Deliverables
- Real API integration in repository impl
- Proper error handling (show error state, allow retry via pull-to-refresh)
- Loading shimmer/skeleton while data fetches

### Testing
- Dashboard loads real data from API
- Handles 401, 404, 500, network errors gracefully
- Performance: three parallel API calls don't block UI
