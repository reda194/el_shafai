import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:neurocare_app/core/constants/app_colors.dart';
import 'package:neurocare_app/core/constants/app_assets.dart';
import 'package:neurocare_app/core/routes/route_names.dart';
import 'package:neurocare_app/shared/widgets/buttons/primary_button.dart';

class WelcomeScreen4 extends StatelessWidget {
  const WelcomeScreen4({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
          child: Column(
            children: [
              // Header with Logo
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(
                    AppAssets.logo,
                    width: 40,
                    height: 46,
                    colorFilter: const ColorFilter.mode(
                      AppColors.primary,
                      BlendMode.srcIn,
                    ),
                  ),
                  TextButton(
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
                ],
              ),

              const SizedBox(height: 60),

              // Hero Image
              Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(150),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Background Pattern
                    Positioned.fill(
                      child: CustomPaint(
                        painter: WelcomePatternPainter(),
                      ),
                    ),

                    // Central Icon
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(60),
                      ),
                      child: const Icon(
                        Icons.health_and_safety,
                        color: Colors.white,
                        size: 60,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // Title
              const Text(
                'رعايتك الصحية\nفي متناول يدك',
                style: TextStyle(
                  fontFamily: 'IBM Plex Sans Arabic',
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                  height: 1.2,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 16),

              // Subtitle
              const Text(
                'انضم إلى آلاف المرضى الذين يثقون بنا في الحصول على أفضل الخدمات الطبية',
                style: TextStyle(
                  fontFamily: 'IBM Plex Sans Arabic',
                  fontSize: 16,
                  color: AppColors.homeSecondaryText,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),

              const Spacer(),

              // Stats Row
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildStatItem('5000+', 'طبيب'),
                    _buildStatItem('50000+', 'مريض'),
                    _buildStatItem('4.9', 'تقييم'),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // Action Buttons
              Column(
                children: [
                  PrimaryButton(
                    text: 'إنشاء حساب جديد',
                    onPressed: () => context.go(RouteNames.register),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () => context.go(RouteNames.loginForm),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppColors.primary),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'تسجيل الدخول',
                        style: TextStyle(
                          fontFamily: 'IBM Plex Sans Arabic',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
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

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontFamily: 'IBM Plex Sans Arabic',
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'IBM Plex Sans Arabic',
            fontSize: 12,
            color: AppColors.homeSecondaryText,
          ),
        ),
      ],
    );
  }
}

class WelcomePatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primary.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    // Draw some decorative circles
    canvas.drawCircle(Offset(size.width * 0.2, size.height * 0.3), 30, paint);
    canvas.drawCircle(Offset(size.width * 0.8, size.height * 0.7), 25, paint);
    canvas.drawCircle(Offset(size.width * 0.6, size.height * 0.2), 20, paint);
    canvas.drawCircle(Offset(size.width * 0.1, size.height * 0.8), 15, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
