import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:neurocare_app/core/constants/app_colors.dart';
import 'package:neurocare_app/core/routes/route_names.dart';
import 'package:neurocare_app/shared/widgets/buttons/primary_button.dart';

class CreateNewPasswordScreen extends StatelessWidget {
  const CreateNewPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.onboardingBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),

              // Success Icon
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle,
                  size: 80,
                  color: Colors.green,
                ),
              ),

              const SizedBox(height: 32),

              // Title
              const Text(
                'تم إعادة تعيين كلمة المرور بنجاح!',
                style: TextStyle(
                  fontFamily: 'IBM Plex Sans Arabic',
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                  height: 1.2,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 16),

              // Description
              const Text(
                'لقد تم تحديث كلمة مرور حسابك بنجاح. يمكنك الآن تسجيل الدخول باستخدام كلمة المرور الجديدة.',
                style: TextStyle(
                  fontFamily: 'IBM Plex Sans Arabic',
                  fontSize: 16,
                  color: AppColors.homeSecondaryText,
                  height: 1.6,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 48),

              // Back to Login Button
              PrimaryButton(
                text: 'العودة لتسجيل الدخول',
                onPressed: () => context.go(RouteNames.login),
              ),

              const SizedBox(height: 24),

              // Go to Home Button
              TextButton(
                onPressed: () => context.go(RouteNames.home),
                child: const Text(
                  'الذهاب إلى الصفحة الرئيسية',
                  style: TextStyle(
                    fontFamily: 'IBM Plex Sans Arabic',
                    fontSize: 16,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              const SizedBox(height: 48),

              // Security Tips Card
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      offset: const Offset(0, 2),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Icon(
                      Icons.security,
                      color: AppColors.primary,
                      size: 32,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'نصائح أمان كلمة المرور',
                      style: TextStyle(
                        fontFamily: 'IBM Plex Sans Arabic',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    _buildTip('استخدم كلمة مرور قوية تحتوي على أحرف وأرقام'),
                    _buildTip('لا تشارك كلمة مرورك مع أي شخص'),
                    _buildTip('غير كلمة مرورك بانتظام'),
                    _buildTip('استخدم مدير كلمات مرور آمن'),
                  ],
                ),
              ),

              const SizedBox(height: 48),

              // Contact Support
              Center(
                child: TextButton.icon(
                  onPressed: () => _contactSupport(context),
                  icon: const Icon(
                    Icons.contact_support,
                    color: AppColors.primary,
                  ),
                  label: const Text(
                    'هل تحتاج مساعدة؟ تواصل مع الدعم',
                    style: TextStyle(
                      fontFamily: 'IBM Plex Sans Arabic',
                      fontSize: 14,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTip(String tip) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          const Icon(
            Icons.check_circle,
            color: Colors.green,
            size: 16,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              tip,
              style: const TextStyle(
                fontFamily: 'IBM Plex Sans Arabic',
                fontSize: 14,
                color: AppColors.homeSecondaryText,
                height: 1.4,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  void _contactSupport(BuildContext context) {
    // Navigate to support or show contact dialog
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('سيتم توجيهك إلى صفحة الدعم')),
    );
  }
}
