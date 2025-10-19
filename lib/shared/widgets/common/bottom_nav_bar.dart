import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:neurocare_app/core/constants/app_assets.dart';
import 'package:neurocare_app/core/constants/app_colors.dart';
import 'package:neurocare_app/core/routes/route_names.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
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
        padding: EdgeInsets.symmetric(
          horizontal:
              MediaQuery.of(context).size.width * 0.12, // 12% of screen width
          vertical: 20,
        ).clamp(
          const EdgeInsets.symmetric(
              horizontal: 20, vertical: 20), // Minimum horizontal padding
          const EdgeInsets.symmetric(
              horizontal: 60, vertical: 20), // Maximum horizontal padding
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildNavItem(
              context: context,
              index: 0,
              icon: AppAssets.homeNavIcon,
              route: RouteNames.home,
            ),
            _buildNavItem(
              context: context,
              index: 1,
              icon: AppAssets.calendarNavIcon,
              route: RouteNames.appointments,
            ),
            _buildCenterNavItem(
              context: context,
              index: 2,
              icon: AppAssets.doctorNavIcon,
              route: RouteNames.doctors,
            ),
            _buildNavItem(
              context: context,
              index: 3,
              icon: AppAssets.notificationNavIcon,
              route: RouteNames.notifications,
            ),
            _buildNavItem(
              context: context,
              index: 4,
              icon: AppAssets.profileNavIcon,
              route: RouteNames.profile,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required BuildContext context,
    required int index,
    required String icon,
    required String route,
  }) {
    final isSelected = currentIndex == index;
    return GestureDetector(
      onTap: () => context.go(route),
      child: SvgPicture.asset(
        icon,
        width: index == 0
            ? 19.172
            : index == 1
                ? 18.549
                : index == 3
                    ? 17
                    : 13.689,
        height: 20,
        colorFilter: ColorFilter.mode(
          isSelected ? AppColors.primary : AppColors.homeSecondaryText,
          BlendMode.srcIn,
        ),
      ),
    );
  }

  Widget _buildCenterNavItem({
    required BuildContext context,
    required int index,
    required String icon,
    required String route,
  }) {
    final isSelected = currentIndex == index;
    return GestureDetector(
      onTap: () => context.go(route),
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(25),
          boxShadow: isSelected
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
            icon,
            width: 15,
            height: 15,
            colorFilter: ColorFilter.mode(
              isSelected ? Colors.white : AppColors.homeSecondaryText,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}
