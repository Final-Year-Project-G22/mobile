# Implementation Plan — Mobile App

Organized as sequential PRs. Backend API must be available before PR 3 onward.

---

## PR 1: API Client — Retrofit Clients + DTOs

**Files to create (in `api_client/`):**
- `lib/src/api/scheduled_alerts_client.dart` — Retrofit client for all `/scheduled` endpoints
- `lib/src/api/compliance_client.dart` — Retrofit client for all `/compliance` endpoints
- `lib/src/api/models/scheduled_alert_dto.dart` — DTO classes
- `lib/src/api/models/compliance_dto.dart` — DTO classes

**Files to modify:**
- `api_client/lib/src/api_client.dart` — export new clients

**Verification:** `flutter pub run build_runner build` passes without errors.

---

## PR 2: Domain Layer — Entities + Failures + Repository Interfaces

**Files to create:**
- `lib/app/features/notifications/scheduled_alerts/domain/entities/scheduled_alert.dart`
- `lib/app/features/notifications/scheduled_alerts/domain/entities/scheduled_alert_template.dart`
- `lib/app/features/notifications/scheduled_alerts/domain/failures/scheduled_alert_failure.dart`
- `lib/app/features/notifications/scheduled_alerts/domain/i_scheduled_alert_repository.dart`
- `lib/app/features/notifications/compliance/domain/entities/compliance_entry.dart`
- `lib/app/features/notifications/compliance/domain/entities/compliance_calendar_entry.dart`
- `lib/app/features/notifications/compliance/domain/failures/compliance_failure.dart`
- `lib/app/features/notifications/compliance/domain/i_compliance_repository.dart`

**Verification:** `flutter analyze` passes. Freezed code generation works.

---

## PR 3: Application Layer — Notifiers + State

**Files to create:**
- `lib/app/features/notifications/scheduled_alerts/application/scheduled_alert_notifier.dart`
- `lib/app/features/notifications/scheduled_alerts/application/scheduled_alert_state.dart`
- `lib/app/features/notifications/compliance/application/compliance_notifier.dart`
- `lib/app/features/notifications/compliance/application/compliance_state.dart`

**Verification:** `flutter analyze` passes. Riverpod code generation works.

---

## PR 4: Infrastructure Layer — Repository Implementations

**Files to create:**
- `lib/app/features/notifications/scheduled_alerts/infrastructure/scheduled_alert_repository_impl.dart`
- `lib/app/features/notifications/compliance/infrastructure/compliance_repository_impl.dart`

**Files to modify:**
- `lib/core/di/notification_providers.dart` — add provider factories for both repositories

**Verification:** `flutter analyze` passes. All Either types resolve correctly.

---

## PR 5: UI — Scheduled Alerts Screens

**Files to create:**
- `lib/app/features/notifications/scheduled_alerts/presentation/pages/scheduled_alerts_page.dart`
- `lib/app/features/notifications/scheduled_alerts/presentation/pages/create_scheduled_alert_page.dart`
- `lib/app/features/notifications/scheduled_alerts/presentation/widgets/scheduled_alert_card.dart`

**States handled:**
- Loading: shimmer placeholder
- Empty: illustration + CTA
- Error: message + retry button
- Pro limit reached: upgrade prompt banner
- Data: list of cards with status indicators

**Interactions:**
- Tap card → edit/reschedule options
- Swipe card → confirm cancel
- FAB → navigate to create page
- Create form: template picker dropdown, editable fields, channel chips, date/time picker

---

## PR 6: UI — Compliance Screens

**Files to create:**
- `lib/app/features/notifications/compliance/presentation/pages/compliance_page.dart`
- `lib/app/features/notifications/compliance/presentation/pages/add_compliance_entry_page.dart`
- `lib/app/features/notifications/compliance/presentation/widgets/compliance_calendar_widget.dart`

**CompliancePage states:**
- Loading
- Empty: "No compliance entries yet. Add your first one."
- Error
- Data: entries list showing type, reference, expiry date, status badge

**AddComplianceEntryPage:**
- Type dropdown (seeded types)
- Reference number field
- Issue date picker
- Expiry date picker (must be future)
- Reminder days before (number input, default 30)
- Save button with validation

---

## PR 7: Notifications Tab — 3-Tab Layout

**Files to modify:**
- `lib/app/features/notifications/presentation/pages/inbox_page.dart`
  - Add `TabBar` with 3 tabs: Inbox, Scheduled, Compliance
  - Add `TabBarView` with existing inbox content + embedded scheduled/compliance pages
  - Preserve existing unread badge behavior for Inbox tab

**Verification:** Navigation between tabs works. Pull-to-refresh works on each tab.

---

## PR 8: Home Dashboard Widget

**Files to create:**
- `lib/app/features/home/presentation/widgets/compliance_calendar_section.dart`

**Files to modify:**
- `lib/app/features/home/presentation/widgets/home_dashboard_content.dart`
  - Import and insert `ComplianceCalendarSection` between `QuickActionsGrid` and `ContinueWhereYouLeftOffRail`
- `lib/app/features/home/application/home_dashboard_notifier.dart`
  - Add compliance calendar data fetch to the dashboard load flow

**States:**
- Loading: small skeleton card
- Empty: hidden section
- Data: 3 entries max with days-remaining badges. Tapping header → compliance tab.

---

## PR 9: Routing + DI Wiring

**Files to modify:**
- `lib/app/router/routes.dart`
  - Add `ScheduledAlertsRoute`, `CreateScheduledAlertRoute`, `ComplianceRoute`
  - Register imports for new pages
- `lib/app/router/app_router.dart` — verify routes are picked up by code generation
- `lib/core/di/notification_providers.dart` — finalize all provider registrations

**Verification:**
- `flutter pub run build_runner build` succeeds
- `flutter analyze` passes
- Navigation to each new route works end-to-end

---

## PR 10: L10n Strings

**Files to modify:**
- `lib/core/l10n/app_en.arb` — add English strings for all new UI labels
- `lib/core/l10n/app_am.arb` — add Amharic translations
- Run `flutter gen-l10n` to regenerate

**Strings to add (~30 keys):**
- Scheduled alert labels (title, body, status, create, cancel, reschedule)
- Compliance labels (type names, entry management, calendar)
- Error messages (limit reached, network error, validation)
- Dashboard widget labels

---

## PR 11: Integration — Full Flow Verification

**Tasks:**
1. Run `flutter analyze` — zero issues
2. Run existing tests — all pass
3. Manual E2E on device/emulator:
   - Create scheduled alert → verify it appears in list → wait → verify notification arrives
   - Create compliance entry → verify it appears in calendar widget and compliance tab
   - Cancel scheduled alert → verify status updates
   - Add 3 alerts as free user → verify 4th attempt shows upgrade prompt
   - Verify compliance tab shows both compliance entries and scheduled alerts
4. Check all empty/loading/error states are rendered correctly
5. Verify dark mode compatibility

---

## File Change Summary

| PR | New Files | Modified Files |
|----|-----------|----------------|
| PR 1 | 4 | 1 |
| PR 2 | 8 | 0 |
| PR 3 | 4 | 0 |
| PR 4 | 2 | 1 |
| PR 5 | 3 | 0 |
| PR 6 | 3 | 0 |
| PR 7 | 0 | 1 |
| PR 8 | 1 | 2 |
| PR 9 | 0 | 3 |
| PR 10 | 0 | 2 |
| PR 11 | 0 | 0 |
| **Total** | **25** | **10** |
