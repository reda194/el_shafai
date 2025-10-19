import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:neurocare_app/config/dependency_injection.dart';
import 'package:neurocare_app/core/constants/app_colors.dart';
import 'package:neurocare_app/core/constants/app_strings.dart';
import 'package:neurocare_app/core/routes/route_names.dart';
import 'package:neurocare_app/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:neurocare_app/shared/widgets/buttons/primary_button.dart';
import 'package:neurocare_app/shared/widgets/inputs/custom_text_field.dart';
import 'package:neurocare_app/shared/widgets/inputs/password_field.dart';

class LoginFormScreen extends StatelessWidget {
  const LoginFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthCubit>(),
      child: const _LoginFormScreenContent(),
    );
  }
}

class _LoginFormScreenContent extends StatefulWidget {
  const _LoginFormScreenContent();

  @override
  State<_LoginFormScreenContent> createState() => _LoginFormScreenState();
}

class _LoginFormScreenState extends State<_LoginFormScreenContent> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;
  bool _rememberMe = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoading) {
          setState(() => _isLoading = true);
        } else {
          setState(() => _isLoading = false);
        }

        if (state is AuthSuccess) {
          context.go(RouteNames.home);
        } else if (state is AuthFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.onboardingBackground,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: AppColors.primary,
            ),
            onPressed: () => context.pop(),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Header
                  const Text(
                    'تسجيل الدخول',
                    style: TextStyle(
                      fontFamily: 'IBM Plex Sans Arabic',
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                      height: 1.2,
                    ),
                    textAlign: TextAlign.right,
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    'أدخل بريدك الإلكتروني وكلمة المرور للوصول إلى حسابك',
                    style: TextStyle(
                      fontFamily: 'IBM Plex Sans Arabic',
                      fontSize: 16,
                      color: AppColors.homeSecondaryText,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.right,
                  ),

                  const SizedBox(height: 40),

                  // Email Field
                  CustomTextField(
                    controller: _emailController,
                    labelText: 'البريد الإلكتروني',
                    hintText: 'أدخل بريدك الإلكتروني',
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'البريد الإلكتروني مطلوب';
                      }
                      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                          .hasMatch(value)) {
                        return 'يرجى إدخال بريد إلكتروني صحيح';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 24),

                  // Password Field
                  PasswordField(
                    controller: _passwordController,
                    labelText: 'كلمة المرور',
                    hintText: 'أدخل كلمة المرور',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'كلمة المرور مطلوبة';
                      }
                      if (value.length < 8) {
                        return 'كلمة المرور يجب أن تكون 8 أحرف على الأقل';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  // Remember Me & Forgot Password Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Forgot Password
                      TextButton(
                        onPressed: () => context.go(RouteNames.forgotPassword),
                        child: const Text(
                          AppStrings.forgotPassword,
                          style: TextStyle(
                            fontFamily: 'IBM Plex Sans Arabic',
                            fontSize: 14,
                            color: AppColors.primary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                      // Remember Me
                      Row(
                        children: [
                          const Text(
                            'تذكرني',
                            style: TextStyle(
                              fontFamily: 'IBM Plex Sans Arabic',
                              fontSize: 14,
                              color: AppColors.homeSecondaryText,
                            ),
                          ),
                          Checkbox(
                            value: _rememberMe,
                            onChanged: (value) {
                              setState(() => _rememberMe = value ?? false);
                            },
                            activeColor: AppColors.primary,
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // Login Button
                  PrimaryButton(
                    text: 'تسجيل الدخول',
                    onPressed: _handleLogin,
                    isLoading: _isLoading,
                  ),

                  const SizedBox(height: 24),

                  // Don't have account
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'ليس لديك حساب؟',
                          style: TextStyle(
                            fontFamily: 'IBM Plex Sans Arabic',
                            fontSize: 14,
                            color: AppColors.homeSecondaryText,
                          ),
                        ),
                        const SizedBox(width: 4),
                        TextButton(
                          onPressed: () => context.go(RouteNames.register),
                          child: const Text(
                            'إنشاء حساب',
                            style: TextStyle(
                              fontFamily: 'IBM Plex Sans Arabic',
                              fontSize: 14,
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
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
      ),
    );
  }

  void _handleLogin() {
    if (_formKey.currentState?.validate() ?? false) {
      // TODO: Implement login logic
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('سيتم تنفيذ تسجيل الدخول قريباً')),
      );
    }
  }
}
