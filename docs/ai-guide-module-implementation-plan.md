# AI Guide Module — Implementation Plan

## Goal
Add an AI-powered conversational chat interface that lets users ask questions, receive streaming responses with citations, manage conversation history, and continue past conversations — similar to ChatGPT.

## Scope
- One full-screen page: AI Chat (pushed from BottomNav).
- SSE streaming for real-time token-by-token response rendering.
- Conversation history drawer (list, tap to load).
- New chat session creation.
- Citation display for knowledge-base sourced answers.
- Full localization (English + Amharic).
- Two-phase implementation: UI + state setup → API integration.

## Out of Scope (v1)
- Document ingestion (upload/finalize) — separate ingestion module.
- Multi-modal input (image/file attachments in chat).
- Voice-to-text input.
- Chat sharing or export.
- Message editing or deletion.
- Per-conversation settings (temperature, topK, etc. — use defaults).
- Conversation archiving (DELETE endpoint exists but not wired to UI).

## Feature Flow
1. User taps "AI Guide" tab (index 2) in BottomNav → full-screen chat page pushes over the shell.
2. Empty state: centered greeting + input bar at the bottom. User types and sends.
3. First message creates a new session (backend auto-creates, sends sessionId in `done` event). The mobile app sends `title` (first ~40 chars of query) with the first message.
4. Assistant response streams token-by-token in a bubble. Citations appear as a collapsible card below.
5. User can send follow-up messages (same sessionId). Cancel streaming via stop button.
6. AppBar drawer toggle opens conversation history drawer. Shows past conversations with derived titles and relative timestamps. Tap to load.
7. AppBar "+" action starts a fresh chat (clears messages, resets sessionId).
8. Back button pops the chat page, returning to the previously active shell tab.

## Pages

### AI Chat Page (`/ai-guide`)
- **AppBar**: Back button (leading), conversation title or "New Chat" (center), drawer toggle icon (trailing).
- **Body**: `ListView` with chat bubbles. Auto-scrolls to bottom on new chunks while user is near bottom; shows "↓" FAB when scrolled up.
- **Bottom input**: `TextField` pinned via `bottomNavigationBar`. Send button (arrow icon) transforms to stop button (square icon) while streaming. Multi-line, expands up to ~6 lines, then scrolls.
- **Drawer**: Conversation history list (50 items, pull-to-refresh). Shimmer skeleton while loading. Empty state text. Error state with retry. Tapping a conversation closes the drawer and loads the session.

#### States
| State | What renders |
|---|---|
| **Empty (new chat)** | Centered greeting: AI Guide icon + "Ask me anything about your guides" subtitle. Input bar at bottom. |
| **Streaming** | Messages list + assistant bubble growing in real-time with pulsing dot indicator until first token arrives. Stop button visible. |
| **Streaming complete** | All messages rendered. Citations card below last assistant message. Send button visible. |
| **Loading conversation** | Messages list repopulates from loaded session. Shown after tapping drawer item. |
| **Stream error** | Inline error system message: "Something went wrong. Tap to retry." Partial content preserved. |
| **History drawer: loading** | Shimmer skeleton rows. |
| **History drawer: empty** | "No conversations yet" muted text. |
| **History drawer: error** | "Couldn't load conversations" with retry button. |

## Data Sources (API)

| Endpoint | Method | Purpose | Auth |
|---|---|---|---|
| `/api/v1/ai/ask/stream` | POST (SSE) | Streaming ask with session management | Yes |
| `/api/v1/ai/ask` | POST | Non-streaming ask (fallback) | Yes |
| `/api/v1/ai/conversations` | GET | List user conversations | Yes |
| `/api/v1/ai/conversations/{sessionId}` | GET | Get conversation with messages | Yes |
| `/api/v1/ai/conversations/{sessionId}` | DELETE | Archive conversation (not wired in v1 UI) | Yes |

### SSE Event Types
| Event | Data Shape | Behavior |
|---|---|---|
| `chunk` | `{"text": "..."}` | Append text to last assistant message |
| `citations` | `{"citations": [...]}` | Update citations list on current message |
| `done` | `{model, latencyMs, usage, sessionId, ...}` | Finalize message, set sessionId |
| `error` | `{code, message}` | Show inline error, preserve partial content |

### Generated API Clients (Already Exist)
- `AiAskClient`: `ask()`, `askStream()` methods in `api_client/lib/src/api/ai_ask/`
- `AiConversationsClient`: `listConversations()`, `getConversation()`, `archiveConversation()` in `api_client/lib/src/api/ai_conversations/`
- Models: `AskRequest`, `AskResponseBody`, `ConversationDto`, `MessageDto`, `CitationDto`, `UsageDto`, etc.

