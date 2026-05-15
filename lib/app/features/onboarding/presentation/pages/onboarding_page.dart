import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/l10n/generated/app_localizations.dart';
import '../../../../constants/app_colors.dart';
import '../../../../constants/app_spacing.dart';
import '../../../../router/routes.dart';
import '../../../business_profile/application/business_profile_notifier.dart';
import '../../application/onboarding_notifier.dart';
import '../../application/onboarding_state.dart';
import '../widgets/onboarding_option_card.dart';
import '../widgets/onboarding_option_chip.dart';

class OnboardingPage extends ConsumerStatefulWidget {
  const OnboardingPage({super.key});

  @override
  ConsumerState<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends ConsumerState<OnboardingPage> {
  late final PageController _pageController;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(onboardingProvider);
    final notifier = ref.read(onboardingProvider.notifier);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);

    ref.listen(onboardingProvider, (previous, next) {
      if (previous?.currentStep != next.currentStep) {
        unawaited(
          _pageController.animateToPage(
            next.currentStep,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutCubic,
          ),
        );
      }
      if (!mounted) return;
    });

    final canContinue = _canContinue(state);
    final progress = (state.currentStep + 1) / 6;
    final progressLabel = l10n.onboardingProgress(
      (progress * 100).round(),
    );

    return Scaffold(
      backgroundColor: isDark
          ? AppColors.backgroundDark
          : AppColors.backgroundLight,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: AppSpacing.paddingLg,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: state.currentStep == 0
                            ? null
                            : notifier.previousStep,
                        icon: const Icon(Icons.arrow_back),
                      ),
                      Text(
                        l10n.onboardingTitle,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: isDark
                              ? AppColors.textPrimaryDark
                              : AppColors.textPrimaryLight,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: isDark
                              ? AppColors.slate800
                              : AppColors.slate100,
                          borderRadius: AppSpacing.borderRadiusFull,
                        ),
                        child: Text(
                          l10n.onboardingLanguageLabel,
                          style: TextStyle(
                            fontSize: 12,
                            color: isDark
                                ? AppColors.textSecondaryDark
                                : AppColors.textSecondaryLight,
                          ),
                        ),
                      ),
                    ],
                  ),
                  AppSpacing.gapVerticalMd,
                  Row(
                    children: List.generate(6, (index) {
                      final isActive = index <= state.currentStep;
                      return Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(right: 6),
                          height: 4,
                          decoration: BoxDecoration(
                            color: isActive
                                ? AppColors.accent
                                : (isDark
                                      ? AppColors.borderDark
                                      : AppColors.borderLight),
                            borderRadius: AppSpacing.borderRadiusFull,
                          ),
                        ),
                      );
                    }),
                  ),
                  AppSpacing.gapVerticalSm,
                  Row(
                    children: [
                      Text(
                        l10n.onboardingStepLabel(state.currentStep + 1, 6),
                        style: TextStyle(
                          color: isDark
                              ? AppColors.textSecondaryDark
                              : AppColors.textSecondaryLight,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        progressLabel,
                        style: TextStyle(
                          color: isDark
                              ? AppColors.textSecondaryDark
                              : AppColors.textSecondaryLight,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _GeographyStep(state: state, notifier: notifier),
                  _LifecycleStep(state: state, notifier: notifier),
                  _IndustryStep(state: state, notifier: notifier),
                  _LegalTaxStep(state: state, notifier: notifier),
                  _OperationsStep(state: state, notifier: notifier),
                  _DemographicsStep(state: state, notifier: notifier),
                ],
              ),
            ),
            Padding(
              padding: AppSpacing.paddingLg,
              child: Row(
                children: [
                  if (state.currentStep > 0)
                    Expanded(
                      child: OutlinedButton(
                        onPressed: notifier.previousStep,
                        child: Text(l10n.back),
                      ),
                    )
                  else
                    const Spacer(),
                  AppSpacing.gapHorizontalSm,
                  TextButton(
                    onPressed: _isSubmitting
                        ? null
                        : () {
                            const HomeRoute().go(context);
                          },
                    child: Text(l10n.skipForNow),
                  ),
                  AppSpacing.gapHorizontalSm,
                  Expanded(
                    child: ElevatedButton(
                      onPressed: canContinue && !_isSubmitting
                          ? () async {
                              if (state.currentStep == 5) {
                                await _submitOnboarding(state, notifier);
                              } else {
                                notifier.nextStep();
                              }
                            }
                          : null,
                      child: Text(
                        _isSubmitting
                            ? l10n.saving
                            : (state.currentStep == 5
                                  ? l10n.finish
                                  : l10n.next),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _canContinue(OnboardingState state) {
    switch (state.currentStep) {
      case 0:
        return state.answers.region != null;
      case 1:
        return state.answers.lifecycleStage != null;
      case 2:
        return state.answers.industry != null;
      case 3:
        return state.answers.legalStructure != null &&
            state.answers.taxStatus != null;
      case 4:
        return state.answers.operations.isNotEmpty;
      case 5:
        return true;
      default:
        return false;
    }
  }

  Future<void> _submitOnboarding(
    OnboardingState state,
    OnboardingNotifier notifier,
  ) async {
    setState(() {
      _isSubmitting = true;
    });

    final profileNotifier = ref.read(businessProfileProvider.notifier);
    await profileNotifier.createFromOnboarding(state.answers);

    if (!mounted) return;

    final profileState = ref.read(businessProfileProvider);
    if (profileState.hasError) {
      setState(() {
        _isSubmitting = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context).errorSaveFailed),
        ),
      );
      return;
    }

    notifier.complete();
    const HomeRoute().go(context);
  }
}

class _OnboardingQuestionHeader extends StatelessWidget {
  const _OnboardingQuestionHeader({
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: isDark
                ? AppColors.textPrimaryDark
                : AppColors.textPrimaryLight,
          ),
        ),
        AppSpacing.gapVerticalXs,
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 14,
            color: isDark
                ? AppColors.textSecondaryDark
                : AppColors.textSecondaryLight,
          ),
        ),
      ],
    );
  }
}

