import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:neurocare_app/core/constants/app_colors.dart';
import 'package:neurocare_app/core/routes/route_names.dart';
import 'package:neurocare_app/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:neurocare_app/shared/widgets/buttons/primary_button.dart';
import 'package:neurocare_app/shared/widgets/inputs/custom_text_field.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
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
        body: BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthLoading) {
              setState(() => _isLoading = true);
            } else {
              setState(() => _isLoading = false);
            }

            if (state is AuthSuccess) {
              context.go(RouteNames.checkEmail);
            } else if (state is AuthFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              return SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 40.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // Header
                        const Text(
                          'نسيت كلمة المرور؟',
                          style: TextStyle(
                            fontFamily: 'IBM Plex Sans Arabic',
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                            height: 1.2,
                          ),
                          textAlign: TextAlign.right,
                        ),

                        const SizedBox(height: 16),

                        const Text(
                          'لا تقلق! أدخل بريدك الإلكتروني وسنرسل لك رابط إعادة تعيين كلمة المرور',
                          style: TextStyle(
                            fontFamily: 'IBM Plex Sans Arabic',
                            fontSize: 16,
                            color: AppColors.homeSecondaryText,
                            height: 1.5,
                          ),
                          textAlign: TextAlign.right,
                        ),

                        const SizedBox(height: 48),

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

                        const SizedBox(height: 32),

                        // Send Reset Link Button
                        PrimaryButton(
                          text: 'إرسال رابط إعادة التعيين',
                          onPressed: _handleForgotPassword,
                          isLoading: _isLoading,
                        ),

                        const SizedBox(height: 24),

                        // Back to Login
                        Center(
                          child: TextButton(
                            onPressed: () => context.pop(),
                            child: const Text(
                              'العودة لتسجيل الدخول',
                              style: TextStyle(
                                fontFamily: 'IBM Plex Sans Arabic',
                                fontSize: 16,
                                color: AppColors.primary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _handleForgotPassword() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthCubit>().forgotPassword(_emailController.text.trim());
    }
  }
}
