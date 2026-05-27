import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/l10n/generated/app_localizations.dart';
import '../../../../../shared/widgets/adisu_progress_indicator.dart';
import '../../../../constants/app_spacing.dart';
import '../../../payment/application/providers/subscription_provider.dart';
import '../../application/profile_notifier.dart';
import '../../application/profile_state.dart';
import '../../domain/entities/user_profile.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _bioController;
  bool _isEditingProfile = false;
  String? _boundUserId;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _bioController = TextEditingController();
    unawaited(
      Future.microtask(() async {
        await ref.read(profileProvider.notifier).loadCurrentUser();
      }),
    );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  void _bindForm(UserProfile user) {
    if (_boundUserId == user.id) return;
    _firstNameController.text = user.firstName.getOrCrash();
    _lastNameController.text = user.lastName.getOrCrash();
    _bioController.text = user.bio ?? '';
    _boundUserId = user.id;
  }

  void _resetFormToCurrentUser(UserProfile user) {
    _firstNameController.text = user.firstName.getOrCrash();
    _lastNameController.text = user.lastName.getOrCrash();
    _bioController.text = user.bio ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(profileProvider);
    final subAsync = ref.watch(subscriptionProvider);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context);

    ref.listen<ProfileState>(profileProvider, (previous, next) {
      if (next.errorMessage != null &&
          next.errorMessage != previous?.errorMessage) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(next.errorMessage!)));
      }
      if (next.successMessage != null &&
          next.successMessage != previous?.successMessage) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(next.successMessage!)));
      }
    });

    final user = state.user;
    final hasInvalidProfileData = user?.failureOption.isSome() ?? false;

    final appBar = AppBar(
      title: Text(l10n.profile),
      actions: [
        IconButton(
          icon: const Icon(Icons.settings),
          tooltip: l10n.settings,
          onPressed: () => context.push('/settings'),
        ),
      ],
    );

    if (state.isLoading) {
      return Scaffold(
        appBar: appBar,
        body: const Center(child: AdisuProgressIndicator.large()),
      );
    }

    if (user == null || hasInvalidProfileData) {
      return Scaffold(
        appBar: appBar,
        body: Center(
          child: Padding(
            padding: AppSpacing.paddingLg,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.error_outline, size: 40, color: colorScheme.error),
                AppSpacing.gapVerticalSm,
                Text(
                  l10n.unableToDisplayProfile,
                  style: theme.textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
                AppSpacing.gapVerticalXs,
                Text(
                  l10n.pleaseTryLoadingAgain,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
                AppSpacing.gapVerticalMd,
                FilledButton.icon(
                  onPressed: () {
                    unawaited(
                      ref.read(profileProvider.notifier).loadCurrentUser(),
                    );
                  },
                  icon: const Icon(Icons.refresh),
                  label: Text(l10n.retry),
                ),
              ],
            ),
          ),
        ),
      );
    }

    _bindForm(user);

    return Scaffold(
      appBar: appBar,
      body: ListView(
        padding: AppSpacing.paddingLg,
        children: [
          Container(
            padding: AppSpacing.paddingLg,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [colorScheme.primaryContainer, colorScheme.surface],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: AppSpacing.borderRadiusLg,
            ),
            child: Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: colorScheme.surfaceContainerHighest,
                      backgroundImage: (user.imageUrl?.isNotEmpty ?? false)
                          ? NetworkImage(user.imageUrl!)
                          : null,
                      child: (user.imageUrl == null || user.imageUrl!.isEmpty)
                          ? Icon(
                              Icons.person,
                              size: 52,
                              color: colorScheme.onSurfaceVariant,
                            )
                          : null,
                    ),
                    Positioned(
                      right: -6,
                      bottom: -6,
                      child: IconButton.filledTonal(
                        tooltip: l10n.editAvatar,
                        onPressed: state.isUploadingAvatar
                            ? null
                            : () {
                                unawaited(
                                  ref
                                      .read(profileProvider.notifier)
                                      .uploadAvatarFromGallery(),
                                );
                              },
                        icon: state.isUploadingAvatar
                            ? const AdisuProgressIndicator.small()
                            : const Icon(Icons.photo_camera_outlined),
                      ),
                    ),
                  ],
                ),
                AppSpacing.gapVerticalMd,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                        user.fullName,
                        style: theme.textTheme.headlineSmall,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    if (subAsync.value?.planName == 'Pro') ...[
                      const SizedBox(width: 8),
                      Chip(
                        label: Text(
                          l10n.pro,
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: colorScheme.onTertiaryContainer,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        backgroundColor: colorScheme.tertiaryContainer,
                        side: BorderSide.none,
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        visualDensity: VisualDensity.compact,
                      ),
                    ],
                  ],
                ),
                AppSpacing.gapVerticalXs,
                Text(
                  user.bio?.isNotEmpty == true ? user.bio! : l10n.noBioYet,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          AppSpacing.gapVerticalLg,
          Card(
            margin: EdgeInsets.zero,
            child: ListTile(
              leading: Icon(Icons.assignment_late, color: colorScheme.onSurfaceVariant),
              title: Text(l10n.compliance),
              subtitle: Text(l10n.manageCompliance),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => context.push('/compliance/manage'),
            ),
          ),
          AppSpacing.gapVerticalLg,
          Card(
            margin: EdgeInsets.zero,
            child: ListTile(
              leading: Icon(Icons.business, color: colorScheme.onSurfaceVariant),
              title: Text(l10n.businessProfile),
              subtitle: Text(l10n.manageBusinessDetails),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => context.push('/profile/business'),
            ),
          ),
          AppSpacing.gapVerticalLg,
          Card(
            child: Padding(
              padding: AppSpacing.paddingMd,
              child: AnimatedSwitcher(
                duration: AppSpacing.durationMedium1,
                child: _isEditingProfile
                    ? _EditProfileForm(
                        key: const ValueKey('edit-profile'),
                        firstNameController: _firstNameController,
                        lastNameController: _lastNameController,
                        bioController: _bioController,
                        isSaving: state.isSaving,
                        onCancel: () {
                          _resetFormToCurrentUser(user);
                          setState(() => _isEditingProfile = false);
                        },
                        onSave: () async {
                          await ref
                              .read(profileProvider.notifier)
                              .updateProfile(
                                firstName: _firstNameController.text,
                                lastName: _lastNameController.text,
                                bio: _bioController.text,
                              );
                          if (!mounted) return;
                          final latest = ref.read(profileProvider);
                          if (latest.errorMessage == null) {
                            setState(() => _isEditingProfile = false);
                          }
                        },
                      )
                    : _ProfileDetailsView(
                        key: const ValueKey('profile-details'),
                        user: user,
                        onEditTap: () =>
                            setState(() => _isEditingProfile = true),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileDetailsView extends StatelessWidget {
  const _ProfileDetailsView({
    required this.user,
    required this.onEditTap,
    super.key,
  });
  final UserProfile user;
  final VoidCallback onEditTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                l10n.profileDetails,
                style: theme.textTheme.titleMedium,
              ),
            ),
            IconButton(
              tooltip: l10n.editProfile,
              onPressed: onEditTap,
              icon: const Icon(Icons.edit_outlined),
            ),
          ],
        ),
        AppSpacing.gapVerticalSm,
        _InfoRow(label: l10n.firstName, value: user.firstName.getOrCrash()),
        _InfoRow(label: l10n.lastName, value: user.lastName.getOrCrash()),
        _InfoRow(
          label: l10n.bio,
          value: user.bio?.isNotEmpty == true ? user.bio! : '-',
        ),
      ],
    );
  }
}

