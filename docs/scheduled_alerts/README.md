# Scheduled Alerts + Compliance — Mobile App

This module adds three connected features to the mobile notifications experience:

| Feature | Description |
|---------|-------------|
| **Scheduled Alerts** | Users create one-off notifications with custom title, body, channel, and date. Non-pro users capped at 3 pending. |
| **Compliance Entries** | Users track business deadlines (tax registration, trade license, business registration) with expiry dates and reminder windows. |
| **Compliance Calendar** | A unified timeline showing upcoming compliance deadlines and active scheduled alerts. Widget on Home dashboard + full view in Notifications tab. |

## Integration Points

- **Notifications tab** gets a 3-tab layout: Inbox | Scheduled | Compliance
- **Home dashboard** gets a compliance calendar widget showing next 3 deadlines
- **Business Profile** gets a section for managing compliance entries

## Directory Structure

```
lib/app/features/notifications/
├── ... (existing: inbox/, sse/, etc.)
├── scheduled_alerts/
│   ├── domain/
│   │   ├── entities/scheduled_alert.dart
│   │   ├── entities/scheduled_alert_template.dart
│   │   ├── failures/scheduled_alert_failure.dart
│   │   └── i_scheduled_alert_repository.dart
│   ├── application/
│   │   ├── scheduled_alert_notifier.dart
│   │   └── scheduled_alert_state.dart
│   ├── infrastructure/
│   │   └── scheduled_alert_repository_impl.dart
│   └── presentation/
│       ├── pages/scheduled_alerts_page.dart
│       ├── pages/create_scheduled_alert_page.dart
│       └── widgets/scheduled_alert_card.dart
├── compliance/
│   ├── domain/
│   │   ├── entities/compliance_entry.dart
│   │   ├── entities/compliance_calendar_entry.dart
│   │   ├── failures/compliance_failure.dart
│   │   └── i_compliance_repository.dart
│   ├── application/
│   │   ├── compliance_notifier.dart
│   │   └── compliance_state.dart
│   ├── infrastructure/
│   │   └── compliance_repository_impl.dart
│   └── presentation/
│       ├── pages/compliance_page.dart               (entries management + calendar)
│       ├── pages/add_compliance_entry_page.dart
│       └── widgets/compliance_calendar_widget.dart    (reusable in dashboard)
```

## Related Changes Outside Notifications

```
lib/app/features/home/presentation/widgets/
├── home_dashboard_content.dart          (MODIFIED: add compliance calendar section)

lib/app/router/
├── routes.dart                          (MODIFIED: add /scheduled, /compliance routes)

lib/core/di/
├── notification_providers.dart          (MODIFIED: add ScheduledAlert + Compliance providers)
```
