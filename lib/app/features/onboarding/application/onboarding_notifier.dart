import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'onboarding_state.dart';

part 'onboarding_notifier.g.dart';

@riverpod
class OnboardingNotifier extends _$OnboardingNotifier {
  @override
  OnboardingState build() => OnboardingState.initial();

  void setRegion(String value) {
    state = state.copyWith(answers: state.answers.copyWith(region: value));
  }

  void setLifecycleStage(String value) {
    state = state.copyWith(
      answers: state.answers.copyWith(lifecycleStage: value),
    );
  }

  void setIndustry(String value) {
    state = state.copyWith(answers: state.answers.copyWith(industry: value));
  }

  void setLegalStructure(String value) {
    state = state.copyWith(
      answers: state.answers.copyWith(legalStructure: value),
    );
  }

  void setTaxStatus(String value) {
    state = state.copyWith(answers: state.answers.copyWith(taxStatus: value));
  }

  void toggleOperation(String value) {
    final current = state.answers.operations.toSet();
    if (current.contains(value)) {
      current.remove(value);
    } else {
      current.add(value);
    }
    state = state.copyWith(
      answers: state.answers.copyWith(operations: current),
    );
  }

  void toggleDemographic(String value) {
    final current = state.answers.demographics.toSet();
    if (current.contains(value)) {
      current.remove(value);
    } else {
      current.add(value);
    }
    state = state.copyWith(
      answers: state.answers.copyWith(demographics: current),
    );
  }

  void nextStep() {
    if (state.currentStep >= 5) return;
    state = state.copyWith(currentStep: state.currentStep + 1);
  }

  void previousStep() {
    if (state.currentStep <= 0) return;
    state = state.copyWith(currentStep: state.currentStep - 1);
  }

  void jumpToStep(int index) {
    if (index < 0 || index > 5) return;
    state = state.copyWith(currentStep: index);
  }

  void complete() {
    state = state.copyWith(isComplete: true);
  }

  void reset() {
    state = OnboardingState.initial();
  }
}