class _EditProfileForm extends StatelessWidget {
  const _EditProfileForm({
    required this.firstNameController,
    required this.lastNameController,
    required this.bioController,
    required this.isSaving,
    required this.onCancel,
    required this.onSave,
    super.key,
  });
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController bioController;
  final bool isSaving;
  final VoidCallback onCancel;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.editProfile, style: theme.textTheme.titleMedium),
        AppSpacing.gapVerticalMd,
        TextField(
          controller: firstNameController,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(labelText: l10n.firstName),
        ),
        AppSpacing.gapVerticalSm,
        TextField(
          controller: lastNameController,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(labelText: l10n.lastName),
        ),
        AppSpacing.gapVerticalSm,
        TextField(
          controller: bioController,
          maxLines: 3,
          decoration: InputDecoration(labelText: l10n.bio),
        ),
        AppSpacing.gapVerticalMd,
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: isSaving ? null : onCancel,
                child: Text(l10n.cancel),
              ),
            ),
            AppSpacing.gapHorizontalSm,
            Expanded(
              child: FilledButton(
                onPressed: isSaving ? null : onSave,
                child: isSaving
                    ? const AdisuProgressIndicator.small()
                    : Text(l10n.save),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final muted = theme.colorScheme.onSurfaceVariant;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 95,
            child: Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(color: muted),
            ),
          ),
          Expanded(child: Text(value, style: theme.textTheme.bodyLarge)),
        ],
      ),
    );
  }
}
