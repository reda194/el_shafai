import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:neurocare_app/core/constants/app_assets.dart';
import 'package:neurocare_app/core/constants/app_colors.dart';

class CustomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 104,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            offset: const Offset(0, -10),
            blurRadius: 30,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 52, vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Home
            GestureDetector(
              onTap: () => onTap(0),
              child: SvgPicture.asset(
                AppAssets.homeNavIcon,
                width: 19.172,
                height: 20,
                colorFilter: ColorFilter.mode(
                  currentIndex == 0
                      ? AppColors.primary
                      : AppColors.homeSecondaryText,
                  BlendMode.srcIn,
                ),
              ),
            ),

            // Calendar
            GestureDetector(
              onTap: () => onTap(1),
              child: SvgPicture.asset(
                AppAssets.calendarNavIcon,
                width: 18.549,
                height: 20,
                colorFilter: ColorFilter.mode(
                  currentIndex == 1
                      ? AppColors.primary
                      : AppColors.homeSecondaryText,
                  BlendMode.srcIn,
                ),
              ),
            ),

            // Doctor (Active)
            GestureDetector(
              onTap: () => onTap(2),
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: currentIndex == 2
                      ? AppColors.primary
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: currentIndex == 2
                      ? [
                          BoxShadow(
                            color: AppColors.primary.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 20,
                            offset: const Offset(0, 7),
                          ),
                        ]
                      : null,
                ),
                child: Center(
                  child: SvgPicture.asset(
                    AppAssets.doctorNavIcon,
                    width: 15,
                    height: 15,
                    colorFilter: ColorFilter.mode(
                      currentIndex == 2
                          ? Colors.white
                          : AppColors.homeSecondaryText,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ),

            // Notification
            GestureDetector(
              onTap: () => onTap(3),
              child: SvgPicture.asset(
                AppAssets.notificationNavIcon,
                width: 17,
                height: 20,
                colorFilter: ColorFilter.mode(
                  currentIndex == 3
                      ? AppColors.primary
                      : AppColors.homeSecondaryText,
                  BlendMode.srcIn,
                ),
              ),
            ),

            // Profile
            GestureDetector(
              onTap: () => onTap(4),
              child: SvgPicture.asset(
                AppAssets.profileNavIcon,
                width: 13.689,
                height: 19.074,
                colorFilter: ColorFilter.mode(
                  currentIndex == 4
                      ? AppColors.primary
                      : AppColors.homeSecondaryText,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
