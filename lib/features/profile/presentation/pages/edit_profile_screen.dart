import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:neurocare_app/core/constants/app_assets.dart';
import 'package:neurocare_app/core/constants/app_colors.dart';
import 'package:neurocare_app/features/profile/domain/entities/user_profile.dart';
import 'package:neurocare_app/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:neurocare_app/shared/widgets/buttons/primary_button.dart';
import 'package:neurocare_app/shared/widgets/inputs/custom_text_field.dart';

class EditProfileScreen extends StatefulWidget {
  final UserProfile profile;

  const EditProfileScreen({
    super.key,
    required this.profile,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;
  late TextEditingController _dateOfBirthController;
  late TextEditingController _emergencyContactController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.profile.fullName);
    _emailController = TextEditingController(text: widget.profile.email);
    _phoneController =
        TextEditingController(text: widget.profile.phoneNumber ?? '');
    _addressController =
        TextEditingController(text: widget.profile.address ?? '');
    _dateOfBirthController =
        TextEditingController(text: widget.profile.dateOfBirth ?? '');
    _emergencyContactController =
        TextEditingController(text: widget.profile.emergencyContactName ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _dateOfBirthController.dispose();
    _emergencyContactController.dispose();
    super.dispose();
  }

  void _saveProfile() {
    if (_formKey.currentState?.validate() ?? false) {
      final updatedProfile = UserProfile(
        id: widget.profile.id,
        fullName: _nameController.text,
        email: _emailController.text,
        phoneNumber:
            _phoneController.text.isEmpty ? null : _phoneController.text,
        address:
            _addressController.text.isEmpty ? null : _addressController.text,
        dateOfBirth: _dateOfBirthController.text.isEmpty
            ? null
            : _dateOfBirthController.text,
        emergencyContactName: _emergencyContactController.text.isEmpty
            ? null
            : _emergencyContactController.text,
        profileImageUrl: widget.profile.profileImageUrl,
        createdAt: widget.profile.createdAt,
        updatedAt: DateTime.now(),
      );

      context.read<ProfileBloc>().add(UpdateUserProfile(updatedProfile));
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now()
          .subtract(const Duration(days: 365 * 25)), // 25 years ago
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primary,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _dateOfBirthController.text =
            '${picked.day}/${picked.month}/${picked.year}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.onboardingBackground,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'تعديل الملف الشخصي',
          style: TextStyle(
            fontFamily: 'IBM Plex Sans Arabic',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: SvgPicture.asset(
            AppAssets.arrowIcon,
            width: 24,
            height: 24,
            colorFilter: const ColorFilter.mode(
              AppColors.primary,
              BlendMode.srcIn,
            ),
          ),
          onPressed: () => context.pop(),
        ),
        actions: [
          BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state is ProfileUpdating) {
                return const Padding(
                  padding: EdgeInsets.all(16),
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.primary,
                    ),
                  ),
                );
              }
              return TextButton(
                onPressed: _saveProfile,
                child: const Text(
                  'حفظ',
                  style: TextStyle(
                    fontFamily: 'IBM Plex Sans Arabic',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileUpdated) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('تم تحديث الملف الشخصي بنجاح')),
            );
            context.pop();
          } else if (state is ProfileError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Profile Image Section
                Center(
                  child: Stack(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primary.withOpacity(0.1),
                          image: widget.profile.profileImageUrl != null
                              ? DecorationImage(
                                  image: NetworkImage(
                                      widget.profile.profileImageUrl!),
                                  fit: BoxFit.cover,
                                )
                              : null,
                        ),
                        child: widget.profile.profileImageUrl == null
                            ? const Icon(
                                Icons.person,
                                size: 50,
                                color: AppColors.primary,
                              )
                            : null,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // Full Name
                const Text(
                  'الاسم الكامل',
                  style: TextStyle(
                    fontFamily: 'IBM Plex Sans Arabic',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                  textAlign: TextAlign.right,
                ),
                const SizedBox(height: 8),
                CustomTextField(
                  controller: _nameController,
                  hintText: 'أدخل اسمك الكامل',
                  textDirection: TextDirection.rtl,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'الرجاء إدخال الاسم الكامل';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                // Email
                const Text(
                  'البريد الإلكتروني',
                  style: TextStyle(
                    fontFamily: 'IBM Plex Sans Arabic',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                  textAlign: TextAlign.right,
                ),
                const SizedBox(height: 8),
                CustomTextField(
                  controller: _emailController,
                  hintText: 'أدخل بريدك الإلكتروني',
                  keyboardType: TextInputType.emailAddress,
                  textDirection: TextDirection.ltr,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'الرجاء إدخال البريد الإلكتروني';
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value!)) {
                      return 'الرجاء إدخال بريد إلكتروني صحيح';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                // Phone Number
                const Text(
                  'رقم الهاتف',
                  style: TextStyle(
                    fontFamily: 'IBM Plex Sans Arabic',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                  textAlign: TextAlign.right,
                ),
                const SizedBox(height: 8),
                CustomTextField(
                  controller: _phoneController,
                  hintText: 'أدخل رقم هاتفك',
                  keyboardType: TextInputType.phone,
                  textDirection: TextDirection.ltr,
                  validator: (value) {
                    if (value?.isNotEmpty ?? false) {
                      if (!RegExp(r'^\+?[0-9]{10,15}$').hasMatch(value!)) {
                        return 'الرجاء إدخال رقم هاتف صحيح';
                      }
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                // Date of Birth
                const Text(
                  'تاريخ الميلاد',
                  style: TextStyle(
                    fontFamily: 'IBM Plex Sans Arabic',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                  textAlign: TextAlign.right,
                ),
                const SizedBox(height: 8),
                CustomTextField(
                  controller: _dateOfBirthController,
                  hintText: 'اختر تاريخ ميلادك',
                  readOnly: true,
                  textDirection: TextDirection.ltr,
                  suffixIcon: IconButton(
                    icon: const Icon(
                      Icons.calendar_today,
                      color: AppColors.primary,
                    ),
                    onPressed: () => _selectDate(context),
                  ),
                ),

                const SizedBox(height: 20),

                // Address
                const Text(
                  'العنوان',
                  style: TextStyle(
                    fontFamily: 'IBM Plex Sans Arabic',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                  textAlign: TextAlign.right,
                ),
                const SizedBox(height: 8),
                CustomTextField(
                  controller: _addressController,
                  hintText: 'أدخل عنوانك',
                  maxLines: 3,
                  textDirection: TextDirection.rtl,
                ),

                const SizedBox(height: 20),

                // Emergency Contact
                const Text(
                  'جهة اتصال طوارئ',
                  style: TextStyle(
                    fontFamily: 'IBM Plex Sans Arabic',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                  textAlign: TextAlign.right,
                ),
                const SizedBox(height: 8),
                CustomTextField(
                  controller: _emergencyContactController,
                  hintText: 'أدخل اسم ورقم جهة الاتصال',
                  textDirection: TextDirection.rtl,
                ),

                const SizedBox(height: 40),

                // Save Button
                PrimaryButton(
                  text: 'حفظ التغييرات',
                  onPressed: _saveProfile,
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