## File Structure (Clean Architecture)

```
lib/app/features/ai/
├── domain/
│   ├── entities/
│   │   ├── chat_message.dart            # freezed: id, role, content, citations, isStreaming, createdAt
│   │   └── conversation_summary.dart    # freezed: id, title, updatedAt
│   ├── failures/
│   │   └── ai_failures.dart            # AiFailure types (streamError, networkError, etc.)
│   └── i_ai_repository.dart            # Abstract: askStream(), ask(), listConversations(), getConversation()
├── infrastructure/
│   ├── ai_repository_impl.dart         # Wraps AiAskClient + AiConversationsClient, SSE parsing via Dio
│   └── sse_parser.dart                 # Raw SSE byte stream → Stream<SseEvent> (chunk, citations, done, error)
├── application/
│   └── providers/
│       ├── ai_providers.dart           # DI: aiRepositoryProvider
│       ├── ai_chat_notifier.dart       # AsyncNotifier: messages, sessionId, isStreaming, send/stop/load/clear
│       └── ai_conversation_list_provider.dart  # FutureProvider + pull-to-refresh for conversation list
└── presentation/
    ├── pages/
    │   └── ai_chat_page.dart           # Scaffold with AppBar, body (ListView), input bar, drawer
    └── widgets/
        ├── chat_message_bubble.dart    # User (right) / assistant (left) bubble + MarkdownBody + citations
        ├── chat_input_bar.dart         # TextField + send/stop toggle button
        ├── conversation_history_drawer.dart  # Drawer with ListView + loading/empty/error states
        ├── typing_indicator.dart        # Pulsing dot animation
        ├── citation_card.dart           # Collapsible "Sources (N)" card
        └── empty_chat_view.dart         # Centered greeting (no messages yet)
```

## State Management (Riverpod)

### AiChatNotifier (`@riverpod AsyncNotifier`)
- **State**: `List<ChatMessage> messages`, `String? sessionId`, `bool isStreaming`, `String? streamError`.
- **Actions**:
  - `sendMessage(String query)` — adds user message, opens SSE stream, appends chunks, finalizes on done.
  - `stopStreaming()` — cancels SSE via `CancelToken`, preserves partial content, marks message complete.
  - `loadConversation(String sessionId)` — fetches messages via `getConversation()`, populates state.
  - `startNewChat()` — clears messages, resets sessionId. If streaming, cancels first.
- **Scrolling**: external `ScrollController` managed in the page widget. State notifier does not own scroll state.

### AiConversationListProvider (`@riverpod Future`)
- **State**: `List<ConversationSummary>` from `GET /api/v1/ai/conversations`.
- **Refresh**: pull-to-refresh in drawer triggers `ref.invalidate(aiConversationListProvider)`.
- **Page size**: 50 (no pagination in v1).

## Routing

### New Top-Level Route
- `@TypedGoRoute<AiGuideRoute>(path: '/ai-guide')` — outside `MainAppShellRoute`.
- Builds `AiChatPage`.

### Shell Child Changes
- Remove `AiGuildRoute` from `MainAppShellRoute` children (line 85 in `routes.dart`).
- Shell now has 3 child routes: `/home`, `/community`, `/templates`.

### BottomNav Tab 2
- In `home_shell_page.dart`, `onDestinationSelected` for index 2:
  - Calls `context.push('/ai-guide')`.
  - Does NOT update `HomeTabIndex` (shell tab stays on whatever was active).
- User returns via AppBar back button in the chat page → shell reappears on the previously active tab.

## Dependencies
All already in `pubspec.yaml`:
- `flutter_markdown` — assistant message rendering.
- `dio` — SSE streaming via `ResponseType.stream`.
- `flutter_riverpod` / `riverpod_annotation` — state management.
- `go_router` / `go_router_builder` — routing.
- `freezed_annotation` — immutable entities.

## Localization Plan
Add keys to `app_en.arb` and `app_am.arb`:

| Key | English |
|---|---|
| `aiGuideTitle` | AI Guide |
| `aiGuideNewChat` | New Chat |
| `aiGuideGreeting` | Ask me anything about your guides |
| `aiGuideInputHint` | Ask a question... |
| `aiGuideThinking` | Thinking... |
| `aiGuideStop` | Stop generating |
| `aiGuideSend` | Send |
| `aiGuideSources` | Sources ({count}) |
| `aiGuideConversations` | Conversations |
| `aiGuideNoConversations` | No conversations yet |
| `aiGuideConversationsError` | Couldn't load conversations |
| `aiGuideRetry` | Retry |
| `aiGuideStreamError` | Something went wrong. Tap to retry. |
| `aiGuideDiscarded` | Previous response discarded |
| `aiGuideScrollToBottom` | Scroll to bottom |

