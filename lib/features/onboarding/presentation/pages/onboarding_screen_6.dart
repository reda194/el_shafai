import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neurocare_app/core/constants/app_colors.dart';
import 'package:neurocare_app/core/constants/app_strings.dart';
import 'package:neurocare_app/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:neurocare_app/features/onboarding/presentation/widgets/onboarding_illustration_6.dart';

class OnboardingScreen6 extends StatelessWidget {
  const OnboardingScreen6({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.onboardingBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const Spacer(flex: 1),

              // Illustration
              const OnboardingIllustration6(),

              const Spacer(flex: 1),

              // Title
              const Text(
                AppStrings.onboardingTitle6,
                style: TextStyle(
                  fontFamily: 'IBM Plex Sans Arabic',
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                  height: 1.15,
                ),
                textAlign: TextAlign.right,
              ),

              const SizedBox(height: 16),

              // Subtitle
              const Text(
                AppStrings.onboardingSubtitle6,
                style: TextStyle(
                  fontFamily: 'IBM Plex Sans Arabic',
                  fontSize: 16,
                  color: AppColors.onboardingTextSecondary,
                  height: 1.5,
                ),
                textAlign: TextAlign.right,
              ),

              const Spacer(flex: 2),

              // Slider Indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 9,
                    height: 9,
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width: 9,
                    height: 9,
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width: 9,
                    height: 9,
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width: 9,
                    height: 9,
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width: 9,
                    height: 9,
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width: 18,
                    height: 7,
                    decoration: BoxDecoration(
                      color: AppColors.onboardingButtonPrimary,
                      borderRadius: BorderRadius.circular(3.5),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 40),

              // Buttons
              Row(
                children: [
                  // Previous Button
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        context.read<OnboardingCubit>().previousPage();
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                            color: AppColors.onboardingButtonSecondary),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(11),
                        ),
                      ),
                      child: const Text(
                        'السابق',
                        style: TextStyle(
                          fontFamily: 'IBM Plex Sans Arabic',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.onboardingButtonSecondary,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 10),

                  // Start Button
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<OnboardingCubit>().skipOnboarding();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.onboardingButtonPrimary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(11),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'ابدأ الآن',
                        style: TextStyle(
                          fontFamily: 'IBM Plex Sans Arabic',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
