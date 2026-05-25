import 'package:api_client/api_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../app/features/notifications/compliance/domain/i_compliance_repository.dart';
import '../../app/features/notifications/compliance/infrastructure/compliance_repository_impl.dart';
import '../../app/features/notifications/notification_preference/domain/i_notification_preference_repository.dart';
import '../../app/features/notifications/notification_preference/infrastructure/notification_preference_repository_impl.dart';
import '../../app/features/notifications/scheduled_alerts/domain/i_scheduled_alert_repository.dart';
import '../../app/features/notifications/scheduled_alerts/infrastructure/scheduled_alert_repository_impl.dart';
import 'infra_providers.dart';

part 'notification_providers.g.dart';

@riverpod
IScheduledAlertRepository scheduledAlertRepository(Ref ref) {
  final apiClient = ref.read(apiClientProvider);
  return ScheduledAlertRepositoryImpl(NotificationsClient(apiClient.dio));
}

@riverpod
IComplianceRepository complianceRepository(Ref ref) {
  final apiClient = ref.read(apiClientProvider);
  return ComplianceRepositoryImpl(ComplianceClient(apiClient.dio));
}

@riverpod
INotificationPreferenceRepository notificationPreferenceRepository(Ref ref) {
  final apiClient = ref.read(apiClientProvider);
  return NotificationPreferenceRepositoryImpl(apiClient.dio);
}
