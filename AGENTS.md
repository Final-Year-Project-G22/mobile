# AGENTS.md — operating rules for the Adisu Serategna mobile app

> Flutter · Dart SDK ^3.11 · dio HTTP client · Riverpod · freezed for domain models. Feature work tracked in GitHub issues (ported from Linear); `ready-for-dev` issues are agent-grabbable.

## Repo layout

- `lib/app/features/<feature>/` — feature modules (auth, guide, home, payment, …), each with domain/application/infrastructure layers.
- `lib/core/api/` — the API layer: dio client + **generated DTOs** (see API contract).
- `lib/core/api/generated/` — **generated code — never edit by hand.**
- `tool/openapi/openapi.json` — the OpenAPI spec copy consumed by codegen (kept in sync with backend).

## Commands

- `dart analyze` — analysis (fatal infos/warnings).
- `dart format -l 120` — formatting.
- `flutter test` — tests.
- `dart run build_runner build --delete-conflicting-outputs` — runs all codegen (freezed, riverpod, go_router, **and swagger_dart_code_generator**).
- `make lint` (repo root) — commitlint + lint-staged.

## Commit conventions

- Conventional commits (`type(scope): summary`), enforced by commitlint (scopes free-form). PRs target `dev` and close their ticket.
- Branches: `main` + `dev` only. No doc branches — docs live in the `planning` repo.

## API contract (NON-NEGOTIABLE)

The backend owns the OpenAPI spec (`backend/core-backend/docs/openapi.json`, huma-generated). This repo consumes it:

- The spec copy lives at **`tool/openapi/openapi.json`** — never edit by hand.
- Codegen: `dart run build_runner build --delete-conflicting-outputs` generates typed DTO models into **`lib/core/api/generated/`** (swagger_dart_code_generator, `build_only_models` — dio stays the HTTP client).
- After ANY backend API-shape change: copy the fresh spec (`cp ../backend/core-backend/docs/openapi.json tool/openapi/openapi.json`), regenerate, and commit the generated models **in the same change** as the consuming code.
- **Never hand-write API DTOs** that the spec defines — always import the generated model. Hand-written models (freezed) are only for domain objects that are not API-transported. When a backend change alters an endpoint's request/response shape, use the regenerated model and update the dio call sites — do not redefine the shape locally.
- If spec/types drift: the backend side is stale — `cd ../backend && make spec`, then re-copy + regenerate here.

## Agent workflow

- Pick up issues labeled `ready-for-dev` (GitHub) — triaged, sized, unblocked.
- Implement with /tdd where seams allow; run `dart analyze` regularly, single test files regularly, full suite once at the end.
- Use /code-review on the finished change, then commit to the current branch.
- If the change consumes a changed API: the API contract above applies — regenerate and commit generated models before the change is considered done.
