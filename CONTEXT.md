# Mobile App — Domain Glossary & Module Conventions

This document defines the shared business language for the mobile app (Flutter/Dart) that serves as the user-facing client for a business formalization platform targeting Ethiopian entrepreneurs.

## Architecture

### Layer Structure
Each feature module under `lib/app/features/` follows Clean Architecture:

```
lib/app/features/<feature>/
├── domain/          # Entities, interfaces (repositories), failures
├── infrastructure/  # Repository implementations, API adapters, parsers
├── application/     # Riverpod notifiers, state classes, providers
└── presentation/    # Pages, widgets, dialogs
```

### State Management
- **Riverpod** (`flutter_riverpod` + `riverpod_annotation`) with code generation
- Provider types: `NotifierProvider` (complex state), `FutureProvider` (async data), `Provider` (singletons), `StreamProvider` (connectivity)
- State classes use `freezed` for immutability or manual classes with `copyWith`

### Navigation
- **go_router** with `go_router_builder` code generation
- Typed routes via `@TypedGoRoute` and `@TypedShellRoute` annotations
- Shell route (`MainAppShellRoute`) wraps Home, Guides, Community, Templates tabs
- Auth guard redirects unauthenticated users to login

### Error Handling
- **dartz** `Either<Failure, Success>` throughout domain layer
- **Freezed** union types for failures (sealed classes)
- Dio exceptions mapped to domain failures in infrastructure layer

### API Client
- Separate package at `api_client/`
- **Retrofit**-generated clients from OpenAPI spec (`openapi/openapi.json`)
- **Dio** with interceptors: auth (token management), error, logging, locale header
- SSE streaming uses raw Dio `ResponseType.stream` (not Retrofit)
- Generator config: `api_client/openapi_generator.yaml`

## Language

### Core Domain Terms

**Guide**:
A step-by-step business formalization journey authored by admins, organized by sectors and tags, consumed by users in sequential order.
_Avoid_: Tutorial, course, curriculum

**Step**:
A single unit within a guide. Has a type (informational, action required, document submission, verification), a status per user (locked, in progress, completed, skipped), and optional estimated time.
_Avoid_: Lesson, task, module

**Sector**:
A broad industry classification (hierarchical, with parentId). Used to filter guides relevant to a user's business type. Examples: Agriculture, Manufacturing, Services.
_Avoid_: Category, industry, vertical

**Tag**:
A cross-cutting attribute with a group (e.g., `LEGAL_STRUCTURE`, `TAX_STATUS`, `BUSINESS_STAGE`). Used alongside sectors to refine guide targeting.
_Avoid_: Label, keyword, topic

**Business Profile**:
A user's declared business attributes: sector, tags, region, lifecycle stage. Drives personalized guide filtering and AI taxonomy-aware responses.
_Avoid_: User profile, company info

**Bookmark**:
A user's saved reference to a specific step within a guide, with an optional note.
_Avoid_: Favorite, save, pin

**Conversation** (AI):
An AI chat session with a title, language, and ordered message history. Linked to a user account. Can be archived (soft-deleted).
_Avoid_: Session, thread, chat

**Message** (AI):
A single turn in a conversation. Has a role (user or assistant), content (text), and optional citations (source documents).
_Avoid_: Response, reply, turn

**Citation**:
A reference to a source document used by the AI in its response. Includes document ID, chunk ID, source type, title, relevance score, and excerpt.
_Avoid_: Reference, source, link

**SSE Event**:
A Server-Sent Event from the AI streaming endpoint. Types: `chunk` (text token), `citations` (source list), `done` (completion metadata), `error` (failure).
_Avoid_: Stream event, WebSocket message

**Journey**:
A user's personalized progress through a guide, including a SHA-256 hash of step structure for detecting guide updates.
_Avoid_: Progress, path, track

**Ingestion** (AI):
The pipeline that processes uploaded documents (PDF/DOCX) through chunking, embedding, and indexing into a vector store for RAG.
_Avoid_: Upload, processing, parsing