## Implementation Phases

### Phase 1: UI with Dummy/Mock State
**Goal**: Fully functional UI with all states (empty, streaming simulation, history, error, loading) using mock data. No real API calls.

#### Phase 1.1 — Domain Layer
1. Create `chat_message.dart` (freezed) — `id`, `role` (user/assistant), `content`, `citations` list, `isStreaming`, `sourceTitle`, `createdAt`.
2. Create `conversation_summary.dart` (freezed) — `id`, `title`, `updatedAt`.
3. Create `ai_failures.dart` — `AiFailure` sealed class: `AiStreamError`, `AiNetworkError`, `AiServerError`.
4. Create `i_ai_repository.dart` — abstract methods: `askStream()`, `ask()`, `listConversations()`, `getConversation()`.

#### Phase 1.2 — Infrastructure (Mock)
5. Create `sse_parser.dart` — raw SSE byte stream parser. Returns `Stream<SseEvent>` with event types: `text` (chunk), `citations`, `done`, `error`. Used in both phases but tested with mock streams in Phase 1.
6. Create `ai_repository_impl.dart` — Phase 1 returns mock data for all methods. `askStream()` returns a fake `Stream` that emits chunks with delays simulating network latency.

#### Phase 1.3 — Application (State)
7. Create `ai_chat_notifier.dart`:
   - `messages` state, `sessionId`, `isStreaming`.
   - `sendMessage()` — adds user message, simulates streaming (iterates over mock response chunks), appends each chunk, finalizes.
   - `stopStreaming()` — cancels mock stream.
   - `loadConversation(sessionId)` — loads mock message list.
   - `startNewChat()` — clears state.
8. Create `ai_conversation_list_provider.dart` — returns mock list of `ConversationSummary` items.
9. Create `ai_providers.dart` — `aiRepositoryProvider` (returns mock instance).

#### Phase 1.4 — Presentation (UI)
10. Create `empty_chat_view.dart` — centered greeting with icon, heading, subtitle. Input bar at bottom.
11. Create `typing_indicator.dart` — three pulsing dots animation.
12. Create `citation_card.dart` — `ExpansionTile`-style "Sources (N)" with titles.
13. Create `chat_message_bubble.dart`:
    - User bubble: right-aligned, colored background, plain text.
    - Assistant bubble: left-aligned, `MarkdownBody`, citations card below. Pulsing dot when `isStreaming` and no content yet.
14. Create `chat_input_bar.dart`:
    - Multi-line `TextField` with character counter disabled, max 6 lines scrollable.
    - Send icon button (arrow) → switches to stop icon button (square) when `isStreaming`.
    - Listen to keyboard submit (Enter) to send.
15. Create `conversation_history_drawer.dart`:
    - `ListView` of conversation tiles with title (or "New chat" fallback) and relative timestamp.
    - Shimmer skeleton for loading state.
    - Empty state text.
    - Error state with retry.
    - Pull-to-refresh via `RefreshIndicator`.
16. Create `ai_chat_page.dart`:
    - `Scaffold` with:
      - `AppBar`: back button (leading), dynamic title (center), drawer toggle (trailing).
      - `body`: `ListView.builder` with `reverse: true` empty → messages list. Auto-scroll logic via `ScrollController`. "↓" FAB when scrolled up.
      - `bottomNavigationBar`: `ChatInputBar`.
      - `drawer`: `ConversationHistoryDrawer`.
    - Wire all providers: `AiChatNotifier` for chat state, `AiConversationListProvider` for drawer.
    - Handle edge case: cancel stream + discard when tapping drawer item mid-stream.

#### Phase 1.5 — Routing
17. Delete `lib/app/features/home/presentation/pages/ai_guild_page.dart`.
18. In `routes.dart`:
    - Add `@TypedGoRoute<AiGuideRoute>(path: '/ai-guide')` as top-level route (outside `MainAppShellRoute`).
    - Remove `TypedGoRoute<AiGuildRoute>(path: '/ai-guild')` from `MainAppShellRoute` children.
    - `AiGuideRoute.build()` returns `const AiChatPage()`.
19. Run `dart run build_runner build` to regenerate `routes.g.dart`.
20. In `home_shell_page.dart`, change `onDestinationSelected` for index 2:
    - Replace `ref.read(homeTabIndexProvider.notifier).setIndex(index); context.go('/ai-guild')` with just `context.push('/ai-guide')` (do not change tab index).
21. In `home_tab_notifier.dart`, rename `aiGuild` → `aiGuide` in the `HomeTab` enum.

