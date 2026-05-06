import '../domain/entities/onboarding_answers.dart';

class OnboardingState {
  const OnboardingState({
    required this.currentStep,
    required this.answers,
    required this.isComplete,
  });

  factory OnboardingState.initial() {
    return const OnboardingState(
      currentStep: 0,
      answers: OnboardingAnswers(),
      isComplete: false,
    );
  }

  final int currentStep;
  final OnboardingAnswers answers;
  final bool isComplete;

  OnboardingState copyWith({
    int? currentStep,
    OnboardingAnswers? answers,
    bool? isComplete,
  }) {
    return OnboardingState(
      currentStep: currentStep ?? this.currentStep,
      answers: answers ?? this.answers,
      isComplete: isComplete ?? this.isComplete,
    );
  }
}