**Taxonomy**:
The collective system of sectors and tags used to classify guides, documents, and business profiles.
_Avoid_: Classification, categorization

## Relationships

- A **Guide** targets one or more **Sectors** and **Tags**.
- A **Guide** contains ordered **Steps**.
- A **User** has one **Business Profile** with one sector and multiple tags.
- **Guides** are filtered by the user's **Business Profile** taxonomy (personalized list).
- A **Conversation** contains ordered **Messages**.
- A **Message** (assistant) may have multiple **Citations**.
- A **Bookmark** links a user to a specific **Step** within a **Guide**.
- A **Journey** tracks a user's progress through a **Guide**'s **Steps**.
- **SSE Events** stream from the AI service to build a **Message** incrementally.

## Module Conventions

| Module | Purpose |
|--------|---------|
| `auth` | Authentication (login, register, OAuth, OTP, session management) |
| `onboarding` | Initial user setup and business profile creation |
| `business_profile` | Business profile management (sector, tags, region, stage) |
| `home` | Dashboard with stats, in-progress guides, quick actions, shell navigation |
| `guide` | Guide browsing, search, sector/tag filtering, step-by-step journeys |
| `ai` | Conversational AI chat with SSE streaming, conversation history, citations |
| `community` | Forums/discussions (threads, posts, categories, reports) |
| `templates` | Document templates and downloads |
| `notifications` | Inbox/notifications |
| `payment` | Plans, checkout, payment processing |
| `profile` | User profile management |
| `settings` | App settings |
| `splash` | Loading/splash screen |

## Brand & Identity

### App Name
**Adisu Serategna** — used as the app title across platform manifests (Android `android:label`, iOS `CFBundleDisplayName`), the Material app title, and the splash wordmark.
_Avoid_: Adisu, Adisu app, Serategna alone

### Logo
An Ethiopian-styled **"A" letterform** (initial of "Adisu") rendered as a single silhouette with internal negative-space ornamental cutouts. Uses color `#293751` (dark navy, distinct from the theme primary `#1E293B`). Transparent background — designed to sit on a light surface.
_Avoid_: Using the full "Adisu Serategna" text as a logo mark; recoloring the logo to match theme primary

### Brand Colors

| Role | Hex | Usage |
|------|-----|-------|
| Logo | `#293751` | SVG letterform, app icon foreground, splash hero |
| Primary | `#1E293B` | Theme primary (Material), headings, navigation accents |
| Secondary | `#10B981` | Theme secondary, branded spinner, CTAs |
| Splash BG | `#F8FAFC` | Native splash, Flutter splash page, app icon background |

### Splash Screen Typography
- **Wordmark font**: Playfair Display (Google Font, serif) — used for "Adisu Serategna" on the splash page only
- **App body fonts**: Plus Jakarta Sans (headings) + Inter (body) — unchanged from theme defaults
- Imported via `google_fonts` (already a dependency)

### Splash Screen
The splash (`/splash` route) serves as a branded loading gate while auth status resolves. Composition: centered SVG logo with fade-in animation, "Adisu Serategna" wordmark below in Playfair Display, then `AdisuProgressIndicator` spinner. Background is `#F8FAFC`. The native splash layer (pre-Flutter) uses the same background color for a seamless handoff.
_Avoid_: Placing navigation logic in the splash widget (handled by GoRouter redirect); adding user-actionable elements on splash

## Key Implementation Patterns

### Repository Pattern
Each feature has a domain interface (`I*Repository`) and infrastructure implementation (`*RepositoryImpl`). DI via Riverpod providers in `lib/core/di/`.

### Two API Access Patterns
1. **Retrofit clients**: Most features use generated clients (e.g., `GuidesClient(dio)`)
2. **Raw Dio**: AI streaming uses raw `dio.post<ResponseBody>()` for SSE support

