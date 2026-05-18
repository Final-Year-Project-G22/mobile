# Architecture

## Layer Patterns

Each sub-feature follows the existing Clean Architecture conventions:

### Domain Layer

**`scheduled_alerts/domain/entities/scheduled_alert.dart`**
```dart
@freezed
class ScheduledAlert with _$ScheduledAlert {
  const factory ScheduledAlert({
    required String id,
    String? templateSlug,
    required String title,
    required String body,
    required String channel,       // "in_app", "email", "push"
    required DateTime scheduledFor,
    required String status,        // "pending", "sent", "cancelled"
    DateTime? rescheduledFrom,
    DateTime? sentAt,
    DateTime? cancelledAt,
    required DateTime createdAt,
  }) = _ScheduledAlert;
}
```

**`scheduled_alerts/domain/entities/scheduled_alert_template.dart`**
```dart
@freezed
class ScheduledAlertTemplate with _$ScheduledAlertTemplate {
  const factory ScheduledAlertTemplate({
    required String slug,
    required String name,
    required String defaultTitle,
    required String defaultBody,
    String? defaultChannel,
  }) = _ScheduledAlertTemplate;
}
```

**`compliance/domain/entities/compliance_entry.dart`**
```dart
@freezed
class ComplianceEntry with _$ComplianceEntry {
  const factory ComplianceEntry({
    required String id,
    required String businessProfileId,
    required String complianceType,
    String? referenceNumber,
    DateTime? issuedDate,
    required DateTime expiryDate,
    required int reminderDaysBefore,
    required String status,
    DateTime? lastNotifiedAt,
  }) = _ComplianceEntry;
}
```

**`compliance/domain/entities/compliance_calendar_entry.dart`**
```dart
@freezed
class ComplianceCalendarEntry with _$ComplianceCalendarEntry {
  const factory ComplianceCalendarEntry({
    required String id,
    required String type,        // "compliance" or "scheduled_alert"
    required String title,
    String? referenceNumber,
    required DateTime date,
    required int daysRemaining,
    required String status,
  }) = _ComplianceCalendarEntry;
}
```

### Failure Types

```dart
@freezed
class ScheduledAlertFailure with _$ScheduledAlertFailure {
  const factory ScheduledAlertFailure.unableToCreate() = _UnableToCreate;
  const factory ScheduledAlertFailure.unableToCancel() = _UnableToCancel;
  const factory ScheduledAlertFailure.unableToReschedule() = _UnableToReschedule;
  const factory ScheduledAlertFailure.maxLimitReached() = _MaxLimitReached;
  const factory ScheduledAlertFailure.notFound() = _NotFound;
  const factory ScheduledAlertFailure.serverError() = _ServerError;
}

@freezed
class ComplianceFailure with _$ComplianceFailure {
  const factory ComplianceFailure.unableToCreate() = _UnableToCreate;
  const factory ComplianceFailure.unableToUpdate() = _UnableToUpdate;
  const factory ComplianceFailure.unableToDelete() = _UnableToDelete;
  const factory ComplianceFailure.notFound() = _NotFound;
  const factory ComplianceFailure.serverError() = _ServerError;
}
```

### Repository Interfaces

```dart
abstract class IScheduledAlertRepository {
  Future<Either<ScheduledAlertFailure, List<ScheduledAlert>>> list();
  Future<Either<ScheduledAlertFailure, Unit>> create({
    required String? templateSlug,
    required String title,
    required String body,
    required String channel,
    required DateTime scheduledFor,
  });
  Future<Either<ScheduledAlertFailure, Unit>> cancel(String id);
  Future<Either<ScheduledAlertFailure, Unit>> reschedule(
    String id, {required DateTime newScheduledFor});
  Future<Either<ScheduledAlertFailure, List<ScheduledAlertTemplate>>> listTemplates();
}

abstract class IComplianceRepository {
  Future<Either<ComplianceFailure, List<ComplianceEntry>>> list({
    required String businessProfileId});
  Future<Either<ComplianceFailure, Unit>> create({
    required String businessProfileId,
    required String complianceType,
    String? referenceNumber,
    DateTime? issuedDate,
    required DateTime expiryDate,
    required int reminderDaysBefore});
  Future<Either<ComplianceFailure, Unit>> update(String id, {
    String? referenceNumber, DateTime? expiryDate, int? reminderDaysBefore});
  Future<Either<ComplianceFailure, Unit>> delete(String id);
  Future<Either<ComplianceFailure, List<ComplianceCalendarEntry>>> getCalendar();
}
```

