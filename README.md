# Adisu Mobile

Flutter mobile application for the **Adisu** platform — a Final Year Project (Group G22).

**Repository:** [github.com/Final-Year-Project-G22/mobile](https://github.com/Final-Year-Project-G22/mobile)

---

## Table of Contents

- [Prerequisites](#prerequisites)
- [Getting Started](#getting-started)
- [Project Structure](#project-structure)
- [Architecture](#architecture)
- [The `api_client` Package](#the-api_client-package)
- [Generating APIs from OpenAPI Spec](#generating-apis-from-openapi-spec)
- [Using Generated APIs in the App](#using-generated-apis-in-the-app)
- [Implementing a New Feature](#implementing-a-new-feature)
- [Code Generation (Main App)](#code-generation-main-app)
- [Localization](#localization)
- [Development Workflow](#development-workflow)

---

## Prerequisites

- **Flutter SDK** — Stable channel, Dart `^3.11.0`
- **Android Studio** — For Android builds and emulator
- **Xcode** — For iOS builds (macOS only)
- **IDE** — VS Code, Zed, or Android Studio (with Flutter/Dart extensions)

---

## Getting Started

```bash
# 1. Clone the repository
git clone https://github.com/Final-Year-Project-G22/mobile.git
cd mobile

# 2. Install dependencies
flutter pub get

# 3. Install api_client dependencies
cd api_client && flutter pub get && cd ..

# 4. Create the environment file
cp assets/.env.example assets/.env  # or create manually (see below)

# 5. Run the app
flutter run
```

### Environment File

Create `assets/.env` with your backend API base URL:

```
API_BASE_URL=http://10.0.2.2:3000
```

> `10.0.2.2` is the host machine's localhost when using the Android emulator. Use your machine's IP for physical devices.

This file is gitignored and will not be committed.

---

## Project Structure

```
mobile/
├── lib/
│   ├── main.dart                          # App entry point
│   ├── app/
│   │   ├── app.dart                       # Root MaterialApp.router
│   │   ├── router/app_router.dart         # GoRouter routes + auth redirects
│   │   ├── theme/app_theme.dart           # Light/dark ThemeData
│   │   └── constants/                     # Colors, typography, spacing
│   ├── core/
│   │   ├── config/app_constants.dart      # App name, version, timeouts
│   │   ├── di/providers.dart              # All Riverpod providers (DI hub)
│   │   ├── auth/token_storage.dart        # Secure token persistence
│   │   ├── network/app_network_info.dart  # Connectivity checker
│   │   ├── errors/                        # Failure + exception hierarchies
│   │   └── l10n/                          # ARB files + generated localizations
│   ├── features/
│   │   ├── splash/                        # Splash screen
│   │   └── auth/                          # Auth feature (DDD layers)
│   │       ├── domain/                    # Entities, failures, value objects, interfaces
│   │       ├── application/               # StateNotifier, state
│   │       ├── infrastructure/            # Repository impl (uses API client)
│   │       └── presentation/              # Pages + widgets
│   └── shared/
│       └── utils/                         # Extensions + formatters
│
├── api_client/                            # Local package — HTTP client + generated APIs
│   ├── pubspec.yaml
│   ├── openapi_generator.yaml             # OpenAPI generator config
│   ├── openapi/openapi.json               # OpenAPI 3.1.0 spec
│   ├── lib/
│   │   ├── api_client.dart                # Barrel exports
│   │   └── src/
│   │       ├── api_client_base.dart       # ApiClient singleton (Dio wrapper)
│   │       ├── api/                       # Generated clients + models
│   │       ├── constants/                 # API constants
│   │       ├── errors/                    # Exceptions + failures
│   │       ├── interceptors/              # Auth, error, logging interceptors
│   │       └── network/                   # Network info interface
│   └── openapi/README.md
│
├── android/                               # Android platform shell
├── ios/                                   # iOS platform shell
├── test/                                  # Tests
├── pubspec.yaml                           # Main app dependencies
├── analysis_options.yaml                  # Lint rules
├── l10n.yaml                              # Localization config
└── .husky/pre-commit                      # Git hooks
```

---

## Architecture

The project follows **Domain-Driven Design** with **Clean Architecture**:

```
┌─────────────────────────────────────────────────┐
│  Presentation   │  Pages, Widgets, GoRouter     │
├─────────────────────────────────────────────────┤
│  Application    │  StateNotifiers           │
├─────────────────────────────────────────────────┤
│  Domain         │  Entities, Value Objects,     │
│                 │  Interfaces, Validators       │
├─────────────────────────────────────────────────┤
│  Infrastructure │  Repositories, API Client     │
└─────────────────────────────────────────────────┘
```

### Key Technologies

| Technology | Purpose |
|---|---|
| **Riverpod v3** | State management and dependency injection (`@riverpod` annotations) |
| **GoRouter + go_router_builder** | Declarative routing with type-safe routes and auth redirect guards |
| **Freezed** | Immutable data classes with `copyWith`, pattern matching |
| **Dartz** | Functional error handling (`Either<L, R>`) |
| **Dio + Retrofit** | HTTP client with typed API methods |
| **very_good_analysis** | Strict lint rules (100+ rules from Very Good Ventures) |
| **flutter_secure_storage** | Encrypted token persistence |
| **flutter_dotenv** | Environment variable loading |
| **commitlint_cli** | Commit message validation (conventional commits) |

### How Layers Connect

State flows through providers defined in `lib/core/di/`:

```
ApiClient (Dio + interceptors)
    └─> AuthenticationClient (generated Retrofit client)
            └─> IAuthRepository (interface)
                    └─> AuthRepositoryImpl (infrastructure)
                            └─> AuthNotifier (@riverpod annotation)
                                    └─> UI (presentation)
```

Providers are split across files:
- `infra_providers.dart` — `ApiClient`, `SecureStorage`, `NetworkInfo`
- `auth_providers.dart` — `AuthRepository`
- `profile_providers.dart` — `ProfileRepository`, `ImagePicker`
- `app_providers.dart` — `ThemeMode`, `Locale`

---

## The `api_client` Package

`api_client` is a standalone local Dart package linked to the main app via path dependency:

```yaml
# pubspec.yaml (main app)
dependencies:
  api_client:
    path: ./api_client
```

### What It Contains

| Component | File | Type |
|---|---|---|
| `ApiClient` | `lib/src/api_client_base.dart` | Hand-written singleton — Dio setup, token management, HTTP methods |
| `AuthInterceptor` | `lib/src/interceptors/auth_interceptor.dart` | Hand-written — Bearer token injection, 401 auto-refresh |
| `ErrorInterceptor` | `lib/src/interceptors/error_interceptor.dart` | Hand-written — Retry logic, error mapping |
| `LoggingInterceptor` | `lib/src/interceptors/logging_interceptor.dart` | Hand-written — Request/response console logging |
| `RestClient` | `lib/src/api/rest_client.dart` | **Generated** — Top-level client from OpenAPI spec |
| `AuthenticationClient` | `lib/src/api/authentication/authentication_client.dart` | **Generated** — Retrofit client for auth endpoints |
| Models | `lib/src/api/models/*.dart` | **Generated** — Freezed data classes from OpenAPI schemas |
| Barrel exports | `lib/api_client.dart` | Hand-written — Exports everything |

---

## Generating APIs from OpenAPI Spec

When the backend API changes (new endpoints, schema updates), regenerate the client code. This is a **two-step process**.

### Prerequisites

Ensure the `api_client` dependencies are installed:

```bash
cd api_client
dart pub get
```

### Step 1: Generate Retrofit Clients and Freezed Models from OpenAPI Spec

```bash
cd api_client
dart run openapi_retrofit_generator
```

This reads `openapi/openapi.json` and writes annotation-bearing `.dart` source files into `lib/src/api/`:

- **Retrofit clients** — One abstract class per API tag (e.g., `AuthenticationClient` from the `"Authentication"` tag), plus a top-level `RestClient` (configured by `base_client_name` in `openapi_generator.yaml`)
- **Freezed models** — One class per schema in the spec (e.g., `LoginRequest`, `LoginResponseBody`, `UserDTO`)

These files contain `@RestApi()`, `@POST()`, `@Freezed()`, and `part` directives but **no implementation code**. They are inputs for Step 2.

### Step 2: Generate Implementations with build_runner

```bash
cd api_client
dart run build_runner build -d --delete-conflicting-outputs
```

This runs three `build_runner` builders over the files from Step 1:

| Builder | Input | Output |
|---|---|---|
| `freezed` | `@Freezed()` annotations | `*.freezed.dart` — `copyWith`, equality, pattern matching |
| `json_serializable` | `@JsonSerializable()` (from Freezed) | `*.g.dart` — `fromJson`/`toJson` |
| `retrofit_generator` | `@RestApi()` annotations | `*.g.dart` — Concrete `_Client` class with Dio HTTP calls |

### Step 3: Update Barrel Exports

After adding new endpoints/schemas, export them in `api_client/lib/api_client.dart`:

```dart
export 'src/api/rest_client.dart';
export 'src/api/authentication/authentication_client.dart';
// Add new client exports here when new API tags are added:
// export 'src/api/products/products_client.dart';

export 'src/api/models/login_request.dart';
export 'src/api/models/login_response_body.dart';
// Add new model exports here when new schemas are added:
// export 'src/api/models/product_dto.dart';
```

### Build Ordering (build.yaml)

`api_client/build.yaml` ensures correct build ordering:

```yaml
global_options:
  freezed:
    runs_before:
      - json_serializable
  json_serializable:
    runs_before:
      - retrofit_generator
```

### OpenAPI Spec Conventions

- Place/update the spec at `api_client/openapi/openapi.json`
- Use **stable `operationId`** values — they become method names (e.g., `login` → `client.login(...)`)
- Use **tag names** that are valid Dart identifiers — they become subdirectory/class names (e.g., `"Authentication"` → `authentication/AuthenticationClient`)
- Use **schema names** that are valid Dart identifiers — they become model class names
- Include `servers` with the correct base URL in the spec

### Config Reference

`api_client/openapi_generator.yaml`:

```yaml
openapi_generator:
  schema_path: openapi/openapi.json       # Path to OpenAPI spec
  output_directory: lib/src/api           # Where generated files go
  json_serializer: freezed                # Use Freezed for models
  use_dart_internal: true                 # Use Dart internal types
  generate_client: true                   # Generate top-level RestClient
  multi_schema: true                      # Support multiple schemas per tag
  base_client_name: RestClient            # Name of the root client class
```

---

## Using Generated APIs in the App

Generated clients are wired into the app through Riverpod providers in `lib/core/di/`.

### Provider Chain (Auth Example)

```dart
// 1. ApiClient — Dio setup, token management (infra_providers.dart)
@Riverpod(keepAlive: true)
ApiClient apiClient(Ref ref) {
  final storage = ref.read(secureStorageProvider);
  return ApiClient(
    secureStorage: storage,
    baseUrl: AppConfig.apiBaseUrl,
    enableLogging: AppConfig.enableLogging,
  );
}

// 2. Repository — wraps generated client, maps errors (auth_providers.dart)
@riverpod
IAuthRepository authRepository(Ref ref) {
  final apiClient = ref.read(apiClientProvider);
  final dio = apiClient.dio;
  final client = AuthenticationClient(dio);
  return AuthRepositoryImpl(client, apiClient);
}

// 3. AuthNotifier — manages auth state (auth_notifier.dart)
@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  Future<AuthStatus> build() async {
    final apiClient = ref.read(apiClientProvider)
      ..setOnUnauthorizedCallback(() async {
        await forceLogout();
      });
    await apiClient.loadTokensFromStorage();
    // ...
  }
}
```

### ApiClient Setup

The `ApiClient` configures Dio with base URL, timeouts, and interceptors:

```dart
// infra_providers.dart
@Riverpod(keepAlive: true)
ApiClient apiClient(Ref ref) {
  final storage = ref.read(secureStorageProvider);
  return ApiClient(
    secureStorage: storage,
    baseUrl: AppConfig.apiBaseUrl,
    enableLogging: AppConfig.enableLogging,
  );
}
```

Token callbacks are wired in `AuthNotifier.build()`:

```dart
final apiClient = ref.read(apiClientProvider)
  ..setOnUnauthorizedCallback(() async {
    await forceLogout();
  });
```

---

## Implementing a New Feature

Follow this step-by-step guide using the existing `auth` feature as a template.

### Step 1: Domain Layer

Create the pure business logic with no framework dependencies.

```
lib/features/<feature_name>/domain/
├── entities/
│   └── <entity>.dart              # Domain entities (plain Dart classes)
├── failures/
│   └── <feature>_failure.dart     # Freezed sealed failure union
├── value_objects/
│   └── <value_objects>.dart       # Validated value types (EmailAddress, Password)
├── validator/
│   └── <validators>.dart          # Validation functions returning Either
└── i_<feature>_repository.dart    # Abstract repository interface
```

**Failure types** use Freezed sealed unions:

```dart
@freezed
sealed class AuthUserFailure with _$AuthUserFailure {
  const factory AuthUserFailure.serverError() = _ServerError;
  const factory AuthUserFailure.networkError() = _NetworkError;
  const factory AuthUserFailure.emailAlreadyInUse() = _EmailAlreadyInUse;
  const factory AuthUserFailure.invalidEmailAndPasswordCombination() = _InvalidCombo;
}
```

**Interfaces** return `Either`:

```dart
abstract class IAuthRepository {
  Future<Either<AuthUserFailure, AuthResponse>> login({
    required String email,
    required String password,
  });
}
```

### Step 2: Application Layer

Create the notifier (state management). The notifier calls the repository directly — no facade needed.

```
lib/features/<feature_name>/application/
├── <feature>_notifier.dart        # @riverpod notifier managing UI state
└── <feature>_state.dart           # Freezed immutable state class (if needed)
```

**State** is a Freezed class:

```dart
@freezed
sealed class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.loading() = _Loading;
  const factory AuthState.success(AuthResponse response) = _Success;
  const factory AuthState.failure(AuthUserFailure failure) = _Failure;
}
```

### Step 3: Infrastructure Layer

Implement the repository using the generated API client.

```
lib/features/<feature_name>/infrastructure/
└── <feature>_repository_impl.dart
```

The repository:
- Takes the generated `Client` (e.g., `AuthenticationClient`), `ApiClient`, and `TokenStorage` via constructor injection
- Calls the generated client methods (e.g., `_client.login(body: LoginRequest(...))`)
- Maps `DioException` to domain `Failure` types
- Returns `Either<Failure, DomainEntity>`

```dart
class AuthRepositoryImpl implements IAuthRepository {
  final AuthenticationClient _client;
  final ApiClient _apiClient;
  final TokenStorage _tokenStorage;

  const AuthRepositoryImpl(this._client, this._apiClient, this._tokenStorage);

  @override
  Future<Either<AuthUserFailure, AuthResponse>> login({...}) async {
    try {
      final response = await _client.login(
        body: LoginRequest(email: email, password: password),
      );
      await _tokenStorage.saveTokens(accessToken: response.accessToken, ...);
      _apiClient.setAccessToken(response.accessToken);
      return Right(AuthResponse(...));
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    }
  }
}
```

### Step 4: Presentation Layer

Create pages and widgets that consume state via Riverpod.

```
lib/features/<feature_name>/presentation/
├── pages/
│   └── <feature>_page.dart
└── widgets/
    └── <widget>.dart
```

Pages consume providers:

```dart
class LogInPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(authNotifierProvider);
    // Build UI based on state
  }
}
```

### Step 5: Wire Up

**Register providers** in a new file `lib/core/di/<feature>_providers.dart`:

```dart
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '<feature>_providers.g.dart';

@riverpod
IFeatureRepository featureRepository(Ref ref) {
  final apiClient = ref.read(apiClientProvider);
  final dio = apiClient.dio;
  final client = FeatureClient(dio);
  return FeatureRepositoryImpl(client);
}
```

**Add routes** in `lib/app/router/routes.dart`:

```dart
@TypedGoRoute<FeatureRoute>(path: '/feature')
class FeatureRoute extends GoRouteData with $FeatureRoute {
  const FeatureRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) => const FeaturePage();
}
```

**Export new files** in `api_client/lib/api_client.dart` if new API endpoints were added.

---

## Code Generation (Main App)

After modifying Freezed classes, JSON models, or Riverpod annotations in the main app, run:

```bash
# From project root
dart run build_runner build -d --delete-conflicting-outputs
```

This generates:
- `*.freezed.dart` — `copyWith`, equality, `toString`, pattern matching
- `*.g.dart` — JSON serialization (`fromJson`/`toJson`)
- `*_providers.g.dart` — Riverpod provider wiring (from `@riverpod` annotations)
- `routes.g.dart` — GoRouter route configuration (from `go_router_builder`)

### When to Run

- After editing any `@freezed` class
- After editing any `@JsonSerializable` class
- After editing Riverpod annotation-based providers (`@riverpod`)
- After editing routes in `routes.dart`
- After running the OpenAPI generator (Step 2 of API generation)
- After every `git pull` (generated files are excluded from git)

---

## Localization

The app supports **English** and **Amharic**.

### Translation Files

| File | Language |
|---|---|
| `lib/core/l10n/app_en.arb` | English |
| `lib/core/l10n/app_am.arb` | Amharic |

### Adding/Updating Translations

1. Edit the ARB files in `lib/core/l10n/`
2. Run code generation:

```bash
flutter gen-l10n
```

3. Use translations in code:

```dart
Text(AppLocalizations.of(context)!.loginTitle)
```

### Config

Localization is configured in `l10n.yaml` at the project root.

---

## Development Workflow

### Pre-Commit Hooks

`.husky/pre-commit` runs automatically before each commit:

1. **`dart fix --apply`** — Auto-fixes lint violations across the project
2. **`dart run lint_staged`** — Formats and analyzes only staged `.dart` files

### Commit Message Format

Commits are validated by `commitlint_cli` via a `.husky/commit-msg` hook.

Format: `type(scope?): subject`

```
feat: add user profile page
fix(auth): resolve token refresh race condition
docs: update README with CI setup
refactor(router): migrate to go_router_builder
chore: update dependencies
```

**Allowed types:** `build`, `chore`, `ci`, `docs`, `feat`, `fix`, `perf`, `refactor`, `revert`, `style`, `test`

Configured in `commitlint.yaml`:

```yaml
include: package:commitlint_cli/commitlint.yaml

rules:
  scope-enum:
    - 0
    - always
  subject-empty:
    - 2
    - never
```

### Lint Rules

Uses [very_good_analysis](https://pub.dev/packages/very_good_analysis) (100+ rules) with overrides in `analysis_options.yaml`:

```yaml
include: package:very_good_analysis/analysis_options.yaml

linter:
  rules:
    public_member_api_docs: false
    prefer_relative_imports: true
    lines_longer_than_80_chars: false
```

**Line length:** 120 characters (configured in `.editorconfig`, `.vscode/settings.json`, `.zed/settings.json`).

**Quick fix command:**
```bash
dart fix --apply && dart format -l 120 . && dart analyze --fatal-infos --fatal-warnings
```

### Editor Config

Shared editor settings committed to git:

| File | Purpose |
|---|---|
| `.vscode/settings.json` | VS Code — format on save, 120 char rulers, Dart formatter |
| `.zed/settings.json` | Zed — format on save, Dart LSP, 120 char line length |
| `.editorconfig` | Universal — indent size, line length, charset |

Format on save is enabled for both VS Code and Zed. The Dart Analysis Server provides linting in both editors.

### CI Pipeline

GitHub Actions runs on every PR to `dev`:

| Workflow | Steps |
|---|---|
| **Lint & Format** | `flutter pub get` → `dart analyze` → `dart format --set-exit-if-changed` |
| **Code Generation & Tests** | `flutter pub get` → `build_runner` (api_client) → `build_runner` (main) → `flutter test` |

Both workflows run in parallel. PRs cannot merge if either fails.

### Running Tests

```bash
flutter test
```

### Generated Files

Generated files (`*.g.dart`, `*.freezed.dart`) are excluded from git. Regenerate after clone or pull:

```bash
dart run build_runner build --delete-conflicting-outputs
cd api_client && dart run build_runner build --delete-conflicting-outputs
```

### Common Commands

```bash
# Install dependencies
flutter pub get

# Run the app
flutter run

# Generate code (main app)
dart run build_runner build -d --delete-conflicting-outputs

# Generate API client (from api_client/)
cd api_client
dart run openapi_retrofit_generator        # Step 1: spec → annotated .dart files
dart run build_runner build -d --delete-conflicting-outputs  # Step 2: annotations → implementations

# Generate localizations
flutter gen-l10n

# Lint and format
dart fix --apply
dart format -l 120 .
dart analyze --fatal-infos --fatal-warnings

# Validate commit message
echo "feat: test" | dart run commitlint_cli

# Run tests
flutter test
```

---

## License

This project is for educational purposes as part of a Final Year Project.
