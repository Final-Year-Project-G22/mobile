# api_client

OpenAPI-generated API bindings plus shared HTTP client setup for the mobile app.

## Setup

1. Export the OpenAPI spec to `openapi/openapi.json`.
2. Generate code (two-step):
   ```bash
   dart run openapi_retrofit_generator    # Step 1: spec → annotated .dart files
   dart run build_runner build -d --delete-conflicting-outputs  # Step 2: annotations → implementations
   ```
3. Import this package from the app via the workspace path dependency.

## Usage

```dart
import 'package:api_client/api_client.dart';

final client = ApiHttpClient(
  ApiClientConfig(
    baseUrl: 'https://api.example.com',
    tokenProvider: () async => 'token',
  ),
);
```

## Notes

- Generator config is `openapi_generator.yaml`.
- If the generator output layout is not ideal, we can tune the config once the spec is in place.
