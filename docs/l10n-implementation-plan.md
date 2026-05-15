# Localization (l10n) App-Wide Adoption — Implementation Plan

## Overview

Adopt Flutter's built-in l10n (`AppLocalizations.of(context)`) across the mobile app in phased increments, starting with auth pages, settings, and onboarding. The backend already handles `Accept-Language` headers and `locale` query params — this plan addresses the frontend gap.

**Status**: [Not started]  
**Target**: Phase 1 complete → auth (login, register, OTP) + settings + onboarding fully localized.  
**Architecture**: `flutter_localizations` + `intl` → ARB files → Riverpod `localeProvider` → `MaterialApp.router(locale:)`.

---

## Phase Breakdown & Commit Strategy

Each phase is a standalone, reviewable commit. Dependencies flow top-down.

---

### Phase 1: ARB Key Addition + Code Generation

**Commit**: `feat(l10n): add auth/settings/onboarding ARB keys with Amharic translations`

**Files changed**:
- `lib/core/l10n/app_en.arb`
- `lib/core/l10n/app_am.arb`

**What to do**:

Add the following keys to `app_en.arb` (English) and `app_am.arb` (machine-translated Amharic):

#### Login page keys (13)

| Key | English |
|-----|---------|
| `loginSubtitle` | "Log in to get started" |
| `emailOrUsername` | "Email or username" |
| `emailOrUsernameHint` | "Enter your email or username" |
| `passwordHint` | "Enter your password" |
| `errorInvalidCredentials` | "Invalid email or password" |
| `errorEmailInUse` | "Email already in use" |
| `errorGeneric` | "An error occurred" |
| `errorOAuthFailed` | "OAuth sign in failed" |
| `errorOAuthUnavailable` | "OAuth provider is unavailable" |
| `errorOAuthCallbackInvalid` | "Invalid OAuth callback" |
| `errorOAuthExpired` | "OAuth session expired, try again" |
| `errorOAuthUnsupported` | "Unsupported OAuth provider" |
| `errorOAuthCancelled` | "OAuth login was cancelled" |

#### Register page keys (8)

| Key | English |
|-----|---------|
| `createAccount` | "Create Account" |
| `registerSubtitle` | "Sign up to get started" |
| `firstNameHint` | "Enter your first name" |
| `lastNameHint` | "Enter your last name" |
| `emailHint` | "Enter your email" |
| `username` | "Username (optional)" |
| `usernameHint` | "Choose a username" |
| `registrationSuccessful` | "Registration successful" |

#### OTP page keys (8)

| Key | English | Placeholders |
|-----|---------|-------------|
| `verifyEmail` | "Verify Your Email" | — |
| `otpSubtitle` | "Enter the 6-digit code sent to your email" | — |
| `otpCodeHint` | "Please enter the 6-digit code" | — |
| `verify` | "Verify" | — |
| `didNotReceiveCode` | "Didn't receive the code? " | — |
| `resend` | "Resend" | — |
| `resendIn` | "Resend in {seconds}s" | `seconds: int` |
| `errorInvalidOtp` | "Invalid OTP code" | — |

#### Settings page keys (10)

| Key | English | Placeholders |
|-----|---------|-------------|
| `languageEnglish` | "English" | — |
| `languageAmharic` | "አማርኛ" | — |
| `completeBusinessProfile` | "Complete business profile" | — |
| `continueOnboardingAnytime` | "Continue onboarding anytime" | — |
| `plan` | "Plan" | — |
| `freePlan` | "Free plan" | — |
| `activeUntil` | "Active until {date}" | `date: String` |
| `pro` | "Pro" | — |
| `basic` | "Basic" | — |

#### Onboarding page keys (3)

| Key | English |
|-----|---------|
| `skipForNow` | "Skip for now" |
| `saving` | "Saving..." |
| `errorSaveFailed` | "Failed to save business profile. Please try again." |

**Amharic translation approach**: Machine translate all new keys. Use the existing Amharic translations in `app_am.arb` as a style reference for register.

**Post-step**: Run `flutter gen-l10n` to regenerate `lib/core/l10n/generated/app_localizations.dart` and the locale-specific implementations.

---

### Phase 2: Reusable `LocaleToggleButton` Widget

**Commit**: `feat(l10n): add LocaleToggleButton reusable widget`

