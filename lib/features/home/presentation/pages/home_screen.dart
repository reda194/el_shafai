import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:neurocare_app/core/constants/app_colors.dart';
import 'package:neurocare_app/core/constants/app_strings.dart';
import 'package:neurocare_app/core/constants/app_assets.dart';
import 'package:neurocare_app/core/constants/app_text_styles.dart';
import 'package:neurocare_app/core/constants/app_dimensions.dart';
import 'package:neurocare_app/core/routes/route_names.dart';
import 'package:neurocare_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:neurocare_app/features/home/presentation/widgets/medical_category_card.dart';
import 'package:neurocare_app/features/home/presentation/widgets/doctor_card.dart';
import 'package:neurocare_app/features/home/presentation/widgets/health_metrics_widget.dart';
import 'package:neurocare_app/features/home/presentation/widgets/quick_appointments_widget.dart';
import 'package:neurocare_app/features/home/presentation/widgets/emergency_services_widget.dart';
import 'package:neurocare_app/shared/widgets/common/bottom_nav_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Helper method to determine if device is tablet (iOS breakpoint)
  static bool _isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= AppDimensions.tabletBreakpoint;
  }

  // Helper method to get responsive padding (iOS margins)
  static double _getResponsivePadding(BuildContext context) {
    return _isTablet(context)
        ? AppDimensions.spacing3xl // 40pt for tablet
        : AppDimensions.spacing2xl; // 32pt for mobile
  }

  // Helper method to get responsive spacing for sections
  static double _getSectionSpacing(BuildContext context) {
    return _isTablet(context)
        ? AppDimensions.spacing2xl // 32pt for tablet
        : AppDimensions.spacingXl; // 24pt for mobile
  }

  // Enhanced static data with Figma design integration
  static const _featuredDoctors = [
    {
      'name': 'د. أحمد محمد السعيد',
      'specialty': 'أخصائي أعصاب',
      'rating': 4.9,
      'reviews': 125,
      'experience': 10,
      'price': 150.0,
      'available': true,
      'image': AppAssets.doctorImage,
    },
    {
      'name': 'د. سارة أحمد العبد',
      'specialty': 'أخصائية قلب وأوعية دموية',
      'rating': 4.8,
      'reviews': 98,
      'experience': 8,
      'price': 140.0,
      'available': true,
      'image': AppAssets.doctorImage,
    },
    {
      'name': 'د. محمد علي خالد',
      'specialty': 'أخصائي باطنة وجهاز هضمي',
      'rating': 4.7,
      'reviews': 87,
      'experience': 12,
      'price': 160.0,
      'available': false,
      'image': AppAssets.doctorImage,
    },
    {
      'name': 'د. فاطمة حسن محمود',
      'specialty': 'أخصائية نساء وتوليد',
      'rating': 4.9,
      'reviews': 156,
      'experience': 15,
      'price': 180.0,
      'available': true,
      'image': AppAssets.doctorImage,
    },
    {
      'name': 'د. عمر خالد سالم',
      'specialty': 'أخصائي أطفال وحديثي الولادة',
      'rating': 4.8,
      'reviews': 112,
      'experience': 9,
      'price': 130.0,
      'available': true,
      'image': AppAssets.doctorImage,
    },
  ];

  static const _categories = [
    {'name': 'أعصاب', 'icon': AppAssets.brainIcon, 'count': 25},
    {'name': 'قلب', 'icon': AppAssets.heartIcon, 'count': 18},
    {'name': 'باطنة', 'icon': AppAssets.stomachIcon, 'count': 32},
    {'name': 'نساء وتوليد', 'icon': AppAssets.toothIcon, 'count': 15},
    {'name': 'أطفال', 'icon': AppAssets.lungsIcon, 'count': 28},
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: Scaffold(
        backgroundColor: AppColors.homeBackground,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Menu Bar (iOS style)
                _buildMenuBar(context),

                SizedBox(height: _getSectionSpacing(context)),

                // Learning Prompt
                _buildLearningPrompt(context),

                SizedBox(height: _getSectionSpacing(context)),

                // Search Bar (iOS style)
                _buildSearchBar(context),

                SizedBox(height: _getSectionSpacing(context)),

                // Medical Categories (iOS style)
                _buildMedicalCategories(context),

                SizedBox(height: _getSectionSpacing(context)),

                // Quick Actions (iOS style)
                _buildQuickActions(context),

                SizedBox(height: _getSectionSpacing(context)),

                // Featured Doctors Section (iOS style)
                _buildFeaturedDoctors(context),

                SizedBox(height: _getSectionSpacing(context)),

                // Doctor Categories Section (iOS style)
                _buildDoctorCategories(context),

                SizedBox(height: _getSectionSpacing(context)),

                // Nearby Doctors (iOS style)
                _buildNearbyDoctors(context),

                SizedBox(height: _getSectionSpacing(context)),

                // Health Tips (iOS style)
                _buildHealthTips(context),

                const SizedBox(height: AppDimensions.spacing2xl),

                // Health Metrics Widget
                const HealthMetricsWidget(),

                const SizedBox(height: AppDimensions.spacing2xl),

                // Quick Appointments Widget
                const QuickAppointmentsWidget(),

                const SizedBox(height: AppDimensions.spacing2xl),

                // Emergency Services Widget
                const EmergencyServicesWidget(),

                const SizedBox(
                    height: AppDimensions
                        .spacing4xl), // Space for bottom navigation
              ],
            ),
          ),
        ),
        bottomNavigationBar: const BottomNavBar(currentIndex: 0),
      ),
    );
  }

  Widget _buildMenuBar(BuildContext context) {
    final padding = _getResponsivePadding(context);
    return Padding(
      padding: EdgeInsetsDirectional.symmetric(
        horizontal: padding,
        vertical: AppDimensions.spacingSm, // 12pt vertical padding
      ),
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          // Notification Icon (iOS style)
          Semantics(
            label: 'الإشعارات',
            hint: 'لديك إشعارات جديدة',
            button: true,
            child: InkWell(
              onTap: () => context.push(RouteNames.notifications),
              borderRadius:
                  BorderRadius.circular(AppDimensions.touchTargetMinimum / 2),
              child: Container(
                width: AppDimensions
                    .touchTargetMinimum, // 44pt minimum touch target
                height: AppDimensions.touchTargetMinimum,
                decoration: BoxDecoration(
                  color: AppColors.homeCardBackground,
                  borderRadius: BorderRadius.circular(
                      AppDimensions.touchTargetMinimum / 2),
                  border: Border.all(
                    color: AppColors.homeDivider,
                    width: 1.0,
                  ),
                  boxShadow: AppColors.cardShadow,
                ),
                child: Stack(
                  children: [
                    Center(
                      child: SvgPicture.asset(
                        AppAssets.notificationIcon,
                        width: AppDimensions.iconMd,
                        height: AppDimensions.iconMd,
                        colorFilter: const ColorFilter.mode(
                          AppColors.homePrimaryText,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                    PositionedDirectional(
                      top: AppDimensions.statusDotOffset,
                      end: AppDimensions.statusDotOffset,
                      child: Container(
                        width: AppDimensions.notificationBadgeSize,
                        height: AppDimensions.notificationBadgeSize,
                        decoration: const BoxDecoration(
                          color: AppColors
                              .onlineStatus, // Using iOS green for notifications
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(width: AppDimensions.spacingMd),

          // Welcome Message (iOS style)
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  AppStrings.welcomeUser,
                  style: AppTextStyles.homeWelcomeTitle,
                  textAlign: TextAlign.right,
                ),
                SizedBox(height: AppDimensions.spacing2xs),
                Text(
                  AppStrings.checkStats,
                  style: AppTextStyles.homeWelcomeSubtitle,
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          ),

          const SizedBox(width: AppDimensions.spacingMd),

          // Menu Icon (iOS style)
          Semantics(
            label: 'القائمة',
            hint: 'فتح القائمة',
            button: true,
            child: InkWell(
              onTap: () => Scaffold.of(context).openEndDrawer(),
              borderRadius:
                  BorderRadius.circular(AppDimensions.touchTargetMinimum / 2),
              child: Container(
                width: AppDimensions
                    .touchTargetMinimum, // 44pt minimum touch target
                height: AppDimensions.touchTargetMinimum,
                decoration: BoxDecoration(
                  color: AppColors.homeCardBackground,
                  borderRadius: BorderRadius.circular(
                      AppDimensions.touchTargetMinimum / 2),
                  border: Border.all(
                    color: AppColors.homeDivider,
                    width: 1.0,
                  ),
                  boxShadow: AppColors.cardShadow,
                ),
                child: Center(
                  child: SvgPicture.asset(
                    AppAssets.menuIcon,
                    width: AppDimensions.iconMd,
                    height: AppDimensions.iconMd,
                    colorFilter: const ColorFilter.mode(
                      AppColors.homePrimaryText,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLearningPrompt(BuildContext context) {
    final padding = _getResponsivePadding(context);
    return Padding(
      padding: EdgeInsetsDirectional.symmetric(horizontal: padding),
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Responsive typography based on iOS design guidelines
          final fontSize = _isTablet(context) ? 32.0 : 28.0;
          return Text(
            AppStrings.learnSomethingNew,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: fontSize,
              color: AppColors.homePrimaryText,
              height: 1.2,
              letterSpacing: 0.37,
            ),
            textAlign: TextAlign.right,
          );
        },
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    final padding = _getResponsivePadding(context);
    return Padding(
      padding: EdgeInsetsDirectional.symmetric(horizontal: padding),
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          // Filter Button (iOS style)
          Semantics(
            label: 'تصفية البحث',
            hint: 'فتح خيارات التصفية',
            button: true,
            child: InkWell(
              onTap: () => context.push(RouteNames.filter),
              borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
              child: Container(
                width: AppDimensions.touchTargetMinimum, // 44pt touch target
                height: AppDimensions.touchTargetMinimum,
                decoration: BoxDecoration(
                  color: AppColors.homeAccentBlue, // iOS system blue
                  borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
                  boxShadow: AppColors.buttonShadow,
                ),
                child: Center(
                  child: SvgPicture.asset(
                    AppAssets.filterIcon,
                    width: AppDimensions.iconSm,
                    height: AppDimensions.iconSm,
                    colorFilter: const ColorFilter.mode(
                      Colors.white, // White icons on colored background
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(width: AppDimensions.spacingLg), // 20pt spacing

          // Search Field (iOS style)
          Expanded(
            child: Semantics(
              label: 'حقل البحث',
              hint: 'ابحث عن اسم طبيب أو تخصص',
              textField: true,
              child: InkWell(
                onTap: () => context.push(RouteNames.searchDoctors),
                borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
                child: Container(
                  height: AppDimensions.buttonMd, // 44pt iOS standard height
                  decoration: BoxDecoration(
                    color: AppColors.homeCardBackground,
                    borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
                    border: Border.all(
                      color: AppColors.homeDivider,
                      width: 1.0,
                    ),
                    boxShadow: AppColors.cardShadow,
                  ),
                  child: Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      const Expanded(
                        child: Padding(
                          padding: EdgeInsetsDirectional.only(
                            start: AppDimensions.spacingMd, // 16pt padding
                          ),
                          child: Text(
                            AppStrings.searchDoctor,
                            style: AppTextStyles.homeSearchHint,
                            textAlign: TextAlign.right,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(
                          end: AppDimensions.spacingMd, // 16pt padding
                        ),
                        child: SvgPicture.asset(
                          AppAssets.searchIcon,
                          width: AppDimensions.searchIconSize,
                          height: AppDimensions.searchIconSize,
                          colorFilter: const ColorFilter.mode(
                            AppColors.homeTertiaryText,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMedicalCategories(BuildContext context) {
    final padding = _getResponsivePadding(context) +
        AppDimensions.spacing2xs; // Add small extra padding
    return Padding(
      padding: EdgeInsetsDirectional.symmetric(
          horizontal: padding, vertical: AppDimensions.spacingXs),
      child: Row(
        textDirection: TextDirection.rtl,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: MedicalCategoryCard(
              icon: AppAssets.toothIcon,
              label: AppStrings.teeth,
              isSelected: false,
              onTap: () => _handleCategoryTap(context, 'teeth'),
            ),
          ),
          Expanded(
            child: MedicalCategoryCard(
              icon: AppAssets.brainIcon,
              label: AppStrings.brain,
              isSelected: false,
              onTap: () => _handleCategoryTap(context, 'brain'),
            ),
          ),
          Expanded(
            child: MedicalCategoryCard(
              icon: AppAssets.lungsIcon,
              label: AppStrings.lungs,
              isSelected: false,
              onTap: () => _handleCategoryTap(context, 'lungs'),
            ),
          ),
          Expanded(
            child: MedicalCategoryCard(
              icon: AppAssets.stomachIcon,
              label: AppStrings.stomach,
              isSelected: false,
              onTap: () => _handleCategoryTap(context, 'stomach'),
            ),
          ),
          Expanded(
            child: MedicalCategoryCard(
              icon: AppAssets.heartIcon,
              label: AppStrings.heart,
              isSelected: true,
              onTap: () => _handleCategoryTap(context, 'heart'),
            ),
          ),
        ],
      ),
    );
  }

  void _handleCategoryTap(BuildContext context, String category) {
    // Navigate to filtered doctor list or category details
    context.push('${RouteNames.doctors}?category=$category');
  }

  Widget _buildQuickActions(BuildContext context) {
    final padding = _getResponsivePadding(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Text(
            'الخدمات السريعة',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: AppColors.primary,
            ),
            textAlign: TextAlign.right,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Semantics(
                  label: 'حجز موعد مع طبيب',
                  hint: 'فتح صفحة حجز المواعيد',
                  button: true,
                  child: InkWell(
                    onTap: () => context.go(RouteNames.bookAppointment),
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: AppColors.secondary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Icon(
                              Icons.calendar_today,
                              color: AppColors.secondary,
                              size: 20,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'حجز موعد',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: AppColors.primary,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () => context.go(RouteNames.nearbyMap),
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: AppColors.quickActionGreen.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Icon(
                            Icons.location_on,
                            color: AppColors.quickActionGreen,
                            size: 20,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'العثور على طبيب',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primary,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () => context.go(RouteNames.healthRecords),
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: AppColors.quickActionPurple.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Icon(
                            Icons.medical_services,
                            color: AppColors.quickActionPurple,
                            size: 20,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'السجلات الطبية',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primary,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () => context.go(RouteNames.chat),
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: AppColors.quickActionOrange.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Icon(
                            Icons.chat,
                            color: AppColors.quickActionOrange,
                            size: 20,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'المحادثة',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primary,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedDoctors(BuildContext context) {
    final padding = _getResponsivePadding(context);
    final isTablet = _isTablet(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Semantics(
                label: 'عرض جميع الأطباء',
                hint: 'الانتقال إلى صفحة جميع الأطباء',
                button: true,
                child: TextButton(
                  onPressed: () => context.go(RouteNames.doctors),
                  child: Text(
                    AppStrings.seeAll,
                    style: AppTextStyles.homeSectionSubtitle.copyWith(
                      color: AppColors.figmaPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Text(
                'الأطباء المميزين',
                style: AppTextStyles.homeSectionTitle.copyWith(
                  color: AppColors.figmaPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.spacingMd),
          SizedBox(
            height: AppDimensions.cardExtended + 20,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding:
                  const EdgeInsets.symmetric(horizontal: AppDimensions.spacingXs),
              itemCount: isTablet ? 6 : 5, // Show more items on tablet
              itemBuilder: (ctx, index) {
                return _buildFeaturedDoctorCard(ctx, index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedDoctorCard(BuildContext context, int index) {
    final doctor = _featuredDoctors[index];

    return Container(
      width: MediaQuery.of(context).size.width *
          0.6, // Responsive width: 60% of screen width
      constraints: const BoxConstraints(
          minWidth: 180, maxWidth: 220), // Reasonable bounds
      margin: const EdgeInsets.only(left: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: InkWell(
        onTap: () => context.go(RouteNames.doctorDetails),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Doctor Image
              Stack(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      image: DecorationImage(
                        image: AssetImage(doctor['image'] as String),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  if (doctor['available'] as bool)
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: const BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 12,
                        ),
                      ),
                    ),
                ],
              ),

              const SizedBox(height: 12),

              // Doctor Name
              Text(
                doctor['name'] as String,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 4),

              // Specialty
              Text(
                doctor['specialty'] as String,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.homeSecondaryText,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 8),

              // Rating
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${doctor['rating']}',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  const Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 12,
                  ),
                  Text(
                    '(${doctor['reviews']})',
                    style: const TextStyle(
                      fontSize: 10,
                      color: AppColors.homeSecondaryText,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Price
              Text(
                '${doctor['price']} جنيه',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),

              const SizedBox(height: 12),

              // Book Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => context.go(RouteNames.bookAppointment),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'حجز',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDoctorCategories(BuildContext context) {
    final padding = _getResponsivePadding(context);
    final isTablet = _isTablet(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Text(
            'التخصصات الطبية',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: AppColors.primary,
            ),
            textAlign: TextAlign.right,
          ),
          const SizedBox(height: 16),
          LayoutBuilder(
            builder: (context, constraints) {
              // Responsive columns: 2 for mobile, 3 for tablet, 4 for large tablet
              final crossAxisCount = isTablet
                  ? (constraints.maxWidth > 800 ? 4 : 3)
                  : (constraints.maxWidth < 400 ? 2 : 3);
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.8,
                ),
                itemCount: _categories.length,
                itemBuilder: (ctx, index) {
                  final category = _categories[index];
                  return _buildCategoryCard(ctx, category);
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(
      BuildContext context, Map<String, dynamic> category) {
    return InkWell(
      onTap: () => context.go(RouteNames.doctors),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              category['icon'],
              width: 32,
              height: 32,
              colorFilter: const ColorFilter.mode(
                AppColors.primary,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              category['name'],
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              '${category['count']} طبيب',
              style: const TextStyle(
                fontSize: 10,
                color: AppColors.homeSecondaryText,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNearbyDoctors(BuildContext context) {
    final padding = _getResponsivePadding(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () => context.go(RouteNames.nearbyMap),
                child: const Text(
                  AppStrings.seeAll,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: AppColors.primary,
                  ),
                ),
              ),
              const Text(
                'الأطباء القريبين',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildNearbyDoctorItem(
            context,
            'د. أحمد محمد',
            'أخصائي أعصاب',
            '2.3 كم',
            4.9,
            true,
          ),
          _buildNearbyDoctorItem(
            context,
            'د. سارة أحمد',
            'أخصائية قلب',
            '1.8 كم',
            4.8,
            false,
          ),
          _buildNearbyDoctorItem(
            context,
            'د. محمد علي',
            'أخصائي باطنة',
            '3.1 كم',
            4.7,
            true,
          ),
        ],
      ),
    );
  }

  Widget _buildNearbyDoctorItem(
    BuildContext context,
    String name,
    String specialty,
    String distance,
    double rating,
    bool available,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: () => context.go(RouteNames.doctorDetails),
        borderRadius: BorderRadius.circular(12),
        child: Row(
          children: [
            // Doctor Image
            Stack(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    image: const DecorationImage(
                      image: AssetImage(AppAssets.doctorImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                if (available)
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            ),

            const SizedBox(width: 12),

            // Doctor Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    specialty,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.homeSecondaryText,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        distance,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.homeSecondaryText,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 12,
                      ),
                      Text(
                        '$rating',
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Arrow
            const Icon(
              Icons.arrow_forward_ios,
              color: AppColors.homeSecondaryText,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHealthTips(BuildContext context) {
    final padding = _getResponsivePadding(context);
    return Padding(
      padding: EdgeInsetsDirectional.symmetric(horizontal: padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Text(
            'نصائح صحية',
            style: AppTextStyles.homeSectionTitle,
            textAlign: TextAlign.right,
          ),
          const SizedBox(height: AppDimensions.spacingXl),
          Container(
            padding: const EdgeInsets.all(AppDimensions.spacing2xl),
            decoration: BoxDecoration(
              color: AppColors.homeCardBackground,
              borderRadius: BorderRadius.circular(AppDimensions.radius2xl),
              boxShadow: AppColors.cardShadow,
            ),
            child: Column(
              children: [
                // Tip Icon (iOS style)
                Container(
                  width: AppDimensions.avatarXl, // 80pt
                  height: AppDimensions.avatarXl,
                  decoration: BoxDecoration(
                    color: AppColors.quickActionTeal
                        .withOpacity(0.1), // iOSTeal background
                    borderRadius: BorderRadius.circular(
                        AppDimensions.avatarXl / 2), // Perfect circle
                  ),
                  child: const Icon(
                    Icons.lightbulb_outline,
                    color: AppColors.quickActionTeal, // iOS teal
                    size: AppDimensions.iconXl, // 48pt
                  ),
                ),

                const SizedBox(height: AppDimensions.spacingLg),

                // Tip Title (iOS style)
                const Text(
                  'تناول الماء بانتظام',
                  style: TextStyle(
                    fontSize: 22, // 22pt iOS subheadline medium
                    fontWeight: FontWeight.w600,
                    color: AppColors.homePrimaryText,
                    height: 1.3,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: AppDimensions.spacingMd),

                // Tip Content (iOS style)
                Text(
                  'يحتاج الجسم إلى 8 أكواب من الماء يومياً للحفاظ على الصحة والترطيب الجيد. اشرب كوباً من الماء كل ساعة.',
                  style: AppTextStyles.homeBodyText.copyWith(
                    height: 1.4,
                    fontSize: 15, // 15pt for better readability
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: AppDimensions.spacingLg),

                // Action Button (iOS style)
                Semantics(
                  label: 'تعلم المزيد عن نصائح صحية',
                  hint: 'الانتقل إلى صفحة النصائح الصحية',
                  button: true,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to health tips page
                      context.push('/health-tips');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.homeAccentBlue,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shadowColor: Colors.transparent,
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppDimensions.spacing2xl, // 32pt
                        vertical: AppDimensions.spacingMd, // 16pt
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            AppDimensions.radiusLg), // 12pt radius
                      ),
                    ),
                    child: const Text(
                      'تعلم المزيد',
                      style: AppTextStyles.homeButtonText,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
