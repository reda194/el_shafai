import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neurocare_app/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:neurocare_app/features/onboarding/presentation/pages/onboarding_screen_1.dart';
import 'package:neurocare_app/features/onboarding/presentation/pages/onboarding_screen_2.dart';
import 'package:neurocare_app/features/onboarding/presentation/pages/onboarding_screen_3.dart';
import 'package:neurocare_app/features/onboarding/presentation/pages/onboarding_screen_4.dart';
import 'package:neurocare_app/features/onboarding/presentation/pages/onboarding_screen_5.dart';
import 'package:neurocare_app/features/onboarding/presentation/pages/onboarding_screen_6.dart';
import 'package:neurocare_app/features/authentication/presentation/pages/welcome_screen.dart';

class OnboardingFlow extends StatelessWidget {
  const OnboardingFlow({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnboardingCubit(),
      child: BlocListener<OnboardingCubit, OnboardingState>(
        listener: (context, state) {
          if (state is OnboardingCompleted) {
            // Navigate to authentication screens
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const WelcomeScreen()),
            );
          }
        },
        child: BlocBuilder<OnboardingCubit, OnboardingState>(
          builder: (context, state) {
            final cubit = context.read<OnboardingCubit>();
            return PageView(
              controller: cubit.pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                OnboardingScreen1(),
                OnboardingScreen2(),
                OnboardingScreen3(),
                OnboardingScreen4(),
                OnboardingScreen5(),
                OnboardingScreen6(),
              ],
            );
          },
        ),
      ),
    );
  }
}
