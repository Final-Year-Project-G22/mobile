import 'package:flutter/material.dart';

import '../../../../../core/l10n/generated/app_localizations.dart';
import '../../../../constants/app_spacing.dart';

class HomeTopActions extends StatelessWidget {
  const HomeTopActions({
    required this.onNotificationsTap,
    required this.onProfileTap,
    this.unreadCount,
    super.key,
  });
  final VoidCallback onNotificationsTap;
  final VoidCallback onProfileTap;
  final int? unreadCount;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    final badgeText = unreadCount != null && unreadCount! > 0
        ? (unreadCount! > 99 ? '99+' : '$unreadCount')
        : null;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Badge(
          isLabelVisible: badgeText != null,
          label: AnimatedSwitcher(
            duration: AppSpacing.durationShort3,
            child: badgeText == null
                ? const SizedBox.shrink()
                : Text(
                    badgeText,
                    key: ValueKey<String>(badgeText),
                    style: const TextStyle(fontSize: 11),
                  ),
          ),
          child: IconButton(
            tooltip: l10n.notifications,
            icon: const Icon(Icons.notifications_none_rounded),
            onPressed: onNotificationsTap,
          ),
        ),
        IconButton(
          tooltip: l10n.profile,
          icon: const Icon(Icons.account_circle_outlined),
          onPressed: onProfileTap,
        ),
      ],
    );
  }
}
