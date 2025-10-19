import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:neurocare_app/core/constants/app_colors.dart';
import 'package:neurocare_app/core/constants/app_text_styles.dart';
import 'package:neurocare_app/core/constants/app_assets.dart';
import 'package:neurocare_app/core/constants/app_dimensions.dart';

import 'package:neurocare_app/core/routes/route_names.dart';
import '../../../../shared/widgets/common/empty_state.dart';

class HealthRecordsScreen extends StatelessWidget {
  const HealthRecordsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.homeBackground,
      appBar: AppBar(
        backgroundColor: AppColors.homeCardBackground,
        elevation: 0,
        title: Text(
          'السجلات الطبية',
          style: AppTextStyles.headlineMedium.copyWith(
            color: AppColors.homePrimaryText,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          Semantics(
            label: 'إضافة سجل طبي جديد',
            hint: 'فتح شاشة إضافة سجل طبي',
            button: true,
            child: IconButton(
              icon: const Icon(
                Icons.add,
                color: AppColors.homePrimaryText,
                size: AppDimensions.iconMd,
              ),
              onPressed: () {
                context.go(RouteNames.uploadRecord);
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: AppDimensions.spacing2xl,
          vertical: AppDimensions.spacingLg,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Search bar
            Semantics(
              label: 'حقل البحث في السجلات الطبية',
              hint: 'ابحث عن سجلاتك الطبية هنا',
              textField: true,
              child: TextField(
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  hintText: 'ابحث في سجلاتك الطبية...',
                  hintStyle: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.homeTertiaryText,
                  ),
                  suffixIcon: Padding(
                    padding: const EdgeInsetsDirectional.only(
                      end: AppDimensions.spacingMd,
                    ),
                    child: SvgPicture.asset(
                      AppAssets.searchIcon,
                      width: AppDimensions.iconMd,
                      height: AppDimensions.iconMd,
                      colorFilter: const ColorFilter.mode(
                        AppColors.homeTertiaryText,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  filled: true,
                  fillColor: AppColors.homeCardBackground,
                  contentPadding: const EdgeInsetsDirectional.symmetric(
                    horizontal: AppDimensions.spacingMd,
                    vertical: AppDimensions.spacingMd,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
                    borderSide: const BorderSide(
                      color: AppColors.homeDivider,
                      width: 1.0,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
                    borderSide: const BorderSide(
                      color: AppColors.homeDivider,
                      width: 1.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
                    borderSide: const BorderSide(
                      color: AppColors.homeAccentBlue,
                      width: 2.0,
                    ),
                  ),
                ),
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.homePrimaryText,
                ),
                onChanged: (query) {
                  // TODO: Implement search functionality
                },
              ),
            ),
            const SizedBox(height: AppDimensions.spacing2xl),

            // Filter chips
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                textDirection: TextDirection.rtl,
                children: [
                  _buildFilterChip('الكل', true),
                  const SizedBox(width: AppDimensions.spacingMd),
                  _buildFilterChip('الوصفات الطبية', false),
                  const SizedBox(width: AppDimensions.spacingMd),
                  _buildFilterChip('نتائج المختبر', false),
                  const SizedBox(width: AppDimensions.spacingMd),
                  _buildFilterChip('الأشعة', false),
                ],
              ),
            ),
            const SizedBox(height: AppDimensions.spacing2xl),

            // Health records list placeholder
            Expanded(
              child: NoHealthRecordsState(
                onUploadRecord: () {
                  context.go(RouteNames.uploadRecord);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return Semantics(
      label: '$label فلتر',
      selected: isSelected,
      button: true,
      child: FilterChip(
        label: Text(
          label,
          style: AppTextStyles.labelMedium.copyWith(
            color: isSelected ? Colors.white : AppColors.homePrimaryText,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
        selected: isSelected,
        onSelected: (selected) {
          // TODO: Implement filter functionality
        },
        backgroundColor: AppColors.homeCardBackground,
        selectedColor: AppColors.homeAccentBlue,
        checkmarkColor: Colors.white,
        side: BorderSide(
          color: isSelected ? Colors.transparent : AppColors.homeDivider,
          width: 1.0,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.spacingMd,
          vertical: AppDimensions.spacingSm,
        ),
      ),
    );
  }
}