### Application Layer (Riverpod Notifiers)

```dart
@riverpod
class ScheduledAlertNotifier extends _$ScheduledAlertNotifier {
  @override
  ScheduledAlertState build() => ScheduledAlertState.initial();

  Future<void> loadAlerts() async { /* ... */ }
  Future<void> createAlert(...) async { /* ... */ }
  Future<void> cancelAlert(String id) async { /* ... */ }
  Future<void> rescheduleAlert(String id, DateTime newDate) async { /* ... */ }
  Future<void> loadTemplates() async { /* ... */ }
}

@freezed
class ScheduledAlertState with _$ScheduledAlertState {
  const factory ScheduledAlertState({
    @Default([]) List<ScheduledAlert> alerts,
    @Default([]) List<ScheduledAlertTemplate> templates,
    @Default(false) bool isLoading,
    String? errorMessage,
    String? successMessage,
  }) = _ScheduledAlertState;
  factory ScheduledAlertState.initial() => const ScheduledAlertState();
}
```

Same pattern for `ComplianceNotifier` / `ComplianceState`.

### Infrastructure Layer

Repository implementations follow the existing pattern in `inbox_repository_impl.dart`:

```dart
class ScheduledAlertRepositoryImpl implements IScheduledAlertRepository {
  const ScheduledAlertRepositoryImpl(this._client);
  final ScheduledAlertsClient _client;  // Retrofit-generated

  @override
  Future<Either<ScheduledAlertFailure, List<ScheduledAlert>>> list() async {
    try {
      final response = await _client.listScheduledAlerts();
      return Right(response.data.map(_toEntity).toList());
    } on DioException catch (e) {
      return Left(_mapError(e));
    }
  }
  // ...
}
```

### State Management

State classes and notifiers follow the same pattern as the existing `InboxState` / `inboxNotifier`. The notifier handles:
- Loading state (spinner)
- Error state (snackbar via `ref.listen`)
- Success state (snackbar + reload list)
- Optimistic updates for cancel/reschedule

## Routing

New typed routes added to `routes.dart`:

```dart
@TypedGoRoute<ScheduledAlertsRoute>(path: '/scheduled')
class ScheduledAlertsRoute extends GoRouteData with $ScheduledAlertsRoute {
  const ScheduledAlertsRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ScheduledAlertsPage();
}

@TypedGoRoute<CreateScheduledAlertRoute>(path: '/scheduled/create')
class CreateScheduledAlertRoute extends GoRouteData
    with $CreateScheduledAlertRoute {
  const CreateScheduledAlertRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const CreateScheduledAlertPage();
}

@TypedGoRoute<ComplianceRoute>(path: '/compliance')
class ComplianceRoute extends GoRouteData with $ComplianceRoute {
  const ComplianceRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const CompliancePage();
}
```

## API Client

New Retrofit clients in `api_client/lib/src/api/`:

```dart
@RestApi()
abstract class ScheduledAlertsClient {
  @GET('/api/v1/notifications/scheduled')
  Future<ListScheduledAlertsResponse> listScheduledAlerts();

  @POST('/api/v1/notifications/scheduled')
  Future<CreateScheduledAlertResponse> createScheduledAlert(
    @Body() CreateScheduledAlertRequest body);

  @PATCH('/api/v1/notifications/scheduled/{id}/cancel')
  Future<CancelScheduledAlertResponse> cancelScheduledAlert(@Path('id') String id);

  @PATCH('/api/v1/notifications/scheduled/{id}/reschedule')
  Future<RescheduleScheduledAlertResponse> rescheduleScheduledAlert(
    @Path('id') String id, @Body() RescheduleScheduledAlertRequest body);

  @GET('/api/v1/notifications/scheduled/templates')
  Future<ListScheduledAlertTemplatesResponse> listScheduledAlertTemplates();
}
```

Same pattern for `ComplianceClient`.