### Locale Support (l10n)

**Translation system**: Flutter built-in `flutter_localizations` + `intl` with ARB files in `lib/core/l10n/`.
- `l10n.yaml` generates Dart code from ARB files into `lib/core/l10n/generated/`
- Supported locales: `en` (English), `am` (Amharic)
- Usage: `AppLocalizations.of(context).someKey` throughout widgets

**Locale state**: Riverpod `localeProvider` (`LocaleNotifier` in `lib/core/di/app_providers.dart`).
- Persisted to `SharedPreferences` under key `locale_code`
- Initial value is `null` (system default) until user explicitly sets a preference
- Changing locale propagates instantly to `MaterialApp.router(locale: locale)` and all API calls

**API locale propagation**:
- `Accept-Language` header set automatically via `InterceptorsWrapper` in `api_client_base.dart`
- `locale` query param on per-endpoint basis via Retrofit `@Query('locale')`

**UI locale toggle**:
- **Auth pages** (login, register, OTP): Compact `LocaleToggleButton` widget (`lib/core/widgets/`) positioned top-right via `Stack` `Positioned`. Shows current locale code (`"EN"`, `"አማ"`, or `"AUTO"`) with a `PopupMenuButton` offering English, አማርኛ, System Default.
- **Settings page**: Full `RadioGroup<Locale?>` with English, አማርኛ options. Labels come from `l10n.*`. Settings also shows System Default implicitly via absence of saved preference.
- Toggle is NOT needed on every page — `localeProvider` is global. Auth pages are first-impression convenience.

**Phased adoption**:
- Phase 1: Auth pages (login, register, OTP), settings, onboarding
- Phase 2+: Remaining feature modules (home, guide, ai, community, templates, notifications, payment, profile)

**Adding new strings**:
1. Add key to `app_en.arb` with English value and `@key` metadata block
2. Add matching key to `app_am.arb` with Amharic translation
3. Run `flutter gen-l10n` to regenerate `app_localizations.dart`
4. Use via `AppLocalizations.of(context).keyName`
_Avoid_: Hardcoding strings in widgets, using third-party i18n packages

### Scheduled Alert

A user-created notification that fires at a future time with user-defined title, body, and delivery channel. Supports cancel and reschedule. Non-pro users are limited to 3 pending.

_Avoid_: Reminder, custom notification, personal alert

### Scheduled Alert Template

A seeded template that pre-fills the title and body of a Scheduled Alert. Users pick a template (tax filing, license renewal, custom, etc.) and may override the content.

_Avoid_: Preset, example

### Compliance Entry

A tracked deadline tied to a Business Profile representing an official registration or license with an expiry date and user-configured reminder window (e.g., TIN registration, trade license, business registration).

_Avoid_: Compliance record, license entry, deadline item

### Compliance Type

A seeded classification of compliance entries. Extensible by adding seed rows.

_Avoid_: Category, kind

### Business Alert

A system-generated notification triggered when a Compliance Entry's expiry date falls within its configured reminder window. Delivered via the standard notification pipeline.

_Avoid_: Compliance notification, auto-reminder

### Compliance Calendar

A read-only view showing upcoming Compliance Entry deadlines and active Scheduled Alerts on a timeline. Shown as a widget on the Home dashboard and as a full view inside the Notifications tab.

_Avoid_: Deadline dashboard, compliance timeline

## Relationships (additions)

- A **Compliance Entry** belongs to exactly one **Business Profile**.
- A **Compliance Entry** has one **Compliance Type**.
- A **Business Alert** is triggered by a **Compliance Entry** reaching its reminder window.
- A **Scheduled Alert** is optionally based on a **Scheduled Alert Template**.
- A **Compliance Calendar** aggregates **Compliance Entries** and **Scheduled Alerts** into a unified timeline.

### Bottom Navigation
5 tabs: Home, Guide, Community, AI Guide (pushed, not shell), Templates.
