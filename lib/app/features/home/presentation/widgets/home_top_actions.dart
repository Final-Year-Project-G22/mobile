import 'package:flutter/material.dart';

class HomeTopActions extends StatelessWidget {
  const HomeTopActions({
    required this.onNotificationsTap,
    required this.onProfileTap,
    super.key,
  });
  final VoidCallback onNotificationsTap;
  final VoidCallback onProfileTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          tooltip: 'Notifications',
          icon: const Icon(Icons.notifications_none_rounded),
          onPressed: onNotificationsTap,
        ),
        IconButton(
          tooltip: 'Profile',
          icon: const Icon(Icons.account_circle_outlined),
          onPressed: onProfileTap,
        ),
      ],
    );
  }
}
