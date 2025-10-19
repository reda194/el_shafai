import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:neurocare_app/core/constants/app_colors.dart';
import 'package:neurocare_app/core/constants/app_strings.dart';
import 'package:neurocare_app/core/constants/app_assets.dart';
import 'package:neurocare_app/core/routes/route_names.dart';
import 'package:neurocare_app/core/services/storage_service.dart';
import 'package:neurocare_app/core/constants/storage_keys.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  /// Handle social login (Apple, Google)
  Future<void> _handleSocialLogin(BuildContext context, String provider) async {
    // Show loading indicator
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('جاري تسجيل الدخول...'),
            ],
          ),
        ),
      ),
    );

    try {
      // TODO: Implement actual social login
      await Future.delayed(const Duration(seconds: 2));

      // For now, simulate successful login
      final storageService = StorageService();
      await storageService
          .saveAuthToken('demo_token_${DateTime.now().millisecondsSinceEpoch}');
      await storageService.savePreference(StorageKeys.isLoggedIn, true);
      await storageService.savePreference(
          StorageKeys.userEmail, 'demo@example.com');

      if (context.mounted) {
        Navigator.of(context).pop(); // Close loading dialog
        context.go(RouteNames.home);
      }
    } catch (e) {
      if (context.mounted) {
        Navigator.of(context).pop(); // Close loading dialog
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('فشل تسجيل الدخول: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.authBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const Spacer(flex: 1),

              // Logo
              Semantics(
                label: 'شعار تطبيق شفائي',
                image: true,
                child: SvgPicture.asset(
                  AppAssets.logo,
                  width: 56.405,
                  height: 65.147,
                ),
              ),

              const Spacer(flex: 1),

              // Title
              Text(
                AppStrings.welcomeTitle,
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.bold,
                        ) ??
                    const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                      height: 1.2,
                    ),
                textAlign: TextAlign.right,
              ),

              const SizedBox(height: 16),

              // Subtitle
              Text(
                AppStrings.welcomeSubtitle,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColors.onboardingTextSecondary,
                        ) ??
                    const TextStyle(
                      fontSize: 16,
                      color: AppColors.onboardingTextSecondary,
                      height: 1.5,
                    ),
                textAlign: TextAlign.right,
              ),

              const Spacer(flex: 2),

              // Social Login Buttons
              Column(
                children: [
                  // Apple Button
                  Semantics(
                    label: 'المتابعة باستخدام Apple',
                    button: true,
                    hint: 'اضغط لتسجيل الدخول بحساب Apple',
                    child: SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () => _handleSocialLogin(context, 'Apple'),
                        style: OutlinedButton.styleFrom(
                          backgroundColor: AppColors.authButtonTransparent,
                          side: const BorderSide(
                              color: AppColors.authTextPrimary),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          minimumSize: const Size(double.infinity, 48),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(11),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              AppAssets.appleIcon,
                              width: 24,
                              height: 24,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              AppStrings.continueWithApple,
                              style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                        color: AppColors.authTextPrimary,
                                        fontWeight: FontWeight.w500,
                                      ) ??
                                  const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: AppColors.authTextPrimary,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Google Button
                  Semantics(
                    label: 'المتابعة باستخدام Google',
                    button: true,
                    hint: 'اضغط لتسجيل الدخول بحساب Google',
                    child: SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () => _handleSocialLogin(context, 'Google'),
                        style: OutlinedButton.styleFrom(
                          backgroundColor: AppColors.authButtonTransparent,
                          side: const BorderSide(
                              color: AppColors.authTextPrimary),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          minimumSize: const Size(double.infinity, 48),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(11),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              AppAssets.googleIcon,
                              width: 24,
                              height: 24,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              AppStrings.continueWithGoogle,
                              style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                        color: AppColors.authTextPrimary,
                                        fontWeight: FontWeight.w500,
                                      ) ??
                                  const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: AppColors.authTextPrimary,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Email Button
                  Semantics(
                    label: 'المتابعة بالبريد الإلكتروني',
                    button: true,
                    hint: 'اضغط لتسجيل الدخول بالبريد الإلكتروني',
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          context.push(RouteNames.login);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.authButtonSolid,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          minimumSize: const Size(double.infinity, 48),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(11),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          AppStrings.continueWithEmail,
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                        color: AppColors.authTextSecondary,
                                        fontWeight: FontWeight.w500,
                                      ) ??
                                  const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: AppColors.authTextSecondary,
                                  ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Already have account link
              Semantics(
                label: 'لديك حساب بالفعل؟ تسجيل الدخول',
                button: true,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppStrings.alreadyHaveAccount,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: AppColors.authTextPrimary,
                              ) ??
                          const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: AppColors.authTextPrimary,
                          ),
                    ),
                    const SizedBox(width: 4),
                    TextButton(
                      onPressed: () {
                        context.push(RouteNames.login);
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(8),
                        minimumSize: const Size(48, 48),
                      ),
                      child: Text(
                        AppStrings.signIn,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: AppColors.authTextPrimary,
                                  fontWeight: FontWeight.w600,
                                  decoration: TextDecoration.underline,
                                ) ??
                            const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: AppColors.authTextPrimary,
                              decoration: TextDecoration.underline,
                            ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
