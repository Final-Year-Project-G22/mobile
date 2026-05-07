# Guide Module — Implementation Plan

## Goal
Add a guide browsing and learning module that lets users discover guides by category, search for guides, view guide steps with personalized progress, and interact with step details including markdown content and step actions (start, complete, skip, bookmark).

## Scope
- Three new pages: Guide List, Guide Detail (steps), Step Detail.
- Clean architecture feature module (`lib/app/features/guide/`).
- Category tree exploration with nested guides (from backend).
- Search guides by keyword.
- Recently viewed guide quick-access rail.
- Bookmark toggle and bookmark list.
- Vertical stepper timeline with progress bar for guide steps.
- Step detail page with rendered markdown content and status-based actions.
- Full localization (English + Amharic).
- Three-phase implementation: dummy data → API + state → bug fixes.

## Out of Scope (v1)
- Progress-status filter on guide list.
- Offline support for guide content.
- Step dependency visualization.
- Document upload within step completion.
- Per-step analytics and time tracking UI.
- Category-based search filtering (backend search endpoint doesn't support it yet).

## Feature Flow
1. User navigates to Guides tab.
2. Guide List page shows: search bar → recent rail → category chips → bookmark toggle → guide cards.
3. User taps a guide → Guide Detail page with progress bar and vertical step timeline.
4. User taps a step → Step Detail page with markdown content and action bar.
5. After completing/skipping a step → auto-navigate back to Guide Detail with refreshed state.
6. User can bookmark steps for quick access.

## Pages

### 1. Guide List Page
- Top search bar with text input and clear button.
- Horizontal "Recently Viewed" rail (up to 5 items, hidden if empty).
- Horizontal category filter chips (single select, "All" default). UI-only in v1; categories derived from category tree endpoint. Tapping a chip filters the list client-side.
- "Bookmarked" toggle chip — when active, shows only bookmarked steps.
- Grid/list of `GuideCard` widgets showing: icon, name, description.
- "No results" empty state.

### 2. Guide Detail Page (Steps)
- Progress bar at top: "X of Y completed · Z%" with linear progress indicator.
- Vertical stepper timeline:
  - Connecting line on left side between steps.
  - Step number in circle: green + checkmark for completed, bordered/highlighted for current, grey + lock for locked.
  - Each step tile shows: title, short description, estimated time, status badge.
- Tap a step → navigate to Step Detail page.
- Status indicators: Locked, In Progress, Completed, Skipped.

### 3. Step Detail Page
- AppBar with step title and status badge.
- Estimated time chip.
- Scrollable markdown content body (rendered via `flutter_markdown`).
- Bottom action bar with status-dependent buttons:
  - **Locked**: disabled message "Complete previous steps first".
  - **In Progress**: "Complete" primary button, "Skip" secondary (if optional), bookmark toggle.
  - **Completed**: completion timestamp, "Mark Incomplete" button.
  - **Skipped**: skip reason text, "Start" button to re-enter.
- Back navigation returns to Guide Detail with refreshed progress.

## Data Sources (API)

| Endpoint | Method | Purpose | Auth |
|---|---|---|---|
| `/api/v1/guides/categories/tree` | GET | Category tree with nested guides | No |
| `/api/v1/guides/search` | GET | Search guides by keyword | No |
| `/api/v1/guides/recent` | GET | Recently viewed guides | Yes |
| `/api/v1/guides/bookmarks` | GET | List bookmarked steps | Yes |
| `/api/v1/guides/{guideSlug}` | GET | Personalized guide with steps + progress | Yes |
| `/api/v1/guides/steps/{stepId}/start` | POST | Start a step | Yes |
| `/api/v1/guides/steps/{stepId}/complete` | POST | Complete a step | Yes |
| `/api/v1/guides/steps/{stepId}/skip` | POST | Skip optional step | Yes |
| `/api/v1/guides/steps/{stepId}/mark-incomplete` | POST | Reset step to in-progress | Yes |
| `/api/v1/guides/steps/{stepId}/progress` | PATCH | Update progress details | Yes |
| `/api/v1/guides/steps/{stepId}/bookmark` | POST / DELETE | Toggle bookmark | Yes |

### Backend Gap
- `detailedContent` (markdown) field exists on `GuideStepTranslation` entity but is not returned in the user-facing `getPersonalizedGuide` response. Needs backend addition before Phase 2.

## File Structure (Clean Architecture)

```
lib/app/features/guide/
├── domain/
│   ├── entities/
│   │   ├── guide_card.dart
│   │   ├── guide_category.dart
│   │   ├── guide_detail.dart
│   │   ├── guide_step.dart
│   │   └── step_bookmark.dart
│   └── failures/
│       └── guide_failures.dart
├── application/
│   ├── guide_list_notifier.dart
│   ├── guide_detail_notifier.dart
│   ├── step_detail_notifier.dart
│   └── guide_state.dart
├── infrastructure/
│   └── guide_dummy_data.dart
└── presentation/
    ├── pages/
    │   ├── guide_list_page.dart
    │   ├── guide_detail_page.dart
    │   └── step_detail_page.dart
    └── widgets/
        ├── guide_card.dart
        ├── recent_guide_rail.dart
        ├── category_filter_chips.dart
        ├── guide_progress_bar.dart
        ├── step_timeline_tile.dart
        └── step_action_bar.dart
```

## State Management (Riverpod)

Three providers using `@riverpod` code generation:

### GuideListNotifier
- State: `guides[]`, `categories[]`, `recentGuides[]`, `bookmarks[]`, `searchQuery`, `selectedCategorySlug`, `showBookmarked`, `isLoading`.
- Actions: `search(query)`, `selectCategory(slug)`, `toggleBookmarked()`, `fetchRecent()`, `refresh()`.

### GuideDetailNotifier
- State: `guide` (GuideDetail), `steps[]`, `progress` (GuideProgressSummary), `isLoading`.
- Actions: `loadGuide(slug)`, `refresh()`.

### StepDetailNotifier
- State: `step` (GuideStep with detailedContent), `isLoading`, `actionInProgress`.
- Actions: `loadStep(guideSlug, stepSlug)`, `startStep()`, `completeStep()`, `skipStep()`, `markIncomplete()`, `toggleBookmark()`.

## Routing

New typed GoRoute entries:
- `/guides` → `GuideListPage`
- `/guides/:guideSlug` → `GuideDetailPage`
- `/guides/:guideSlug/step/:stepSlug` → `StepDetailPage`

Routes sit inside `MainAppShellRoute` (bottom nav shell). The existing "Guide" placeholder tab in `Home` gets wired to `/guides`.

## Phase 1: Dummy Data

### 3 Categories
1. "Business Registration" — starting a business legally.
2. "Tax & Compliance" — understanding and filing taxes.
3. "Operations & Growth" — scaling and hiring.

### 3 Guides (1 per category), 5 steps each with markdown content

| Guide | Category | Steps |
|---|---|---|
| "Register Your Business in Ethiopia" | Business Registration | 1. Choose Legal Structure (INFO), 2. Reserve Company Name (ACTION_REQUIRED), 3. Prepare Registration Documents (DOCUMENT_SUBMISSION), 4. Submit Registration Application (ACTION_REQUIRED), 5. Obtain Business License (VERIFICATION) |
| "Understanding Business Tax Obligations" | Tax & Compliance | 1. Ethiopian Tax Types Overview (INFO), 2. Register for TIN (ACTION_REQUIRED), 3. File Monthly VAT Returns (ACTION_REQUIRED), 4. Prepare Annual Tax Return (DOCUMENT_SUBMISSION), 5. Get Tax Clearance Certificate (VERIFICATION) |
| "Hiring Your First Employees" | Operations & Growth | 1. Ethiopian Employment Law Basics (INFO), 2. Draft Employment Contract (ACTION_REQUIRED), 3. Register with Pension Authority (DOCUMENT_SUBMISSION), 4. Set Up Payroll System (ACTION_REQUIRED), 5. Workplace Safety Registration (VERIFICATION) |

Each step includes a `detailedContent` JSON map with a `"markdown"` key containing 1-3 paragraphs of dummy descriptive content for testing markdown rendering.

### Dummy Data for Recently Viewed
Two recently viewed guides (cross-references to the guides above).

### Dummy Data for Bookmarks
Two bookmarked steps from different guides.

## Dependencies

- `flutter_markdown` — for step detail content rendering. Add to `pubspec.yaml`.

## Localization Plan

Add keys to `app_en.arb` and `app_am.arb`:
- Page titles: guide list, guide detail, step detail.
- Search placeholder.
- Category "All" label.
- "Recently Viewed" section title.
- "Bookmarked" toggle label.
- Progress format: "{completed} of {total} completed · {percent}%".
- Step status labels: Locked, In Progress, Completed, Skipped.
- Step action labels: Start, Complete, Skip, Mark Incomplete.
- Estimated time format: "~{minutes} min".
- Bookmark added/removed toasts.
- Empty states: no guides found, no recent guides, no bookmarks.
- Locked step message.

## Implementation Phases

### Phase 1: UI with Dummy Data
1. Create domain entities and state models.
2. Create dummy data file with all categories, guides, steps.
3. Create GuideListNotifier consuming dummy data.
4. Build Guide List Page with all sub-widgets.
5. Create GuideDetailNotifier consuming dummy data.
6. Build Guide Detail Page (stepper + progress bar).
7. Create StepDetailNotifier consuming dummy data.
8. Build Step Detail Page (markdown + action bar).
9. Add routes to `routes.dart`.
10. Wire "Guide" tab in Home to new route.
11. Add localization keys.
12. `dart analyze` clean.

### Phase 2: API + State Management
1. Wire GuideListNotifier to real API endpoints.
2. Wire GuideDetailNotifier to `/api/v1/guides/{guideSlug}`.
3. Wire StepDetailNotifier to step action endpoints.
4. Add `detailedContent` to personalized step response on backend.
5. Replace dummy data with API-driven data everywhere.

### Phase 3: Bug Fixes
1. Manual end-to-end QA on full flow.
2. Handle loading, error, empty states gracefully.
3. Refresh guide list after returning from step actions.
4. Verify category tree filtering works.
5. Verify bookmark persistence across sessions.

## Done Criteria
- Guide list renders with categories, search, recent, and bookmarks.
- Guide detail renders vertical stepper with correct statuses.
- Step detail renders markdown content with appropriate action buttons.
- Step actions (start, complete, skip, mark incomplete) work.
- Bookmark toggle works on step detail.
- All text localized in English and Amharic.
- `dart analyze` passes with no issues.
