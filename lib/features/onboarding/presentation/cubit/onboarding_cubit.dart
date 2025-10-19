import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  final PageController pageController = PageController();

  OnboardingCubit() : super(const OnboardingInitial(currentPage: 0));

  void nextPage() {
    final currentPage = state.currentPage;
    if (currentPage < 5) {
      // Assuming 6 onboarding screens (0-5)
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      emit(OnboardingPageChanged(currentPage: currentPage + 1));
    } else {
      emit(const OnboardingCompleted());
    }
  }

  void previousPage() {
    final currentPage = state.currentPage;
    if (currentPage > 0) {
      pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      emit(OnboardingPageChanged(currentPage: currentPage - 1));
    }
  }

  void skipOnboarding() {
    emit(const OnboardingCompleted());
  }

  void goToPage(int page) {
    if (page >= 0 && page <= 5) {
      pageController.animateToPage(
        page,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      emit(OnboardingPageChanged(currentPage: page));
    }
  }

  @override
  Future<void> close() {
    pageController.dispose();
    return super.close();
  }
}
