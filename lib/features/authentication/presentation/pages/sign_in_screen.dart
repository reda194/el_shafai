import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:neurocare_app/core/constants/app_colors.dart';
import 'package:neurocare_app/core/constants/app_strings.dart';
import 'package:neurocare_app/core/constants/app_assets.dart';
import 'package:neurocare_app/core/constants/storage_keys.dart';
import 'package:neurocare_app/core/routes/route_names.dart';
import 'package:neurocare_app/core/services/storage_service.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool _isLoading = false;

  /// Handle social login (Apple, Google, Facebook)
  Future<void> _handleSocialLogin(String provider) async {
    setState(() => _isLoading = true);

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

      if (mounted) {
        context.go(RouteNames.home);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('فشل تسجيل الدخول بـ $provider: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 80),

                // Logo
                Semantics(
                  label: 'شعار تطبيق شفائي',
                  image: true,
                  child: SvgPicture.asset(
                    AppAssets.logo,
                    width: 56.40525817871094,
                    height: 65.14708709716797,
                  ),
                ),

                const SizedBox(height: 20),

                // App Name
                Text(
                  AppStrings.appName,
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ) ??
                      const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 40.047,
                        color: Colors.white,
                      ),
                ),

                const SizedBox(height: 54),

                // Social Login Buttons
                Column(
                  children: [
                    // Apple Button
                    Semantics(
                      label: 'تسجيل الدخول باستخدام Apple',
                      button: true,
                      enabled: !_isLoading,
                      child: SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: _isLoading
                              ? null
                              : () => _handleSocialLogin('Apple'),
                          style: OutlinedButton.styleFrom(
                            backgroundColor: AppColors.authButtonTransparent,
                            side: const BorderSide(color: Colors.white),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            minimumSize: const Size(double.infinity, 48),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(11),
                            ),
                          ),
                          child: _isLoading
                              ? const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : Row(
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
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                              ) ??
                                          const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                            color: Colors.white,
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
                      label: 'تسجيل الدخول باستخدام Google',
                      button: true,
                      enabled: !_isLoading,
                      child: SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: _isLoading
                              ? null
                              : () => _handleSocialLogin('Google'),
                          style: OutlinedButton.styleFrom(
                            backgroundColor: AppColors.authButtonTransparent,
                            side: const BorderSide(color: Colors.white),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            minimumSize: const Size(double.infinity, 48),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(11),
                            ),
                          ),
                          child: _isLoading
                              ? const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : Row(
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
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                              ) ??
                                          const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                            color: Colors.white,
                                          ),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Facebook Button
                    Semantics(
                      label: 'تسجيل الدخول باستخدام Facebook',
                      button: true,
                      enabled: !_isLoading,
                      child: SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: _isLoading
                              ? null
                              : () => _handleSocialLogin('Facebook'),
                          style: OutlinedButton.styleFrom(
                            backgroundColor: AppColors.authButtonTransparent,
                            side: const BorderSide(color: Colors.white),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            minimumSize: const Size(double.infinity, 48),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(11),
                            ),
                          ),
                          child: _isLoading
                              ? const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.facebook,
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                    const SizedBox(width: 12),
                                    Text(
                                      'المتابعة بـ Facebook',
                                      style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge
                                              ?.copyWith(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                              ) ??
                                          const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                            color: Colors.white,
                                          ),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                // Separator
                Row(
                  children: [
                    const Expanded(
                      child: Divider(
                        color: Colors.white,
                        thickness: 1,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      AppStrings.orContinueWith,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Colors.white,
                              ) ??
                          const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Colors.white,
                          ),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Divider(
                        color: Colors.white,
                        thickness: 1,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                // Sign In Button
                Semantics(
                  label: 'تسجيل الدخول بالبريد الإلكتروني',
                  button: true,
                  enabled: !_isLoading,
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isLoading
                          ? null
                          : () {
                              context.push(RouteNames.loginForm);
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        minimumSize: const Size(double.infinity, 48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(11),
                        ),
                        elevation: 0,
                      ),
                      child: _isLoading
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                color: AppColors.primary,
                                strokeWidth: 2,
                              ),
                            )
                          : Text(
                              AppStrings.signIn,
                              style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.w500,
                                      ) ??
                                  const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: AppColors.primary,
                                  ),
                            ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Forgot Password
                Semantics(
                  label: 'نسيت كلمة المرور',
                  button: true,
                  child: TextButton(
                    onPressed: () => context.push(RouteNames.forgotPassword),
                    style: TextButton.styleFrom(
                      minimumSize: const Size(48, 48),
                      padding: const EdgeInsets.all(8),
                    ),
                    child: Text(
                      AppStrings.forgotPassword,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Colors.white,
                                decoration: TextDecoration.underline,
                              ) ??
                          const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Colors.white,
                            decoration: TextDecoration.underline,
                          ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Sign Up Link
                Semantics(
                  label: 'ليس لديك حساب؟ إنشاء حساب جديد',
                  button: true,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'ليس لديك حساب؟',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: Colors.white,
                                ) ??
                            const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: Colors.white,
                            ),
                      ),
                      const SizedBox(width: 4),
                      TextButton(
                        onPressed: () {
                          context.push(RouteNames.register);
                        },
                        style: TextButton.styleFrom(
                          minimumSize: const Size(48, 48),
                          padding: const EdgeInsets.all(8),
                        ),
                        child: Text(
                          'إنشاء حساب',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        decoration: TextDecoration.underline,
                                      ) ??
                                  const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: Colors.white,
                                    decoration: TextDecoration.underline,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
