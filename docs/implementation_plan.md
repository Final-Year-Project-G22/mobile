# Auth & Onboarding Implementation Plan

## Overview
Fix auth module issues (login, logout, refresh token) and implement backend-driven onboarding with business profile creation.

---

## Phase 1: Backend — Fix Refresh Token Race Condition

**File:** `backend/core-backend/internal/modules/iam/application/service/auth_service.go`

**Problem:** In `Refresh()`, the old session is revoked inside a DB transaction, the transaction commits, and then `GenerateAccessToken` runs. If token generation fails, the old session is already revoked but the client never receives the new raw refresh token → user is permanently logged out.

**Fix:** Move `GenerateAccessToken` inside the `WithinTransaction` block so failure rolls back → old session stays valid → client can retry.

---

## Phase 2: Backend — Business Profile Delivery Layer

**New Files:**
- `internal/modules/iam/delivery/dto/business_profile.go` — Request/response DTOs
- `internal/modules/iam/delivery/handler/business_profile_handler.go` — GET/POST/PUT handlers
- `internal/modules/iam/delivery/routes/business_profile_routes.go` — Route registration

**Modified Files:**
- `internal/modules/iam/delivery/routes/routes.go` — Wire business profile routes
- `internal/modules/iam/module.go` — Provide handler dependency

**Endpoints:**
- `GET  /api/v1/users/business-profile`
- `POST /api/v1/users/business-profile`
- `PUT  /api/v1/users/business-profile`

**Auto-fill logic:**
- `companyName = "${firstName} ${lastName}'s Business"`
- `companyEmail = account.email`
- `companyPhoneNumber = account.phoneNumber ?? ""`

---

## Phase 3: Mobile — Auth Stack Fixes

| File | Fix |
|---|---|
| `mobile/lib/app/features/auth/infrastructure/auth_repository_impl.dart` | After `register()`, extract `refresh_token` from `Set-Cookie` header and store it (same as `login()`). |
| `mobile/api_client/lib/src/interceptors/auth_interceptor.dart` | Replace fake `_retryPendingRequests()` with real `_dio.fetch()` retries using the new access token. |
| `mobile/lib/app/features/auth/application/auth_notifier.dart` | In `build()`, after loading tokens, `await getCurrentUser()` to populate state. On failure, `forceLogout()`. |
| `mobile/lib/app/features/auth/application/auth_notifier.dart` | In `logout()`, always `clearTokens()` + set `unauthenticated`, even if backend call fails. |
| `mobile/lib/app/features/auth/presentation/pages/otp_verification_page.dart` | `await completeVerification()` before navigating to onboarding. On error, stay on page. |

---

## Phase 4: Mobile — API Client Layer

**New Files:**
- `mobile/api_client/lib/src/api/business_profile/business_profile_client.dart`
- `mobile/api_client/lib/src/api/taxonomy/taxonomy_client.dart`

**Modified:**
- `mobile/api_client/lib/api_client.dart` — Export new clients

*(Check OpenAPI spec first; if endpoints are in `openapi.json`, regenerate. Otherwise write manual Retrofit clients.)*

---

## Phase 5: Mobile — Business Profile Feature Layer

**New Files:**
1. `mobile/lib/app/features/business_profile/domain/entities/business_profile.dart`
2. `mobile/lib/app/features/business_profile/domain/failures/business_profile_failure.dart`
3. `mobile/lib/app/features/business_profile/domain/i_business_profile_repository.dart`
4. `mobile/lib/app/features/business_profile/infrastructure/business_profile_repository_impl.dart`
5. `mobile/lib/app/features/business_profile/application/business_profile_notifier.dart`
   - `build()` → `GET /users/business-profile`
   - `hasBusinessProfile` boolean (success vs. 404)
   - `createFromOnboarding(answers)` → maps to `POST /users/business-profile`
6. `mobile/lib/core/di/business_profile_providers.dart`

---

## Phase 6: Mobile — Onboarding + Routing Overhaul

**Modified Files:**

| File | Change |
|---|---|
| `mobile/lib/app/router/app_router.dart` | Remove `onboardingState.isComplete` redirect trap. Keep `pendingVerification` and `!isAuthenticated` guards. |
| `mobile/lib/app/features/auth/application/auth_notifier.dart` | After `_applyAuthenticated()`, check business profile. No profile → `OnboardingRoute`. Profile → `HomeRoute`. |
| `mobile/lib/app/features/onboarding/presentation/pages/onboarding_page.dart` | Add "Skip for now" button → `HomeRoute`. On finish → call `createFromOnboarding()` → `HomeRoute`. |
| `mobile/lib/app/features/onboarding/application/onboarding_notifier.dart` | Remove `SharedPreferences` as source of truth. Keep only for step progress cache (optional). |

**New Files:**
1. `mobile/lib/app/features/business_profile/presentation/widgets/complete_profile_banner.dart`
   - Shows when `!hasBusinessProfile`. Dismissible per session. Tapping → `OnboardingRoute`.
2. Wire banner into `mobile/lib/app/features/home/presentation/pages/home_shell_page.dart`.

---

## Data Mapping: Onboarding Answers → Business Profile

| Onboarding Answer | Backend Field |
|---|---|
| `region` | `region` (Region slug) |
| `lifecycleStage` | `stage` (BusinessStage slug) |
| `industry` | `sectorId` (matched via `GET /taxonomy/sectors` by slug) |
| `legalStructure` | tag with group `LEGAL_STRUCTURE` |
| `taxStatus` | tag with group `TAX_STATUS` |
| `operations` | tags with group `GENERAL_OPERATIONS` |
| `demographics` | tags with group `DEMOGRAPHICS` |
| Auto-filled | `companyName = "${firstName} ${lastName}'s Business"`, `companyEmail = account.email`, `companyPhoneNumber = account.phoneNumber ?? ""` |

---

## Execution Flow
1. After each phase, a summary is provided for review.
2. User reviews, commits, and says **"continue"** to proceed to the next phase.
3. Phases must be executed in order.
