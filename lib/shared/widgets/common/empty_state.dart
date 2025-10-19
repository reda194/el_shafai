import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:neurocare_app/core/constants/app_assets.dart';
import 'package:neurocare_app/core/constants/app_colors.dart';
import 'package:neurocare_app/shared/widgets/buttons/primary_button.dart';

class EmptyState extends StatelessWidget {
  final String title;
  final String message;
  final String? buttonText;
  final VoidCallback? onButtonPressed;
  final String? iconPath;
  final IconData? icon;
  final Color? iconColor;
  final double iconSize;

  const EmptyState({
    super.key,
    required this.title,
    required this.message,
    this.buttonText,
    this.onButtonPressed,
    this.iconPath,
    this.icon,
    this.iconColor,
    this.iconSize = 80,
  }) : assert(iconPath != null || icon != null,
            'Either iconPath or icon must be provided');

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon
            Container(
              width: iconSize,
              height: iconSize,
              decoration: BoxDecoration(
                color: (iconColor ?? AppColors.primary).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: iconPath != null
                    ? SvgPicture.asset(
                        iconPath!,
                        width: iconSize * 0.5,
                        height: iconSize * 0.5,
                        colorFilter: ColorFilter.mode(
                          iconColor ?? AppColors.primary,
                          BlendMode.srcIn,
                        ),
                      )
                    : Icon(
                        icon!,
                        size: iconSize * 0.5,
                        color: iconColor ?? AppColors.primary,
                      ),
              ),
            ),

            const SizedBox(height: 24),

            // Title
            Text(
              title,
              style: const TextStyle(
                fontFamily: 'IBM Plex Sans Arabic',
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 12),

            // Message
            Text(
              message,
              style: const TextStyle(
                fontFamily: 'IBM Plex Sans Arabic',
                fontSize: 16,
                color: AppColors.homeSecondaryText,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 32),

            // Action Button
            if (onButtonPressed != null && buttonText != null)
              PrimaryButton(
                text: buttonText!,
                onPressed: onButtonPressed,
                width: 200,
              ),
          ],
        ),
      ),
    );
  }
}

class NoAppointmentsState extends StatelessWidget {
  final VoidCallback? onBookAppointment;

  const NoAppointmentsState({
    super.key,
    this.onBookAppointment,
  });

  @override
  Widget build(BuildContext context) {
    return EmptyState(
      title: 'لا توجد مواعيد',
      message:
          'ليس لديك أي مواعيد محجوزة حالياً. احجز موعدك الأول مع طبيبك المفضل.',
      buttonText: 'حجز موعد',
      onButtonPressed: onBookAppointment,
      icon: Icons.calendar_today,
      iconColor: AppColors.primary,
    );
  }
}

class NoDoctorsState extends StatelessWidget {
  final VoidCallback? onSearchDoctors;

  const NoDoctorsState({
    super.key,
    this.onSearchDoctors,
  });

  @override
  Widget build(BuildContext context) {
    return EmptyState(
      title: 'لا يوجد أطباء',
      message:
          'لم نتمكن من العثور على أطباء في منطقتك. جرب البحث في منطقة أخرى.',
      buttonText: 'البحث عن أطباء',
      onButtonPressed: onSearchDoctors,
      icon: Icons.search,
      iconColor: AppColors.primary,
    );
  }
}

class NoMessagesState extends StatelessWidget {
  final VoidCallback? onStartChat;

  const NoMessagesState({
    super.key,
    this.onStartChat,
  });

  @override
  Widget build(BuildContext context) {
    return EmptyState(
      title: 'لا توجد رسائل',
      message: 'ابدأ محادثة مع طبيبك للحصول على استشارة طبية.',
      buttonText: 'بدء محادثة',
      onButtonPressed: onStartChat,
      iconPath: AppAssets.chatIcon,
      iconColor: AppColors.primary,
    );
  }
}

class NoHealthRecordsState extends StatelessWidget {
  final VoidCallback? onUploadRecord;

  const NoHealthRecordsState({
    super.key,
    this.onUploadRecord,
  });

  @override
  Widget build(BuildContext context) {
    return EmptyState(
      title: 'لا توجد سجلات صحية',
      message:
          'لم تقم بإضافة أي سجلات صحية بعد. أضف سجلاتك الصحية للوصول إليها بسهولة.',
      buttonText: 'إضافة سجل صحي',
      onButtonPressed: onUploadRecord,
      icon: Icons.medical_services,
      iconColor: AppColors.primary,
    );
  }
}