#### Phase 1.6 — Localization
22. Add AI guide keys to `app_en.arb`.
23. Add AI guide keys to `app_am.arb` (Amharic translations).
24. Run `flutter gen-l10n` to regenerate localizations.
25. Replace all hardcoded strings in AI widgets with `AppLocalizations`.

#### Phase 1.7 — Verification
26. `dart analyze` passes clean.
27. Full manual walkthrough: empty → send → streaming → stop → new chat → drawer → load conversation → back.
28. Verify all states render correctly with mock data.
29. Verify dark/light theme works via existing `Theme.of(context)` usage.

### Phase 2: API Integration
**Goal**: Replace all mock implementations with real API calls. Streaming via SSE over Dio.

#### Phase 2.1 — SSE Streaming
1. Wire `askStream()` in `AiRepositoryImpl`:
   - Use `Dio.post()` with `responseType: ResponseType.stream`.
   - Pass `CancelToken` from repository method parameter.
   - Read response stream bytes via `response.data.stream`.
   - Pipe through `SseParser.parse()` to get `Stream<SseEvent>`.
   - Map `SseEvent` to domain events.
   - Handle stream errors: emit error event, propagate to notifier.
2. Wire `AiChatNotifier.sendMessage()`:
   - Construct `AskRequest(query, topK: 5, sessionId: currentSessionId, title: firstMessage ? query.substring(0, 40) : null)`.
   - Call `repository.askStream(request, cancelToken)`.
   - On `chunk` → append text to last assistant message in state.
   - On `citations` → update citations on current message.
   - On `done` → finalize message (isStreaming=false), set sessionId from done payload.
   - On `error` → set `streamError` on state, preserve partial content.
3. Wire `AiChatNotifier.stopStreaming()`:
   - Call `cancelToken.cancel()`.
   - Mark current message as complete with partial content.
4. Wire `AiChatNotifier.startNewChat()`:
   - Cancel active stream if streaming.
   - Clear messages, set `sessionId = null`.

#### Phase 2.2 — REST API
5. Wire `listConversations()` in `AiRepositoryImpl`:
   - Call `AiConversationsClient.listConversations(limit: 50, offset: 0)`.
   - Map `ConversationDto` → `ConversationSummary`.
   - Derive display title from `title` field (set by mobile app on first message) or fallback to "New chat".
   - Compute relative timestamp from `updatedAt`.
6. Wire `getConversation(sessionId)` in `AiRepositoryImpl`:
   - Call `AiConversationsClient.getConversation(sessionId)`.
   - Map response messages (`MessageDto[]`) → `List<ChatMessage>`.
   - Map response session → `ConversationSummary`.
7. Wire `AiChatNotifier.loadConversation(sessionId)`:
   - If streaming, cancel stream first.
   - Call `repository.getConversation(sessionId)`.
   - Set `messages` to loaded messages, `sessionId` to loaded session ID.
   - Close drawer.

#### Phase 2.3 — Remove Mock Code
8. Delete mock data implementations from `AiRepositoryImpl`.
9. Verify `AiRepositoryImpl` calls real `AiAskClient` and `AiConversationsClient` from the generated `api_client`.
10. Register `AiRepositoryImpl` in `ai_providers.dart` via real `apiClient` DI.

#### Phase 2.4 — Verification
11. Start backend (`core-backend`) with `AI.AskEnabled=true`.
12. Manual test: new chat → send message → verify streaming tokens appear → verify citations → verify sessionId preserved → send follow-up → verify context maintained.
13. Manual test: open drawer → verify conversation list → tap conversation → verify messages load → switch to another conversation.
14. Manual test: new chat → verify state resets cleanly.
15. Manual test: stop during streaming → verify partial content preserved, can send again.
16. Manual test: network error during streaming → verify inline error + retry.
17. `dart analyze` passes clean.

## Done Criteria
- Chat page renders with greeting empty state.
- User can send a message and see it appear as a right-aligned bubble.
- Assistant response streams token-by-token in a left-aligned bubble with MarkdownBody rendering.
- Citations appear as a collapsible card below the assistant message.
- Send button toggles to stop button while streaming; stop cancels mid-response.
- Typing indicator shows pulsing dots while waiting for first token.
- Conversation history drawer shows past conversations with titles and timestamps.
- Tapping a drawer item loads that conversation into the chat.
- "+" action starts a fresh chat session.
- First message sends a `title` (first 40 chars of query) to the backend.
- Auto-scroll follows new content; "↓" FAB appears when scrolled up.
- BottomNav tab 2 pushes the full-screen chat page; back returns to previous tab.
- Loading, empty, and error states all render correctly for both chat and drawer.
- All text localized in English and Amharic.
- `dart analyze` passes with no issues.
- Streaming works correctly via POST SSE with Dio `ResponseType.stream`.