class _GeographyStep extends StatelessWidget {
  const _GeographyStep({
    required this.state,
    required this.notifier,
  });

  final OnboardingState state;
  final OnboardingNotifier notifier;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final options = [
      _OptionValue('ADDIS_ABABA', l10n.onboardingRegionAddis),
      _OptionValue('OROMIA', l10n.onboardingRegionOromia),
      _OptionValue('AMHARA', l10n.onboardingRegionAmhara),
      _OptionValue('TIGRAY', l10n.onboardingRegionTigray),
      _OptionValue('SIDAMA', l10n.onboardingRegionSidama),
      _OptionValue('SOUTH_WEST', l10n.onboardingRegionSouthWest),
      _OptionValue('SOUTHERN', l10n.onboardingRegionSouthern),
      _OptionValue('SOMALI', l10n.onboardingRegionSomali),
      _OptionValue('AFAR', l10n.onboardingRegionAfar),
      _OptionValue('BENISHANGUL_GUMUZ', l10n.onboardingRegionBenishangul),
      _OptionValue('GAMBELLA', l10n.onboardingRegionGambella),
      _OptionValue('HARARI', l10n.onboardingRegionHarari),
      _OptionValue('DIRE_DAWA', l10n.onboardingRegionDireDawa),
    ];

    return _OnboardingStepScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _OnboardingQuestionHeader(
            title: l10n.onboardingRegionTitle,
            subtitle: l10n.onboardingRegionSubtitle,
          ),
          AppSpacing.gapVerticalLg,
          ...options.map(
            (option) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: OnboardingOptionCard(
                title: option.label,
                selected: state.answers.region == option.value,
                onTap: () => notifier.setRegion(option.value),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LifecycleStep extends StatelessWidget {
  const _LifecycleStep({
    required this.state,
    required this.notifier,
  });

  final OnboardingState state;
  final OnboardingNotifier notifier;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final options = [
      _OptionValue('IDEA', l10n.onboardingLifecycleIdea),
      _OptionValue('REGISTRATION', l10n.onboardingLifecycleRegistration),
      _OptionValue('OPERATIONAL', l10n.onboardingLifecycleOperational),
      _OptionValue('SCALING', l10n.onboardingLifecycleScaling),
    ];

    return _OnboardingStepScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _OnboardingQuestionHeader(
            title: l10n.onboardingLifecycleTitle,
            subtitle: l10n.onboardingLifecycleSubtitle,
          ),
          AppSpacing.gapVerticalLg,
          ...options.map(
            (option) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: OnboardingOptionCard(
                title: option.label,
                selected: state.answers.lifecycleStage == option.value,
                onTap: () => notifier.setLifecycleStage(option.value),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _IndustryStep extends StatelessWidget {
  const _IndustryStep({
    required this.state,
    required this.notifier,
  });

  final OnboardingState state;
  final OnboardingNotifier notifier;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final options = [
      _OptionValue('trade', l10n.onboardingIndustryTrade),
      _OptionValue('manufacturing', l10n.onboardingIndustryManufacturing),
      _OptionValue('services', l10n.onboardingIndustryServices),
      _OptionValue('agriculture', l10n.onboardingIndustryAgriculture),
      _OptionValue('construction', l10n.onboardingIndustryConstruction),
    ];

    return _OnboardingStepScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _OnboardingQuestionHeader(
            title: l10n.onboardingIndustryTitle,
            subtitle: l10n.onboardingIndustrySubtitle,
          ),
          AppSpacing.gapVerticalLg,
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: options
                .map(
                  (option) => SizedBox(
                    width: (MediaQuery.of(context).size.width - 72) / 2,
                    child: OnboardingOptionCard(
                      title: option.label,
                      selected: state.answers.industry == option.value,
                      onTap: () => notifier.setIndustry(option.value),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _LegalTaxStep extends StatelessWidget {
  const _LegalTaxStep({
    required this.state,
    required this.notifier,
  });

  final OnboardingState state;
  final OnboardingNotifier notifier;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final legalOptions = [
      _OptionValue('sole-proprietor', l10n.onboardingLegalSoleProprietor),
      _OptionValue('plc', l10n.onboardingLegalPlc),
      _OptionValue('share-company', l10n.onboardingLegalShareCompany),
      _OptionValue('partnership', l10n.onboardingLegalPartnership),
      _OptionValue('cooperative', l10n.onboardingLegalCooperative),
    ];
    final taxOptions = [
      _OptionValue('tax-vat', l10n.onboardingTaxVat),
      _OptionValue('tax-tot', l10n.onboardingTaxTot),
      _OptionValue('tax-excise', l10n.onboardingTaxExcise),
      _OptionValue('tax-exempt', l10n.onboardingTaxExempt),
    ];

    return _OnboardingStepScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _OnboardingQuestionHeader(
            title: l10n.onboardingLegalTitle,
            subtitle: l10n.onboardingLegalSubtitle,
          ),
          AppSpacing.gapVerticalLg,
          ...legalOptions.map(
            (option) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: OnboardingOptionCard(
                title: option.label,
                selected: state.answers.legalStructure == option.value,
                onTap: () => notifier.setLegalStructure(option.value),
              ),
            ),
          ),
          AppSpacing.gapVerticalLg,
          Text(
            l10n.onboardingTaxTitle,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).brightness == Brightness.dark
                  ? AppColors.textPrimaryDark
                  : AppColors.textPrimaryLight,
            ),
          ),
          AppSpacing.gapVerticalSm,
          ...taxOptions.map(
            (option) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: OnboardingOptionCard(
                title: option.label,
                selected: state.answers.taxStatus == option.value,
                onTap: () => notifier.setTaxStatus(option.value),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OperationsStep extends StatelessWidget {
  const _OperationsStep({
    required this.state,
    required this.notifier,
  });

  final OnboardingState state;
  final OnboardingNotifier notifier;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final options = [
      _OptionValue('op-importer', l10n.onboardingOpsImporter),
      _OptionValue('op-exporter', l10n.onboardingOpsExporter),
      _OptionValue('op-tender', l10n.onboardingOpsTender),
      _OptionValue('op-food-handling', l10n.onboardingOpsFoodHandling),
      _OptionValue('op-vehicles', l10n.onboardingOpsVehicles),
      _OptionValue('op-hazardous', l10n.onboardingOpsHazardous),
      _OptionValue('op-ecommerce', l10n.onboardingOpsEcommerce),
      _OptionValue('op-home-based', l10n.onboardingOpsHomeBased),
      _OptionValue('has-employees', l10n.onboardingOpsEmployees),
    ];

    return _OnboardingStepScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _OnboardingQuestionHeader(
            title: l10n.onboardingOpsTitle,
            subtitle: l10n.onboardingOpsSubtitle,
          ),
          AppSpacing.gapVerticalLg,
          ...options.map(
            (option) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: OnboardingOptionCard(
                title: option.label,
                selected: state.answers.operations.contains(option.value),
                onTap: () => notifier.toggleOperation(option.value),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DemographicsStep extends StatelessWidget {
  const _DemographicsStep({
    required this.state,
    required this.notifier,
  });

  final OnboardingState state;
  final OnboardingNotifier notifier;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final options = [
      _OptionValue('demo-women-owned', l10n.onboardingDemoWomenOwned),
      _OptionValue('demo-youth', l10n.onboardingDemoYouth),
      _OptionValue('demo-investor', l10n.onboardingDemoInvestor),
    ];

    return _OnboardingStepScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _OnboardingQuestionHeader(
            title: l10n.onboardingDemoTitle,
            subtitle: l10n.onboardingDemoSubtitle,
          ),
          AppSpacing.gapVerticalLg,
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: options
                .map(
                  (option) => OnboardingOptionChip(
                    label: option.label,
                    selected: state.answers.demographics.contains(option.value),
                    onTap: () => notifier.toggleDemographic(option.value),
                  ),
                )
                .toList(),
          ),
          AppSpacing.gapVerticalLg,
          Text(
            l10n.onboardingDemoOptional,
            style: TextStyle(
              fontSize: 13,
              color: Theme.of(context).brightness == Brightness.dark
                  ? AppColors.textSecondaryDark
                  : AppColors.textSecondaryLight,
            ),
          ),
        ],
      ),
    );
  }
}

class _OnboardingStepScaffold extends StatelessWidget {
  const _OnboardingStepScaffold({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: AppSpacing.paddingLg,
      child: child,
    );
  }
}

class _OptionValue {
  const _OptionValue(this.value, this.label);

  final String value;
  final String label;
}
