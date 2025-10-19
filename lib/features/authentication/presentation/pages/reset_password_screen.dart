import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:neurocare_app/core/constants/app_colors.dart';
import 'package:neurocare_app/core/routes/route_names.dart';
import 'package:neurocare_app/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:neurocare_app/shared/widgets/buttons/primary_button.dart';
import 'package:neurocare_app/shared/widgets/inputs/password_field.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
              context.go(RouteNames.createNewPassword);
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
                          'إعادة تعيين كلمة المرور',
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
                          'أدخل كلمة مرور جديدة قوية لحسابك',
                          style: TextStyle(
                            fontFamily: 'IBM Plex Sans Arabic',
                            fontSize: 16,
                            color: AppColors.homeSecondaryText,
                            height: 1.5,
                          ),
                          textAlign: TextAlign.right,
                        ),

                        const SizedBox(height: 48),

                        // New Password Field
                        PasswordField(
                          controller: _passwordController,
                          labelText: 'كلمة المرور الجديدة',
                          hintText: 'أدخل كلمة مرور جديدة',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'كلمة المرور مطلوبة';
                            }
                            if (value.length < 8) {
                              return 'كلمة المرور يجب أن تكون 8 أحرف على الأقل';
                            }
                            if (!RegExp(r'[A-Z]').hasMatch(value)) {
                              return 'كلمة المرور يجب أن تحتوي على حرف كبير';
                            }
                            if (!RegExp(r'[a-z]').hasMatch(value)) {
                              return 'كلمة المرور يجب أن تحتوي على حرف صغير';
                            }
                            if (!RegExp(r'[0-9]').hasMatch(value)) {
                              return 'كلمة المرور يجب أن تحتوي على رقم';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 24),

                        // Confirm Password Field
                        PasswordField(
                          controller: _confirmPasswordController,
                          labelText: 'تأكيد كلمة المرور',
                          hintText: 'أعد إدخال كلمة المرور الجديدة',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'تأكيد كلمة المرور مطلوب';
                            }
                            if (value != _passwordController.text) {
                              return 'كلمة المرور غير متطابقة';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 16),

                        // Password Requirements
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.blue.withOpacity(0.3),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text(
                                'متطلبات كلمة المرور:',
                                style: TextStyle(
                                  fontFamily: 'IBM Plex Sans Arabic',
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                ),
                                textAlign: TextAlign.right,
                              ),
                              const SizedBox(height: 8),
                              _buildRequirement('8 أحرف على الأقل',
                                  _passwordController.text.length >= 8),
                              _buildRequirement(
                                  'حرف كبير واحد على الأقل',
                                  RegExp(r'[A-Z]')
                                      .hasMatch(_passwordController.text)),
                              _buildRequirement(
                                  'حرف صغير واحد على الأقل',
                                  RegExp(r'[a-z]')
                                      .hasMatch(_passwordController.text)),
                              _buildRequirement(
                                  'رقم واحد على الأقل',
                                  RegExp(r'[0-9]')
                                      .hasMatch(_passwordController.text)),
                            ],
                          ),
                        ),

                        const SizedBox(height: 32),

                        // Reset Password Button
                        PrimaryButton(
                          text: 'إعادة تعيين كلمة المرور',
                          onPressed: _handleResetPassword,
                          isLoading: _isLoading,
                        ),

                        const SizedBox(height: 24),

                        // Back to Login
                        Center(
                          child: TextButton(
                            onPressed: () => context.go(RouteNames.login),
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

  Widget _buildRequirement(String text, bool isMet) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            text,
            style: TextStyle(
              fontFamily: 'IBM Plex Sans Arabic',
              fontSize: 12,
              color: isMet ? Colors.green : AppColors.homeSecondaryText,
            ),
            textAlign: TextAlign.right,
          ),
          const SizedBox(width: 8),
          Icon(
            isMet ? Icons.check_circle : Icons.circle,
            size: 14,
            color: isMet ? Colors.green : AppColors.homeSecondaryText,
          ),
        ],
      ),
    );
  }

  void _handleResetPassword() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthCubit>().resetPassword(
            _passwordController.text,
            _confirmPasswordController.text,
          );
    }
  }
}