**Files changed**:
- `lib/core/widgets/locale_toggle_button.dart` (new)

**What to do**:

Create a `ConsumerWidget` in `lib/core/widgets/locale_toggle_button.dart`:

- Reads `localeProvider` to determine current locale
- Shows an `OutlinedButton` (or `TextButton`) with the active locale code:
  - `Locale('en')` → `"EN"`
  - `Locale('am')` → `"አማ"`
  - `null` (system) → `"AUTO"`
- On tap, shows a `PopupMenuButton` with three options:
  1. **English** → calls `ref.read(localeProvider.notifier).setLocale(const Locale('en'))`
  2. **አማርኛ** → calls `ref.read(localeProvider.notifier).setLocale(const Locale('am'))`
  3. **System Default** → calls `ref.read(localeProvider.notifier).setLocale(null)`
- Positioned via `Positioned(top: 8, right: 8)` in parent's `Stack`
- Label text for each popup option comes from `AppLocalizations.of(context)`: `language` / `languageEnglish` / `languageAmharic` / `systemDefault`

**Design**:
- Compact: ~36px height, small font
- Rounded border, semi-transparent background
- No external dependencies beyond `flutter_riverpod` and `app_localizations.dart`

---

### Phase 3: Auth Pages — Login

**Commit**: `feat(l10n): localize login page + add locale toggle`

**Files changed**:
- `lib/app/features/auth/presentation/pages/login_page.dart`

**What to do**:

1. Add imports:
   - `app_localizations.dart`
   - `locale_toggle_button.dart`

2. In the `build` method, add:
   ```dart
   final l10n = AppLocalizations.of(context);
   ```

3. Replace every hardcoded string:
   - `'LogIn'` → `l10n.login`
   - `'LogIn to get started'` → `l10n.loginSubtitle`
   - `'Email or Username'` → `l10n.emailOrUsername`
   - `'Enter your email or username'` → `l10n.emailOrUsernameHint`
   - `'Password'` → `l10n.password`
   - `'Enter your password'` → `l10n.passwordHint`
   - `'Login'` (button) → `l10n.login`
   - `"Don't have an account? "` → `l10n.dontHaveAccount`
   - `'Sign Up'` → `l10n.signUp`

4. Replace error snackbar strings:
   - `'No internet connection'` → `l10n.errorNetwork`
   - `'Email already in use'` → `l10n.errorEmailInUse`
   - `'Invalid email or password'` → `l10n.errorInvalidCredentials`
   - `'Server error'` → `l10n.errorServer`
   - `'An error occurred'` → `l10n.errorGeneric`
   - OAuth errors → corresponding `l10n.errorOAuth*` keys

5. Add `LocaleToggleButton()` as a `Positioned` widget inside the `Stack`:
   ```dart
   const Positioned(
     top: 8,
     right: 8,
     child: LocaleToggleButton(),
   ),
   ```

---

### Phase 4: Auth Pages — Register

**Commit**: `feat(l10n): localize register page + add locale toggle`

**Files changed**:
- `lib/app/features/auth/presentation/pages/register_page.dart`

**What to do**:

Same pattern as Phase 3:

1. Import `app_localizations.dart` and `locale_toggle_button.dart`
2. Add `final l10n = AppLocalizations.of(context);`
3. Replace hardcoded strings with `l10n.*` calls:
   - `'Create Account'` → `l10n.createAccount`
   - `'Sign up to get started'` → `l10n.registerSubtitle`
   - `'First Name'` → `l10n.firstName`
   - `'Enter your first name'` → `l10n.firstNameHint`
   - `'Last Name'` → `l10n.lastName`
   - `'Enter your last name'` → `l10n.lastNameHint`
   - `'Email'` → `l10n.email`
   - `'Enter your email'` → `l10n.emailHint`
   - `'Username (optional)'` → `l10n.username`
   - `'Choose a username'` → `l10n.usernameHint`
   - `'Password'` → `l10n.password`
   - `'Enter your password'` → `l10n.passwordHint`
   - `'Register'` → `l10n.register`
   - `'Already have an account? '` → `l10n.alreadyHaveAccount`
   - `'Sign In'` → `l10n.signIn`
4. Error strings → same `l10n.*` mapping as login
5. Add `LocaleToggleButton()` in the `Stack`

---

### Phase 5: Auth Pages — OTP Verification

