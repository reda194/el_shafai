import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:neurocare_app/core/constants/app_colors.dart';
import 'package:neurocare_app/core/constants/app_strings.dart';
import 'package:neurocare_app/core/constants/app_assets.dart';
import 'package:neurocare_app/core/constants/app_text_styles.dart';
import 'package:neurocare_app/core/constants/app_dimensions.dart';

class DoctorCard extends StatelessWidget {
  final String name;
  final String specialty;
  final double rating;
  final int reviews;
  final int experience;
  final double price;
  final bool isAvailable;
  final String image;
  final VoidCallback? onTap;

  const DoctorCard({
    super.key,
    required this.name,
    required this.specialty,
    required this.rating,
    required this.reviews,
    required this.experience,
    required this.price,
    required this.isAvailable,
    required this.image,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'دكتور $name، أخصائي $specialty',
      hint: 'التقييم $rating، $reviews تقييم، الخبرة $experience سنة',
      button: true,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDimensions.radius2xl),
        child: Container(
          width: 320,
          height: 200,
          decoration: BoxDecoration(
            color: AppColors.figmaCardBackground,
            borderRadius: BorderRadius.circular(AppDimensions.radius2xl),
            boxShadow: AppColors.cardShadow,
            border: Border.all(
              color: AppColors.figmaDivider,
              width: 1,
            ),
          ),
          child: Row(
            textDirection: TextDirection.rtl,
            children: [
              // Doctor Image Section
              Expanded(
                flex: 1,
                child: Padding(
                  padding:
                      const EdgeInsetsDirectional.all(AppDimensions.spacingLg),
                  child: Container(
                    width: 120,
                    height: 160,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(AppDimensions.radiusLg),
                      image: DecorationImage(
                        image: AssetImage(image),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Stack(
                      children: [
                        // Status Indicator
                        PositionedDirectional(
                          top: AppDimensions.spacingSm,
                          start: AppDimensions.spacingSm,
                          child: Container(
                            width: AppDimensions.statusDotSize * 2,
                            height: AppDimensions.iconXs,
                            decoration: BoxDecoration(
                              color: isAvailable
                                  ? AppColors.doctorIndicatorAvailable
                                  : AppColors.doctorIndicatorOffline,
                              borderRadius:
                                  BorderRadius.circular(AppDimensions.radiusXl),
                            ),
                            child: Center(
                              child: Text(
                                isAvailable ? 'متاح' : 'مشغول',
                                style: AppTextStyles.labelSmall.copyWith(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Doctor Information Section
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                    0,
                    AppDimensions.spacingLg,
                    AppDimensions.spacingLg,
                    AppDimensions.spacingLg,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Doctor Name
                      Text(
                        name,
                        style: AppTextStyles.homeDoctorName,
                        textAlign: TextAlign.right,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),

                      const SizedBox(height: AppDimensions.spacingXs),

                      // Specialty
                      Text(
                        specialty,
                        style: AppTextStyles.homeDoctorSpecialty,
                        textAlign: TextAlign.right,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),

                      const SizedBox(height: AppDimensions.spacingMd),

                      // Rating
                      Row(
                        textDirection: TextDirection.rtl,
                        children: [
                          // Stars
                          Row(
                            textDirection: TextDirection.ltr,
                            children: List.generate(
                              5,
                              (index) => Icon(
                                index < rating.floor()
                                    ? Icons.star
                                    : index < rating
                                        ? Icons.star_half
                                        : Icons.star_border,
                                size: 16,
                                color: AppColors.ratingStar,
                              ),
                            ),
                          ),
                          const SizedBox(width: AppDimensions.spacingXs),
                          Text(
                            rating.toStringAsFixed(1),
                            style: AppTextStyles.homeDoctorRating,
                          ),
                          const SizedBox(width: AppDimensions.spacingXs),
                          Text(
                            '($reviews)',
                            style: AppTextStyles.homeDoctorSpecialty,
                          ),
                        ],
                      ),

                      const SizedBox(height: AppDimensions.spacingMd),

                      // Experience
                      Row(
                        textDirection: TextDirection.rtl,
                        children: [
                          SvgPicture.asset(
                            AppAssets.starIcon,
                            width: 16,
                            height: 16,
                            colorFilter: const ColorFilter.mode(
                              AppColors.homeSecondaryText,
                              BlendMode.srcIn,
                            ),
                          ),
                          const SizedBox(width: AppDimensions.spacingXs),
                          Text(
                            '$experience سنة خبرة',
                            style: AppTextStyles.homeDoctorSpecialty,
                          ),
                        ],
                      ),

                      const SizedBox(height: AppDimensions.spacingMd),

                      // Price Section
                      Row(
                        textDirection: TextDirection.rtl,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${price.toStringAsFixed(0)} ${AppStrings.sar}',
                            style: AppTextStyles.homePrice,
                          ),
                          const Text(
                            AppStrings.perSession,
                            style: AppTextStyles.homeDoctorSpecialty,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
