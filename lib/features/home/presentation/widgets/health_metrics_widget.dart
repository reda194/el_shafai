import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:neurocare_app/core/constants/app_colors.dart';
import 'package:neurocare_app/core/constants/app_dimensions.dart';
import 'package:neurocare_app/core/constants/app_text_styles.dart';
import 'package:neurocare_app/core/constants/app_assets.dart';

class HealthMetricsWidget extends StatelessWidget {
  const HealthMetricsWidget({super.key});

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
        color: AppColors.homeCardBackground,
        borderRadius: BorderRadius.circular(AppDimensions.radius2xl),
        boxShadow: AppColors.cardShadow,
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
                Text(
                  'ملخص الصحة',
                  style: isTablet
                      ? AppTextStyles.headlineSmall
                          .copyWith(fontWeight: FontWeight.w600)
                      : AppTextStyles.titleLarge
                          .copyWith(fontWeight: FontWeight.w600),
                ),
                Semantics(
                  label: 'عرض جميع المقاييس الصحية',
                  hint: 'فتح صفحة المقاييس الصحية المفصلة',
                  button: true,
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.homeTertiaryText,
                      size: AppDimensions.iconSm,
                    ),
                    onPressed: () {
                      // TODO: Navigate to detailed health metrics
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: AppDimensions.spacingLg),

            // Health Metrics Grid
            _buildHealthMetricsGrid(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHealthMetricsGrid(BuildContext context) {
    final metrics = [
      {
        'title': 'معدل ضربات القلب',
        'value': '72',
        'unit': 'نبضة/دقيقة',
        'icon': AppAssets.heartIcon,
        'color': AppColors.medicalPink,
        'status': 'طبيعي',
      },
      {
        'title': 'ضغط الدم',
        'value': '120/80',
        'unit': 'مم زئبق',
        'icon': AppAssets.stomachIcon,
        'color': AppColors.quickActionGreen,
        'status': 'طبيعي',
      },
      {
        'title': 'مستوى السكر',
        'value': '95',
        'unit': 'مجم/دل',
        'icon': AppAssets.toothIcon,
        'color': AppColors.medicalAccent,
        'status': 'طبيعي',
      },
      {
        'title': 'الخطوات اليوم',
        'value': '8,432',
        'unit': 'خطوة',
        'icon': AppAssets.lungsIcon,
        'color': AppColors.quickActionTeal,
        'status': 'جيد',
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: AppDimensions.spacingMd,
        mainAxisSpacing: AppDimensions.spacingMd,
        childAspectRatio: 1.2,
      ),
      itemCount: metrics.length,
      itemBuilder: (context, index) {
        final metric = metrics[index];
        return _HealthMetricCard(
          title: metric['title'] as String,
          value: metric['value'] as String,
          unit: metric['unit'] as String,
          icon: metric['icon'] as String,
          color: metric['color'] as Color,
          status: metric['status'] as String,
        );
      },
    );
  }
}

class _HealthMetricCard extends StatelessWidget {
  final String title;
  final String value;
  final String unit;
  final String icon;
  final Color color;
  final String status;

  const _HealthMetricCard({
    required this.title,
    required this.value,
    required this.unit,
    required this.icon,
    required this.color,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: '$title: $value $unit',
      hint: 'الحالة: $status',
      button: true,
      child: InkWell(
        onTap: () {
          // TODO: Navigate to detailed metric view
        },
        borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
        child: Container(
          padding: const EdgeInsets.all(AppDimensions.spacingMd),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
            border: Border.all(
              color: color.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Icon
              Align(
                alignment: AlignmentDirectional.topEnd,
                child: SvgPicture.asset(
                  icon,
                  width: AppDimensions.iconMd,
                  height: AppDimensions.iconMd,
                  colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
                ),
              ),

              const SizedBox(height: AppDimensions.spacingSm),

              // Title
              Text(
                title,
                style: AppTextStyles.labelMedium.copyWith(
                  color: AppColors.homeSecondaryText,
                ),
                textAlign: TextAlign.right,
              ),

              const SizedBox(height: AppDimensions.spacingXs),

              // Value
              Text(
                value,
                style: AppTextStyles.headlineSmall.copyWith(
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.right,
              ),

              // Unit
              Text(
                unit,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.homeTertiaryText,
                ),
                textAlign: TextAlign.right,
              ),

              // Status
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      color: AppColors.quickActionGreen,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: AppDimensions.spacing2xs),
                  Text(
                    status,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.quickActionGreen,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
