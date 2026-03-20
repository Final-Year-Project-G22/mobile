# OpenAPI input

Place the exported spec at `openapi/openapi.json`.

Notes:
- Ensure the spec includes `servers` with the correct base URL.
- Keep operationIds stable; they become method names.
- Prefer schema names that are valid Dart identifiers.

Generate (two-step):
```bash
dart run openapi_retrofit_generator    # Step 1: spec → annotated .dart files
dart run build_runner build -d --delete-conflicting-outputs  # Step 2: annotations → implementations
```
