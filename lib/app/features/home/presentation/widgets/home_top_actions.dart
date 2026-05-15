import 'package:flutter/material.dart';

import '../../../../../core/l10n/generated/app_localizations.dart';

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

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Badge(
          isLabelVisible: unreadCount != null && unreadCount! > 0,
          label: unreadCount != null && unreadCount! > 0
              ? Text(
                  unreadCount! > 99 ? '99+' : '$unreadCount',
                  style: const TextStyle(fontSize: 11),
                )
              : null,
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
