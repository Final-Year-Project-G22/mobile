# OpenAPI input

Place the exported spec at `openapi/openapi.yaml` (or switch the config to point
to `openapi/openapi.json`).

Notes:
- Ensure the spec includes `servers` with the correct base URL.
- Keep operationIds stable; they become method names.
- Prefer schema names that are valid Dart identifiers.

Generate:
`dart run openapi_generator`
