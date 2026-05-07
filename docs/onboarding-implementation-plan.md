# Onboarding Implementation Plan

## Goal
Add a post-registration onboarding flow that runs immediately after OTP verification. The flow captures localized personalization data across six screens, stores it in-memory (no API calls), and routes users to Home when complete.

## Scope
- New onboarding feature module with clean architecture layers.
- Local state only (Riverpod notifier), no persistence.
- Multi-step UI aligned with the provided draft.
- Full localization (English + Amharic) for all onboarding copy.
- Routing rules to enforce onboarding before Home after OTP verification.

## Out of Scope
- Backend/API integration.
- Persistent storage.
- Analytics and event tracking.

## Feature Flow
1. User completes registration.
2. User completes OTP verification.
3. App routes to Onboarding (6 steps).
4. User completes onboarding.
5. App routes to Home.

## Onboarding Steps (Order)
1. Geography (Region enum) - single select.
2. Lifecycle (Stage enum) - single select.
3. Industry (Sector table) - single select (optionally allow sub-sector selection in v2).
4. Legal & Tax (two single-select questions on one screen).
5. Operations (multi-select).
6. Special Demographics (multi-select, optional).

## Data Model (In-Memory)
- `region`: enum value string (e.g., `ADDIS_ABABA`).
- `lifecycleStage`: enum value string (e.g., `IDEA`).
- `industry`: string (e.g., `trade`).
- `legalStructure`: string (e.g., `sole-proprietor`).
- `taxStatus`: string (e.g., `tax-vat`).
- `operations`: set of strings (e.g., `op-importer`, `op-ecommerce`).
- `demographics`: set of strings (e.g., `demo-women-owned`).
- `isComplete`: bool.

## Architecture Plan

### Domain
- `OnboardingAnswer` value object (immutable data shape).
- `OnboardingStep` definition (step ID, validation rules).

### Application
- `OnboardingState` (currentStep, answers, isComplete).
- `OnboardingNotifier` (Riverpod notifier):
  - setAnswer
  - toggleAnswer (for multi-select)
  - nextStep / previousStep
  - complete

### Presentation
- `OnboardingPage` (PageView, stepper/progress, next/back).
- `OnboardingStepView` components:
  - Single select grid
  - Single select list
  - Multi-select list
  - Optional helper for dual-question screen (legal + tax)
- `OnboardingOptionCard` and `OnboardingOptionChip` to match the draft UI.

## Localization Plan
Add keys for:
- All questions and descriptions.
- All option labels.
- Step labels, progress text, button labels.
- Optional description text (demographics).

Localization files:
- `lib/core/l10n/app_en.arb`
- `lib/core/l10n/app_am.arb`

## Routing Plan
- Add an onboarding route in the router.
- Redirect flow:
  - After OTP verification, route to onboarding unless already complete in-memory.
  - Once `isComplete` is true, redirect onboarding → Home.

## UI Notes
- Use `AppColors` and `AppSpacing` for consistency.
- Step indicator and progress percentage at top.
- Support small screens with scroll + safe area.
- Multi-select uses checkboxes or chip toggles (as per design).

## Validation Rules
- Steps 1–5 required.
- Step 6 optional (can skip).
- Disable Next until required selections are made.

## Implementation Phases
1. Create onboarding domain/application structure and state.
2. Add route + routing logic.
3. Build UI skeleton with stepper + PageView.
4. Implement each step UI and validation.
5. Add localization keys and wire to UI.
6. Manual QA on flow from Register → OTP → Onboarding → Home.

## Testing (Optional for Later)
- Unit tests for `OnboardingNotifier`.
- Widget tests for step validation and navigation.

## Done Criteria
- Onboarding screen sequence works end-to-end.
- Local state holds all selections.
- UI matches draft layout and style.
- English/Amharic localization visible.
- Users reach Home only after onboarding completion.
