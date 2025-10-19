import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:neurocare_app/core/constants/app_colors.dart';
import 'package:neurocare_app/core/routes/route_names.dart';
import 'package:neurocare_app/shared/widgets/buttons/primary_button.dart';
import 'package:neurocare_app/shared/widgets/buttons/secondary_button.dart';

class CheckEmailScreen extends StatelessWidget {
  const CheckEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.onboardingBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.primary,
          ),
          onPressed: () => context.go(RouteNames.forgotPassword),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Email Icon
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.email_outlined,
                  size: 60,
                  color: AppColors.primary,
                ),
              ),

              const SizedBox(height: 32),

              // Title
              const Text(
                'تحقق من بريدك الإلكتروني',
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
                'لقد أرسلنا رابط إعادة تعيين كلمة المرور إلى بريدك الإلكتروني. يرجى التحقق من بريدك الإلكتروني والنقر على الرابط لإعادة تعيين كلمة المرور.',
                style: TextStyle(
                  fontFamily: 'IBM Plex Sans Arabic',
                  fontSize: 16,
                  color: AppColors.homeSecondaryText,
                  height: 1.6,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 48),

              // Open Email App Button
              PrimaryButton(
                text: 'فتح تطبيق البريد الإلكتروني',
                onPressed: () => _openEmailApp(context),
                icon: Icons.email,
              ),

              const SizedBox(height: 16),

              // Didn't receive email?
              TextButton(
                onPressed: () => context.go(RouteNames.forgotPassword),
                child: const Text(
                  'لم تستلم البريد الإلكتروني؟',
                  style: TextStyle(
                    fontFamily: 'IBM Plex Sans Arabic',
                    fontSize: 16,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Resend Email
              SecondaryButton(
                text: 'إعادة إرسال البريد الإلكتروني',
                onPressed: () => _resendEmail(context),
              ),

              const SizedBox(height: 32),

              // Back to Login
              Center(
                child: TextButton(
                  onPressed: () => context.go(RouteNames.login),
                  child: const Text(
                    'العودة لتسجيل الدخول',
                    style: TextStyle(
                      fontFamily: 'IBM Plex Sans Arabic',
                      fontSize: 16,
                      color: AppColors.homeSecondaryText,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 48),

              // Info Card
              Container(
                padding: const EdgeInsets.all(20),
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
                child: const Column(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: AppColors.primary,
                      size: 32,
                    ),
                    SizedBox(height: 12),
                    Text(
                      'نصائح للتحقق من البريد الإلكتروني',
                      style: TextStyle(
                        fontFamily: 'IBM Plex Sans Arabic',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'تحقق من مجلد الرسائل غير المرغوبة (Spam/Junk) إذا لم تجد البريد في البريد الوارد',
                      style: TextStyle(
                        fontFamily: 'IBM Plex Sans Arabic',
                        fontSize: 14,
                        color: AppColors.homeSecondaryText,
                        height: 1.4,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openEmailApp(BuildContext context) {
    // This would typically open the default email app
    // For now, we'll show a message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('سيتم فتح تطبيق البريد الإلكتروني')),
    );
  }

  void _resendEmail(BuildContext context) {
    // This would trigger resending the email
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تم إعادة إرسال البريد الإلكتروني')),
    );
  }
}
