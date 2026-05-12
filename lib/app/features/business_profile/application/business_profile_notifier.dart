import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/di/business_profile_providers.dart';
import '../../onboarding/domain/entities/onboarding_answers.dart';
import '../domain/entities/business_profile.dart';
import '../domain/failures/business_profile_failure.dart';

part 'business_profile_notifier.g.dart';

@riverpod
class BusinessProfileNotifier extends _$BusinessProfileNotifier {
  @override
  Future<BusinessProfile?> build() async {
    final repository = ref.read(businessProfileRepositoryProvider);
    final result = await repository.getBusinessProfile();
    return result.fold(
      (failure) => failure.maybeWhen(
        notFound: () => null,
        orElse: () =>
            throw Exception('Failed to load business profile: $failure'),
      ),
      (profile) => profile,
    );
  }

  bool get hasBusinessProfile => state.value != null;

  Future<void> refreshProfile() async {
    state = const AsyncValue.loading();
    final nextState = await AsyncValue.guard(() async {
      final repository = ref.read(businessProfileRepositoryProvider);
      final result = await repository.getBusinessProfile();
      return result.fold(
        (failure) => failure.maybeWhen(
          notFound: () => null,
          orElse: () =>
              throw Exception('Failed to refresh business profile: $failure'),
        ),
        (profile) => profile,
      );
    });
    if (!ref.mounted) return;
    state = nextState;
  }

  Future<void> createFromOnboarding(OnboardingAnswers answers) async {
    state = const AsyncValue.loading();
    final nextState = await AsyncValue.guard(() async {
      final repository = ref.read(businessProfileRepositoryProvider);
      final tagSlugs = <String>[
        if (answers.legalStructure != null) answers.legalStructure!,
        if (answers.taxStatus != null) answers.taxStatus!,
        ...answers.operations,
        ...answers.demographics,
      ];

      final result = await repository.createBusinessProfile(
        region: answers.region,
        stage: answers.lifecycleStage,
        sectorSlug: answers.industry,
        tagSlugs: tagSlugs,
      );

      return result.fold(
        (failure) =>
            throw Exception('Failed to create business profile: $failure'),
        (profile) => profile,
      );
    });
    if (!ref.mounted) return;
    state = nextState;
  }

  Future<void> updateProfile({
    String? companyName,
    String? companyEmail,
    String? companyPhoneNumber,
    String? physicalAddress,
    String? description,
    String? region,
    String? stage,
    String? sectorSlug,
    List<String>? tagSlugs,
  }) async {
    final current = state.value;
    if (current == null) {
      state = AsyncValue.error(
        const BusinessProfileFailure.notFound(),
        StackTrace.current,
      );
      return;
    }

    state = const AsyncValue.loading();
    final nextState = await AsyncValue.guard(() async {
      final repository = ref.read(businessProfileRepositoryProvider);
      final result = await repository.updateBusinessProfile(
        companyName: companyName,
        companyEmail: companyEmail,
        companyPhoneNumber: companyPhoneNumber,
        physicalAddress: physicalAddress,
        description: description,
        region: region,
        stage: stage,
        sectorSlug: sectorSlug,
        tagSlugs: tagSlugs,
      );

      return result.fold(
        (failure) =>
            throw Exception('Failed to update business profile: $failure'),
        (profile) => profile,
      );
    });
    if (!ref.mounted) return;
    state = nextState;
  }
}