**Commit**: `feat(l10n): localize OTP verification page + add locale toggle`

**Files changed**:
- `lib/app/features/auth/presentation/pages/otp_verification_page.dart`

**What to do**:

1. Import `app_localizations.dart` and `locale_toggle_button.dart`
2. Add `final l10n = AppLocalizations.of(context);`
3. Replace hardcoded strings:
   - `'Verify Your Email'` → `l10n.verifyEmail`
   - `'Enter the 6-digit code sent to your email'` → `l10n.otpSubtitle`
   - `'Please enter the 6-digit code'` → `l10n.otpCodeHint`
   - `'Verify'` → `l10n.verify`
   - `"Didn't receive the code? "` → `l10n.didNotReceiveCode`
   - `'Resend'` → `l10n.resend`
   - `'Resend in ${_resendCooldown}s'` → `l10n.resendIn(_resendCooldown)`
   - `'Invalid OTP code'` → `l10n.errorInvalidOtp`
   - `'No internet connection'` → `l10n.errorNetwork`
   - `'Server error'` → `l10n.errorServer`
   - `'An error occurred'` → `l10n.errorGeneric`
4. Wrap the body `SafeArea` + `SingleChildScrollView` in a `Stack` and add `LocaleToggleButton()` as top-right `Positioned`

---

### Phase 6: Settings Page

**Commit**: `feat(l10n): localize remaining settings page labels`

**Files changed**:
- `lib/app/features/settings/presentation/pages/settings_page.dart`

**What to do**:

The settings page already has `final l10n = AppLocalizations.of(context);` and uses it for the app bar title. Remaining hardcoded strings to swap:

- `'Language'` → `l10n.language` (section header)
- `'English'` → `l10n.languageEnglish`
- `'አማርኛ'` → `l10n.languageAmharic`
- `'Theme'` → `l10n.theme`
- `'Light'` → `l10n.lightMode`
- `'Dark'` → `l10n.darkMode`
- `'System'` → `l10n.systemDefault`
- `'Complete business profile'` → `l10n.completeBusinessProfile`
- `'Continue onboarding anytime'` → `l10n.continueOnboardingAnytime`
- `'Plan'` → `l10n.plan`
- `'Basic'` → `l10n.basic`
- `'Free plan'` → `l10n.freePlan`
- `'Active until ${date}'` → `l10n.activeUntil(date)`
- `'Pro'` → `l10n.pro`
- `'Loading...'` → `l10n.loading`
- `'Logout'` → `l10n.logout`

No structural changes to the RadioGroup — only labels change.

---

### Phase 7: Onboarding Page

**Commit**: `feat(l10n): patch remaining onboarding hardcoded strings`

**Files changed**:
- `lib/app/features/onboarding/presentation/pages/onboarding_page.dart`

**What to do**:

The onboarding page already uses `l10n.*` for virtually all strings. Three remaining:

- `'Skip for now'` → `l10n.skipForNow`
- `'Saving...'` → `l10n.saving`
- `'Failed to save business profile. Please try again.'` → `l10n.errorSaveFailed`

---

## Dependencies Between Phases

```
Phase 1 (ARB keys) ──┬── Phase 2 (LocaleToggleButton) ──┬── Phase 3 (login)
                      │                                   ├── Phase 4 (register)
                      │                                   └── Phase 5 (OTP)
                      ├── Phase 6 (settings)
                      └── Phase 7 (onboarding)
```

- Phase 1 **must** precede all others (keys must exist before use).
- Phase 2 must precede Phases 3–5 (toggle widget used by auth pages).
- Phases 3–5, 6, 7 are independent of each other and can be done in any order after Phase 1.

## Testing

After each phase:
1. `flutter gen-l10n` (if ARB files changed)
2. `flutter analyze` — must pass with zero errors
3. Manual verification: toggle locale on login page → verify Register and OTP also show the locale change → verify Settings RadioGroup reflects the change → verify API calls send correct `Accept-Language`

## Future Work (Phase 2+)

After Phase 1 is merged, repeat the same pattern for remaining modules:
- `home` — dashboard stats, quick actions
- `guide` — guide listings, step screens
- `ai` — conversation history, chat UI, citations
- `community` — forum threads, posts
- `templates` — document listings
- `notifications`, `payment`, `profile`

Each is a separate commit. The ARB file grows incrementally.
