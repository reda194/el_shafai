import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:neurocare_app/core/constants/app_colors.dart';
import 'package:neurocare_app/core/routes/route_names.dart';
import 'package:neurocare_app/shared/widgets/buttons/primary_button.dart';

class WelcomeScreen3 extends StatelessWidget {
  const WelcomeScreen3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.authBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
          child: Column(
            children: [
              // Skip Button
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () => context.go(RouteNames.home),
                  child: const Text(
                    'تخطي',
                    style: TextStyle(
                      fontFamily: 'IBM Plex Sans Arabic',
                      fontSize: 16,
                      color: AppColors.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),

              const Spacer(),

              // Illustration - Simple container for now
              Container(
                width: 220,
                height: 220,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(110),
                ),
                child: const Center(
                  child: Icon(
                    Icons.medical_services,
                    size: 80,
                    color: AppColors.primary,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Title
              const Text(
                'مرحباً بك في شفا',
                style: TextStyle(
                  fontFamily: 'IBM Plex Sans Arabic',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                  height: 1.2,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 12),

              // Subtitle
              const Text(
                'تطبيقك الشامل للرعاية الصحية والطبية',
                style: TextStyle(
                  fontFamily: 'IBM Plex Sans Arabic',
                  fontSize: 14,
                  color: AppColors.homeSecondaryText,
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),

              const Spacer(),

              // Features List
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _buildFeatureItem(
                      icon: Icons.medical_services,
                      title: 'استشارات طبية',
                      description: 'تواصل مع أفضل الأطباء في تخصصات مختلفة',
                    ),
                    const SizedBox(height: 12),
                    _buildFeatureItem(
                      icon: Icons.schedule,
                      title: 'حجز المواعيد',
                      description: 'احجز مواعيدك الطبية بسهولة وسرعة',
                    ),
                    const SizedBox(height: 12),
                    _buildFeatureItem(
                      icon: Icons.health_and_safety,
                      title: 'تتبع الصحة',
                      description: 'تابع مؤشراتك الصحية وتطوراتك الطبية',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Get Started Button
              PrimaryButton(
                text: 'ابدأ الآن',
                onPressed: () => context.go(RouteNames.loginForm),
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureItem({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(
            icon,
            color: AppColors.primary,
            size: 16,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontFamily: 'IBM Plex Sans Arabic',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
                textAlign: TextAlign.right,
              ),
              const SizedBox(height: 2),
              Text(
                description,
                style: const TextStyle(
                  fontFamily: 'IBM Plex Sans Arabic',
                  fontSize: 11,
                  color: AppColors.homeSecondaryText,
                  height: 1.3,
                ),
                textAlign: TextAlign.right,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
