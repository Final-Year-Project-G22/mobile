import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/config/app_config.dart';
import '../../../../../core/l10n/generated/app_localizations.dart';
import '../../../../../shared/widgets/adisu_progress_indicator.dart';
import '../../../../../shared/widgets/styled_filter_chip.dart';
import '../../../../constants/app_spacing.dart';
import '../../../taxonomy/application/providers/taxonomy_providers.dart';
import '../../../taxonomy/domain/entities/tag.dart';
import '../../application/business_profile_notifier.dart';
import '../../domain/entities/business_profile.dart';

class BusinessProfilePage extends ConsumerStatefulWidget {
  const BusinessProfilePage({super.key});

  @override
  ConsumerState<BusinessProfilePage> createState() =>
      _BusinessProfilePageState();
}

class _BusinessProfilePageState extends ConsumerState<BusinessProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _companyNameController = TextEditingController();
  final _companyEmailController = TextEditingController();
  final _companyPhoneController = TextEditingController();
  final _physicalAddressController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _registrationNumberController = TextEditingController();
  final _taxIdController = TextEditingController();
  final _tradeLicenseController = TextEditingController();

  String? _logoUrl;
  String? _bannerUrl;
  bool _isLogoUploading = false;
  bool _isBannerUploading = false;
  bool _isSaving = false;
  bool _isInitialized = false;
  String? _selectedSectorSlug;
  List<String> _selectedTagSlugs = [];

  @override
  void dispose() {
    _companyNameController.dispose();
    _companyEmailController.dispose();
    _companyPhoneController.dispose();
    _physicalAddressController.dispose();
    _descriptionController.dispose();
    _registrationNumberController.dispose();
    _taxIdController.dispose();
    _tradeLicenseController.dispose();
    super.dispose();
  }

  void _bindProfile(BusinessProfile profile) {
    if (_isInitialized) return;
    _companyNameController.text = profile.companyName;
    _companyEmailController.text = profile.companyEmail;
    _companyPhoneController.text = profile.companyPhoneNumber;
    _physicalAddressController.text = profile.physicalAddress ?? '';
    _descriptionController.text = profile.description ?? '';
    _registrationNumberController.text = profile.registrationNumber ?? '';
    _taxIdController.text = profile.taxIdentificationNumber ?? '';
    _tradeLicenseController.text = profile.tradeLicenseNumber ?? '';
    _logoUrl = profile.logoUrl;
    _bannerUrl = profile.bannerUrl;
    _selectedSectorSlug = profile.sector?.slug;
    _selectedTagSlugs = profile.tags.map((t) => t.slug).toList();
    _isInitialized = true;
  }

  Future<void> _pickLogo() async {
    setState(() => _isLogoUploading = true);
    final notifier = ref.read(businessProfileProvider.notifier);
    final url = await notifier.uploadLogoFromGallery();
    if (mounted) {
      setState(() {
        _isLogoUploading = false;
        if (url != null) _logoUrl = url;
      });
    }
  }

  Future<void> _pickBanner() async {
    setState(() => _isBannerUploading = true);
    final notifier = ref.read(businessProfileProvider.notifier);
    final url = await notifier.uploadBannerFromGallery();
    if (mounted) {
      setState(() {
        _isBannerUploading = false;
        if (url != null) _bannerUrl = url;
      });
    }
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);

    final notifier = ref.read(businessProfileProvider.notifier);
    final current = ref.read(businessProfileProvider);
    final hasProfile = current.asData?.value != null;

    if (hasProfile) {
      await notifier.updateProfile(
        companyName: _companyNameController.text,
        companyEmail: _companyEmailController.text,
        companyPhoneNumber: _companyPhoneController.text,
        physicalAddress: _physicalAddressController.text.isNotEmpty
            ? _physicalAddressController.text
            : null,
        description: _descriptionController.text.isNotEmpty
            ? _descriptionController.text
            : null,
        logoUrl: _logoUrl,
        bannerUrl: _bannerUrl,
        registrationNumber: _registrationNumberController.text.isNotEmpty
            ? _registrationNumberController.text
            : null,
        taxIdentificationNumber: _taxIdController.text.isNotEmpty
            ? _taxIdController.text
            : null,
        tradeLicenseNumber: _tradeLicenseController.text.isNotEmpty
            ? _tradeLicenseController.text
            : null,
        sectorSlug: _selectedSectorSlug,
        tagSlugs: _selectedTagSlugs,
      );
    } else {
      await notifier.createProfile(
        companyName: _companyNameController.text,
        companyEmail: _companyEmailController.text,
        companyPhoneNumber: _companyPhoneController.text,
        physicalAddress: _physicalAddressController.text.isNotEmpty
            ? _physicalAddressController.text
            : null,
        description: _descriptionController.text.isNotEmpty
            ? _descriptionController.text
            : null,
        logoUrl: _logoUrl,
        bannerUrl: _bannerUrl,
        registrationNumber: _registrationNumberController.text.isNotEmpty
            ? _registrationNumberController.text
            : null,
        taxIdentificationNumber: _taxIdController.text.isNotEmpty
            ? _taxIdController.text
            : null,
        tradeLicenseNumber: _tradeLicenseController.text.isNotEmpty
            ? _tradeLicenseController.text
            : null,
        sectorSlug: _selectedSectorSlug,
        tagSlugs: _selectedTagSlugs,
      );
    }

    if (!mounted) return;
    setState(() => _isSaving = false);

    final state = ref.read(businessProfileProvider);
    if (state.hasError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            state.error?.toString() ?? AppLocalizations.of(context).errorGeneric,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context).businessProfileUpdated),
        ),
      );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final bpAsync = ref.watch(businessProfileProvider);
    final profile = bpAsync.asData?.value;
    if (profile != null) _bindProfile(profile);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.businessProfile)),
      body: bpAsync.isLoading && !_isInitialized
          ? const Center(child: AdisuProgressIndicator.large())
          : Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.all(AppSpacing.screenH),
                children: [
                  _ImagePickerSection(
                    title: l10n.logo,
                    imageUrl: _logoUrl,
                    isUploading: _isLogoUploading,
                    onTap: _pickLogo,
                    colorScheme: colorScheme,
                  ),
                  const SizedBox(height: 16),
                  _ImagePickerSection(
                    title: l10n.banner,
                    imageUrl: _bannerUrl,
                    isUploading: _isBannerUploading,
                    onTap: _pickBanner,
                    colorScheme: colorScheme,
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: _companyNameController,
                    decoration: InputDecoration(
                      labelText: l10n.companyName,
                      border: const OutlineInputBorder(),
                    ),
                    validator: (v) =>
                        (v == null || v.trim().isEmpty) ? l10n.fieldRequired(l10n.companyName) : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _companyEmailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: l10n.companyEmail,
                      border: const OutlineInputBorder(),
                    ),
                    validator: (v) =>
                        (v == null || v.trim().isEmpty) ? l10n.fieldRequired(l10n.companyEmail) : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _companyPhoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: l10n.companyPhone,
                      border: const OutlineInputBorder(),
                    ),
                    validator: (v) =>
                        (v == null || v.trim().isEmpty) ? l10n.fieldRequired(l10n.companyPhone) : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _physicalAddressController,
                    maxLines: 2,
                    decoration: InputDecoration(
                      labelText: l10n.physicalAddress,
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _descriptionController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      labelText: l10n.businessDescription,
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Divider(color: colorScheme.outlineVariant),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      l10n.sectorAndTags,
                      style: theme.textTheme.titleMedium,
                    ),
                  ),
                  Text(
                    l10n.selectSector,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _SectorPicker(
                    selectedSlug: _selectedSectorSlug,
                    onSelected: (slug) {
                      setState(() {
                        _selectedSectorSlug =
                            _selectedSectorSlug == slug ? null : slug;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  Text(
                    l10n.selectTags,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _TagsPicker(
                    selectedSlugs: _selectedTagSlugs,
                    onToggled: (slug) {
                      setState(() {
                        if (_selectedTagSlugs.contains(slug)) {
                          _selectedTagSlugs.remove(slug);
                        } else {
                          _selectedTagSlugs.add(slug);
                        }
                      });
                    },
                  ),
                  const SizedBox(height: 24),
                  Divider(color: colorScheme.outlineVariant),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      l10n.complianceInfo,
                      style: theme.textTheme.titleMedium,
                    ),
                  ),
                  TextFormField(
                    controller: _registrationNumberController,
                    decoration: InputDecoration(
                      labelText: l10n.registrationNumber,
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _taxIdController,
                    decoration: InputDecoration(
                      labelText: l10n.taxIdentificationNumber,
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _tradeLicenseController,
                    decoration: InputDecoration(
                      labelText: l10n.tradeLicenseNumber,
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 32),
                  FilledButton(
                    onPressed: _isSaving ? null : _save,
                    child: _isSaving
                        ? const AdisuProgressIndicator.small()
                        : Text(l10n.save),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
    );
  }
}

class _ImagePickerSection extends StatelessWidget {
  const _ImagePickerSection({
    required this.title,
    required this.imageUrl,
    required this.isUploading,
    required this.onTap,
    required this.colorScheme,
  });

  final String title;
  final String? imageUrl;
  final bool isUploading;
  final VoidCallback onTap;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.labelLarge),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: isUploading ? null : onTap,
          child: Container(
            height: 120,
            width: double.infinity,
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: colorScheme.outlineVariant),
              image: imageUrl != null && imageUrl!.isNotEmpty
                  ? DecorationImage(
                      image: NetworkImage(AppConfig.rewriteFileUrl(imageUrl!)),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            child: isUploading
                ? const Center(child: AdisuProgressIndicator.small())
                : Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.add_photo_alternate_outlined,
                          size: 32,
                          color: colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          imageUrl == null || imageUrl!.isEmpty
                              ? 'Tap to add $title'
                              : 'Tap to change $title',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: colorScheme.onSurfaceVariant,
                              ),
                        ),
                      ],
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}

class _SectorPicker extends ConsumerWidget {
  const _SectorPicker({
    required this.selectedSlug,
    required this.onSelected,
  });

  final String? selectedSlug;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sectorsAsync = ref.watch(sectorsProvider);
    return sectorsAsync.when(
      loading: () => const SizedBox(
        height: 40,
        child: Center(child: AdisuProgressIndicator.small()),
      ),
      error: (_, _) => const SizedBox.shrink(),
      data: (sectors) {
        final rootSectors =
            sectors.where((s) => s.parentId == null).toList();
        return Wrap(
          spacing: AppSpacing.xs,
          runSpacing: AppSpacing.xs,
          children: rootSectors.map((sector) {
            return StyledFilterChip(
              label: sector.name,
              isSelected: selectedSlug == sector.slug,
              onSelected: (_) => onSelected(sector.slug),
              compact: true,
            );
          }).toList(),
        );
      },
    );
  }
}

class _TagsPicker extends ConsumerWidget {
  const _TagsPicker({
    required this.selectedSlugs,
    required this.onToggled,
  });

  final List<String> selectedSlugs;
  final ValueChanged<String> onToggled;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tagsAsync = ref.watch(tagsProvider);
    return tagsAsync.when(
      loading: () => const SizedBox(
        height: 40,
        child: Center(child: AdisuProgressIndicator.small()),
      ),
      error: (_, _) => const SizedBox.shrink(),
      data: (tags) {
        final grouped = <String, List<Tag>>{};
        for (final tag in tags) {
          grouped.putIfAbsent(tag.group, () => []).add(tag);
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: grouped.entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.xs),
              child: Wrap(
                spacing: AppSpacing.xs,
                runSpacing: AppSpacing.xs,
                children: entry.value.map((tag) {
                  return StyledFilterChip(
                    label: tag.name,
                    isSelected: selectedSlugs.contains(tag.slug),
                    onSelected: (_) => onToggled(tag.slug),
                    compact: true,
                  );
                }).toList(),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
