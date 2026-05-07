# Guide Module — Product Requirements Document

## Problem Statement
Small business owners in Ethiopia lack a centralized, structured way to learn about the regulatory, legal, and operational steps required to start and run a business. They need guided, step-by-step learning paths that are personalized to their profile, track their progress, and provide actionable instructions at each step. Currently, the mobile app has no guide browsing or learning feature.

## Solution
A guide module that lets users browse guides by category, search for specific topics, view personalized step-by-step guides with progress tracking, and interact with individual steps. Each step provides markdown-formatted educational content and action items. Users can start, complete, skip optional steps, and bookmark steps for quick reference. The experience is fully localized in English and Amharic.

## User Stories

1. As a business owner, I want to browse available guides by category, so that I can find relevant information for my business stage.
2. As a business owner, I want to search for guides by keyword, so that I can quickly find specific topics I need.
3. As a business owner, I want to see recently viewed guides, so that I can easily resume where I left off.
4. As a business owner, I want to bookmark important steps, so that I can quickly reference them later.
5. As a business owner, I want to see my bookmark list, so that I can access saved steps in one place.
6. As a business owner, I want to filter guides by category, so that I can narrow down guides relevant to my current focus.
7. As a business owner, I want to see a progress bar for each guide showing how many steps I've completed, so that I know how far along I am.
8. As a business owner, I want to see a vertical timeline of guide steps with status indicators, so that I understand which steps are done, in progress, or locked.
9. As a business owner, I want completed steps to show a checkmark, so that I can visually confirm progress at a glance.
10. As a business owner, I want my current step to be visually highlighted, so that I know where to focus next.
11. As a business owner, I want future steps to appear locked until I complete the current one, so that I follow the correct sequence.
12. As a business owner, I want to tap a step to see its full details, so that I can read instructions and take action.
13. As a business owner, I want step content rendered as formatted markdown, so that instructions are clear and well-structured.
14. As a business owner, I want to see the estimated time for each step, so that I can plan my schedule.
15. As a business owner, I want to see what type each step is (informational, action required, document submission, verification), so that I know what to expect.
16. As a business owner, I want to start a step to mark it as in-progress, so that the app tracks my activity.
17. As a business owner, I want to complete a step after fulfilling its requirements, so that I can progress to the next step.
18. As a business owner, I want to skip optional steps that don't apply to me, so that I can move forward without unnecessary work.
19. As a business owner, I want to mark a completed step as incomplete, so that I can redo it if I made a mistake.
20. As a business owner, I want to see a clear message when a step is locked because prerequisites aren't met, so that I understand why I can't proceed.
21. As a business owner, I want to be returned to the guide overview after completing or skipping a step, so that I can see the updated progress.
22. As an Amharic-speaking business owner, I want the entire guide experience in Amharic, so that I can use it in my preferred language.

## Implementation Decisions

### Architecture
- Clean architecture with four layers: domain (entities, failures), application (notifiers, state), infrastructure (dummy data, repository implementations), presentation (pages, widgets).
- State management via Riverpod code generation (`@riverpod`).
- Routes via GoRouter typed routes inside the existing shell route.
- Follows the same conventions as the onboarding and auth modules.

### API Contracts
The module uses the existing user-facing guide API endpoints from the auto-generated client package. Key endpoints:
- Category tree (`GET /api/v1/guides/categories/tree`) — public, localized.
- Search (`GET /api/v1/guides/search`) — public, localized, supports keyword query.
- Recently viewed (`GET /api/v1/guides/recent`) — authenticated, max 5 items.
- Bookmarks (`GET /api/v1/guides/bookmarks`) — authenticated, paginated.
- Personalized guide (`GET /api/v1/guides/{guideSlug}`) — authenticated, includes step statuses and progress.
- Step actions: start, complete, skip, mark-incomplete, update-progress — all authenticated POST/PATCH.
- Bookmark toggle: POST (add) and DELETE (remove) on step bookmarks.

### Backend Gap
The `detailedContent` field (stored as JSON map with markdown content on `GuideStepTranslation`) is currently only exposed via admin endpoints. It must be added to the user-facing `getPersonalizedGuide` response before Phase 2 API integration.

### Phase 1: Dummy Data
Hardcoded data for 3 categories, 3 guides (one per category), 5 steps per guide. Each step includes title, description, step type, estimated time, is-optional flag, and detailedContent with markdown. Also includes dummy data for 2 recently viewed guides and 2 bookmarked steps.

### Phase 2: API Integration
Replace dummy data with real API calls. Add `detailedContent` to personalized step DTO. Implement proper loading, error, and empty states.

### Phase 3: Bug Fixes
Manual QA on full flow. Verify state refresh after step actions. Verify category filtering and bookmark persistence.

### Category Filtering
Category chips on the guide list are UI-only in v1. They render categories from the tree endpoint but filter the displayed guide list client-side. Search has no category parameter — future backend enhancement.

### Progress Status Filter
Deferred to a future version. Requires per-guide progress data in search results or a dedicated endpoint.

### Markdown Rendering
Uses `flutter_markdown` package for rendering step content. Styled to match app theme with AppColors and AppTextStyles.

### Routing
Three new routes under the shell: `/guides`, `/guides/:guideSlug`, `/guides/:guideSlug/step/:stepSlug`. The existing "Guide" placeholder tab in Home navigates to `/guides`.

### Localization
All user-facing strings in English and Amharic. Includes page titles, status labels, action buttons, empty states, and formatted strings for progress and time.

## Testing Decisions

### Testing Philosophy
Tests should verify external behavior (what the user sees and can do), not implementation details. Widget tests should interact through the UI. Unit tests should test notifier logic through public methods only.

### Modules to Test
- **GuideListNotifier** — unit test: search filtering, category selection, bookmark toggle, recent guide loading.
- **GuideDetailNotifier** — unit test: guide loading, step list construction, progress calculation, refresh after step action.
- **StepDetailNotifier** — unit test: step loading, start/complete/skip/markIncomplete actions, bookmark toggle.
- **Guide List Page** — widget test: renders categories, renders guides, search input works, recent rail shows/hides, empty state.
- **Guide Detail Page** — widget test: progress bar renders correctly, steps render with correct status indicators, tapping step navigates.
- **Step Detail Page** — widget test: markdown renders, action buttons appear per status, locked state shows disabled message.

### Prior Art
Follows the same testing patterns established in the codebase: Riverpod provider override for dependency injection, `pumpWidget` for widget tests.

## Out of Scope
- Category-based search on the backend.
- Progress-status filter on guide list.
- Document upload within step completion.
- Step dependency visualization in UI.
- Offline caching of guide content.
- Per-step analytics and time tracking UI.
- Guide completion certificates or rewards.
- Admin-level guide management from mobile.
- Push notifications for guide progress.

## Further Notes
- The backend `getPersonalizedGuide` endpoint already supports localization via the `locale` query parameter. The mobile app should pass the current locale.
- Step statuses from the backend are: `locked`, `in_progress`, `completed`, `skipped`. The UI must map these to localized labels and appropriate visual states.
- `flutter_markdown` needs to be added to `pubspec.yaml`.
- The Riverpod code generation annotations (`@riverpod`) require running `dart run build_runner build` after creating providers.
- The auto-generated API client (`api_client` package) already contains all needed endpoints; no client changes needed for Phase 1.
