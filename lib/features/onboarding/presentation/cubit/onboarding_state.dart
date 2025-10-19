part of 'onboarding_cubit.dart';

abstract class OnboardingState extends Equatable {
  const OnboardingState({required this.currentPage});

  final int currentPage;

  @override
  List<Object> get props => [currentPage];
}

class OnboardingInitial extends OnboardingState {
  const OnboardingInitial({required super.currentPage});
}

class OnboardingPageChanged extends OnboardingState {
  const OnboardingPageChanged({required super.currentPage});
}

class OnboardingCompleted extends OnboardingState {
  const OnboardingCompleted() : super(currentPage: 5);
}
