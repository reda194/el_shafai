import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:neurocare_app/core/constants/app_colors.dart';
import 'package:neurocare_app/core/routes/route_names.dart';
import 'package:neurocare_app/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:neurocare_app/shared/widgets/buttons/primary_button.dart';
import 'package:neurocare_app/shared/widgets/inputs/custom_text_field.dart';
import 'package:neurocare_app/shared/widgets/inputs/password_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isLoading = false;
  bool _agreeToTerms = false;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
                    'إنشاء حساب جديد',
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
                    'أدخل بياناتك لإنشاء حساب جديد والحصول على خدماتنا الطبية',
                    style: TextStyle(
                      fontFamily: 'IBM Plex Sans Arabic',
                      fontSize: 16,
                      color: AppColors.homeSecondaryText,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.right,
                  ),

                  const SizedBox(height: 40),

                  // First Name & Last Name Row
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          controller: _firstNameController,
                          labelText: 'الاسم الأول',
                          hintText: 'أدخل اسمك الأول',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'الاسم الأول مطلوب';
                            }
                            if (value.length < 2) {
                              return 'الاسم يجب أن يكون حرفين على الأقل';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: CustomTextField(
                          controller: _lastNameController,
                          labelText: 'اسم العائلة',
                          hintText: 'أدخل اسم العائلة',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'اسم العائلة مطلوب';
                            }
                            if (value.length < 2) {
                              return 'اسم العائلة يجب أن يكون حرفين على الأقل';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

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

                  // Phone Field
                  CustomTextField(
                    controller: _phoneController,
                    labelText: 'رقم الهاتف',
                    hintText: 'أدخل رقم هاتفك',
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'رقم الهاتف مطلوب';
                      }
                      if (value.length < 10) {
                        return 'رقم الهاتف يجب أن يكون 10 أرقام على الأقل';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 24),

                  // Password Field
                  PasswordField(
                    controller: _passwordController,
                    labelText: 'كلمة المرور',
                    hintText: 'أدخل كلمة مرور قوية',
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
                    hintText: 'أعد إدخال كلمة المرور',
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

                  // Terms and Conditions Checkbox
                  Row(
                    children: [
                      Checkbox(
                        value: _agreeToTerms,
                        onChanged: (value) {
                          setState(() => _agreeToTerms = value ?? false);
                        },
                        activeColor: AppColors.primary,
                      ),
                      const Expanded(
                        child: Text.rich(
                          TextSpan(
                            text: 'أوافق على ',
                            style: TextStyle(
                              fontFamily: 'IBM Plex Sans Arabic',
                              fontSize: 14,
                              color: AppColors.homeSecondaryText,
                            ),
                            children: [
                              TextSpan(
                                text: 'الشروط والأحكام',
                                style: TextStyle(
                                  fontFamily: 'IBM Plex Sans Arabic',
                                  fontSize: 14,
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextSpan(text: ' و'),
                              TextSpan(
                                text: ' سياسة الخصوصية',
                                style: TextStyle(
                                  fontFamily: 'IBM Plex Sans Arabic',
                                  fontSize: 14,
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // Sign Up Button
                  PrimaryButton(
                    text: 'إنشاء حساب',
                    onPressed: _agreeToTerms ? _handleSignUp : null,
                    isLoading: _isLoading,
                  ),

                  const SizedBox(height: 24),

                  // Already have account
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'لديك حساب بالفعل؟',
                          style: TextStyle(
                            fontFamily: 'IBM Plex Sans Arabic',
                            fontSize: 14,
                            color: AppColors.homeSecondaryText,
                          ),
                        ),
                        const SizedBox(width: 4),
                        TextButton(
                          onPressed: () => context.go(RouteNames.login),
                          child: const Text(
                            'تسجيل الدخول',
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

  void _handleSignUp() {
    if (_formKey.currentState?.validate() ?? false) {
      // TODO: Implement sign up logic
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('سيتم تنفيذ إنشاء الحساب قريباً')),
      );
    }
  }
}
