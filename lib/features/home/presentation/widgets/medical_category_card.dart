import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:neurocare_app/core/constants/app_colors.dart';
import 'package:neurocare_app/core/constants/app_text_styles.dart';

class MedicalCategoryCard extends StatelessWidget {
  final String icon;
  final String label;
  final bool isSelected;
  final VoidCallback? onTap;

  const MedicalCategoryCard({
    super.key,
    required this.icon,
    required this.label,
    required this.isSelected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: '$label فئة',
      hint: isSelected ? 'فئة محددة حالياً' : 'اختر الفئة',
      selected: isSelected,
      button: true,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(30),
        child: Column(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primary
                    : AppColors.homeCardBackground,
                borderRadius: BorderRadius.circular(30),
                border: isSelected
                    ? null
                    : Border.all(
                        color: AppColors.homeDivider,
                        width: 1,
                      ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.25),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : AppColors.cardShadow,
              ),
              child: Center(
                child: SvgPicture.asset(
                  icon,
                  width: 28,
                  height: 28,
                  colorFilter: ColorFilter.mode(
                    isSelected ? Colors.white : AppColors.primary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: AppTextStyles.homeCategoryLabel.copyWith(
                color:
                    isSelected ? AppColors.primary : AppColors.homeTertiaryText,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
