import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/app_spacing.dart';
import '../../domain/entities/oauth_provider.dart';

class OAuthProviderSection extends StatelessWidget {
  const OAuthProviderSection({
    required this.providers,
    required this.isLoading,
    required this.isDisabled,
    required this.onProviderTap,
    super.key,
  });

  final List<OAuthProvider> providers;
  final bool isLoading;
  final bool isDisabled;
  final ValueChanged<OAuthProvider> onProviderTap;

  @override
  Widget build(BuildContext context) {
    if (!isLoading && providers.isEmpty) {
      return const SizedBox.shrink();
    }

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: Divider(
                color: isDark ? AppColors.borderDark : AppColors.borderLight,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
              child: Text('Or'),
            ),
            Expanded(
              child: Divider(
                color: isDark ? AppColors.borderDark : AppColors.borderLight,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        if (isLoading)
          const Center(child: CircularProgressIndicator())
        else
          ...providers.map(
            (provider) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: OutlinedButton.icon(
                onPressed: isDisabled ? null : () => onProviderTap(provider),
                icon: _ProviderIcon(provider: provider),
                label: Text('Continue with ${provider.displayName}'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                  foregroundColor: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                  side: BorderSide(
                    color: isDark ? AppColors.borderDark : AppColors.borderLight,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _ProviderIcon extends StatelessWidget {
  const _ProviderIcon({required this.provider});

  final OAuthProvider provider;

  @override
  Widget build(BuildContext context) {
    final iconUrl = provider.icon.trim();
    if (iconUrl.startsWith('http://') || iconUrl.startsWith('https://')) {
      return CircleAvatar(
        radius: 10,
        backgroundColor: Colors.transparent,
        backgroundImage: NetworkImage(iconUrl),
      );
    }

    final iconData = _resolveProviderIcon(provider);
    return FaIcon(iconData, size: 18);
  }

  IconData _resolveProviderIcon(OAuthProvider provider) {
    final normalized = (provider.name.isNotEmpty ? provider.name : provider.icon).trim().toLowerCase();

    switch (normalized) {
      case 'google':
      case 'fagoogle':
        return FontAwesomeIcons.google;
      case 'facebook':
      case 'facebookf':
      case 'fafacebookf':
        return FontAwesomeIcons.facebookF;
      case 'github':
      case 'fagithub':
        return FontAwesomeIcons.github;
      case 'apple':
      case 'faapple':
        return FontAwesomeIcons.apple;
      case 'x':
      case 'twitter':
      case 'fatwitter':
      case 'faxTwitter':
        return FontAwesomeIcons.xTwitter;
      default:
        return FontAwesomeIcons.arrowRightToBracket;
    }
  }
}
