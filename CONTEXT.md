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

## Key Implementation Patterns

### Repository Pattern
Each feature has a domain interface (`I*Repository`) and infrastructure implementation (`*RepositoryImpl`). DI via Riverpod providers in `lib/core/di/`.

### Two API Access Patterns
1. **Retrofit clients**: Most features use generated clients (e.g., `GuidesClient(dio)`)
2. **Raw Dio**: AI streaming uses raw `dio.post<ResponseBody>()` for SSE support

### Locale Support
`Accept-Language` header set automatically via interceptor. Drives `locale` query param in API calls.

### Bottom Navigation
5 tabs: Home, Guide, Community, AI Guide (pushed, not shell), Templates.
