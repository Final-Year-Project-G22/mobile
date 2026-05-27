# ADR-001: Compliance Mobile Architecture

**Status:** Accepted
**Date:** 2026-05-19

## Context

The compliance feature requires displaying both auto-generated and manually created compliance entries in a single list, with different behaviors per source type. The mobile app needs a management page, entry form, and detail/edit page.

## Decision

### 1. Reuse existing ComplianceNotifier (AsyncNotifier)

The existing `ComplianceNotifier` is already an `AsyncNotifier` that auto-loads calendar data in `build()`. We extend it with:
- `loadEntries(businessProfileId)` — fetches all compliance entries
- `createEntry(...)` — creates manual entry
- `updateEntry(...)` — updates expiry/reminder
- `deleteEntry(id)` — deletes manual entry

No new providers needed.

### 2. Two sections in list, differentiated by `source`

The management page maps entries into two groups:
- `source == "auto"` → auto-tracked section (read-only type, no delete)
- `source == "manual"` → manual section (full CRUD)

### 3. BusinessProfile ID from existing provider

The page reads `businessProfileProvider` (existing) to get the user's business profile ID, which is required for listing/create compliance entries.

### 4. Entry form fetches types from API

The compliance type dropdown fetches from `GET /api/v1/compliance/types` instead of hardcoding. This keeps the mobile app in sync with backend-seeded types.

### 5. Routes follow existing pattern

New routes use `@TypedGoRoute` annotations matching the existing convention:
- `/compliance/manage` → list
- `/compliance/manage/add` → create form
- `/compliance/manage/:id` → detail/edit

## Consequences

- Auto entries cannot be deleted from mobile (back-end rejects).
- Manual entries require the user to provide all fields (expiry, reminder).
- Calendar view on the dashboard automatically reflects new entries.
