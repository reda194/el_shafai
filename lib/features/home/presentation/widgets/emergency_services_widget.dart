import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:neurocare_app/core/constants/app_colors.dart';
import 'package:neurocare_app/core/constants/app_dimensions.dart';
import 'package:neurocare_app/core/constants/app_text_styles.dart';

class EmergencyServicesWidget extends StatelessWidget {
  const EmergencyServicesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isTablet =
        MediaQuery.of(context).size.width >= AppDimensions.tabletBreakpoint;

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal:
            isTablet ? AppDimensions.spacing2xl : AppDimensions.spacingLg,
      ),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            AppColors.medicalPink,
            AppColors.medicalAccent,
          ],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
        borderRadius: BorderRadius.circular(AppDimensions.radius2xl),
        boxShadow: AppColors.heavyShadow,
      ),
      child: Padding(
        padding: EdgeInsets.all(
            isTablet ? AppDimensions.spacing2xl : AppDimensions.spacingLg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(
                  Icons.emergency,
                  color: Colors.white,
                  size: 32,
                ),
                Expanded(
                  child: Text(
                    'خدمات الطوارئ',
                    style: AppTextStyles.headlineSmall.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),

            const SizedBox(height: AppDimensions.spacingLg),

            // Emergency Options
            _buildEmergencyOptions(context),
          ],
        ),
      ),
    );
  }

  Widget _buildEmergencyOptions(BuildContext context) {
    final options = [
      {
        'title': 'إسعاف',
        'subtitle': '997',
        'icon': Icons.local_hospital,
        'color': Colors.white,
        'phone': 'tel:997',
      },
      {
        'title': 'شرطة',
        'subtitle': '999',
        'icon': Icons.local_police,
        'color': Colors.white,
        'phone': 'tel:999',
      },
      {
        'title': 'إطفاء',
        'subtitle': '998',
        'icon': Icons.local_fire_department,
        'color': Colors.white,
        'phone': 'tel:998',
      },
      {
        'title': 'طبيب طوارئ',
        'subtitle': 'اتصل الآن',
        'icon': Icons.medical_services,
        'color': Colors.white,
        'phone': 'tel:+966500000000',
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: AppDimensions.spacingMd,
        mainAxisSpacing: AppDimensions.spacingMd,
        childAspectRatio: 1.1,
      ),
      itemCount: options.length,
      itemBuilder: (context, index) {
        final option = options[index];
        return _EmergencyOptionCard(
          title: option['title'] as String,
          subtitle: option['subtitle'] as String,
          icon: option['icon'] as IconData,
          color: option['color'] as Color,
          phone: option['phone'] as String,
        );
      },
    );
  }
}

class _EmergencyOptionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final String phone;

  const _EmergencyOptionCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.phone,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: '$title - $subtitle',
      hint: 'اضغط للاتصال',
      button: true,
      child: InkWell(
        onTap: () => _makePhoneCall(phone),
        borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
            border: Border.all(
              color: Colors.white.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppDimensions.spacingMd),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icon
                Icon(
                  icon,
                  color: color,
                  size: AppDimensions.iconXl,
                ),

                const SizedBox(height: AppDimensions.spacingSm),

                // Title
                Text(
                  title,
                  style: AppTextStyles.titleMedium.copyWith(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: AppDimensions.spacing2xs),

                // Subtitle
                Text(
                  subtitle,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: color.withOpacity(0.8),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri.parse(phoneNumber);
    if (!await launchUrl(launchUri)) {
      throw Exception('Could not launch $phoneNumber');
    }
  }
}
