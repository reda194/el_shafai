import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:neurocare_app/core/constants/app_assets.dart';
import 'package:neurocare_app/core/constants/app_colors.dart';
import 'package:neurocare_app/core/routes/route_names.dart';
import 'package:neurocare_app/shared/widgets/common/bottom_nav_bar.dart';

class DoctorProfileDetailsScreen extends StatelessWidget {
  const DoctorProfileDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.onboardingBackground,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header with Doctor Image
            _buildDoctorHeader(context),

            // Doctor Info Card
            _buildDoctorInfoCard(),

            // About Section
            _buildAboutSection(),

            // Reviews Section
            _buildReviewsSection(),

            // Location Section
            _buildLocationSection(),

            // Bottom Actions
            _buildBottomActions(context),

            const SizedBox(height: 100), // Space for bottom navigation
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 2),
    );
  }

  Widget _buildDoctorHeader(BuildContext context) {
    return Stack(
      children: [
        // Background Image
        Container(
          height: 300,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/doctor_bg.png'), // Placeholder
              fit: BoxFit.cover,
            ),
          ),
        ),

        // Back Button
        Positioned(
          top: 50,
          right: 20,
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(20),
            ),
            child: IconButton(
              icon: SvgPicture.asset(
                AppAssets.arrowIcon,
                width: 20,
                height: 20,
                colorFilter: const ColorFilter.mode(
                  AppColors.primary,
                  BlendMode.srcIn,
                ),
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ),

        // Favorite Button
        Positioned(
          top: 50,
          left: 20,
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(20),
            ),
            child: IconButton(
              icon: const Icon(
                Icons.favorite_border,
                color: AppColors.primary,
                size: 20,
              ),
              onPressed: () {},
            ),
          ),
        ),

        // Doctor Profile Image
        Positioned(
          bottom: 20,
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 4),
                image: const DecorationImage(
                  image: AssetImage(
                      'assets/images/doctor_placeholder.png'), // Placeholder
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDoctorInfoCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 2),
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        children: [
          // Doctor Name and Rating
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'د. أحمد محمد علي',
                    style: TextStyle(
                      fontFamily: 'IBM Plex Sans Arabic',
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: AppColors.primary,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  SizedBox(height: 4),
                  Text(
                    'طبيب قلب وأوعية دموية',
                    style: TextStyle(
                      fontFamily: 'IBM Plex Sans Arabic',
                      fontSize: 16,
                      color: AppColors.homeSecondaryText,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.amber.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 16,
                    ),
                    SizedBox(width: 4),
                    Text(
                      '4.8',
                      style: TextStyle(
                        fontFamily: 'IBM Plex Sans Arabic',
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Stats
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStatItem('500+', 'مريض'),
              Container(
                height: 40,
                width: 1,
                color: AppColors.homeSecondaryText.withOpacity(0.3),
              ),
              _buildStatItem('8 سنوات', 'خبرة'),
              Container(
                height: 40,
                width: 1,
                color: AppColors.homeSecondaryText.withOpacity(0.3),
              ),
              _buildStatItem('150', 'مراجعة'),
            ],
          ),

          const SizedBox(height: 20),

          // Contact Buttons
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.phone,
                    size: 16,
                    color: Colors.white,
                  ),
                  label: const Text(
                    'اتصال',
                    style: TextStyle(
                      fontFamily: 'IBM Plex Sans Arabic',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    AppAssets.chatIcon,
                    width: 16,
                    height: 16,
                    colorFilter: const ColorFilter.mode(
                      AppColors.primary,
                      BlendMode.srcIn,
                    ),
                  ),
                  label: const Text(
                    'رسالة',
                    style: TextStyle(
                      fontFamily: 'IBM Plex Sans Arabic',
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.primary),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
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

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontFamily: 'IBM Plex Sans Arabic',
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: AppColors.primary,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'IBM Plex Sans Arabic',
            fontSize: 12,
            color: AppColors.homeSecondaryText,
          ),
        ),
      ],
    );
  }

  Widget _buildAboutSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 2),
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Text(
            'عن الطبيب',
            style: TextStyle(
              fontFamily: 'IBM Plex Sans Arabic',
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: AppColors.primary,
            ),
            textAlign: TextAlign.right,
          ),
          const SizedBox(height: 12),
          const Text(
            'الدكتور أحمد محمد علي هو استشاري متخصص في أمراض القلب والأوعية الدموية. يتمتع بخبرة واسعة في تشخيص وعلاج أمراض القلب المختلفة. حاصل على شهادة البورد الأمريكي في أمراض القلب.',
            style: TextStyle(
              fontFamily: 'IBM Plex Sans Arabic',
              fontSize: 14,
              color: AppColors.homeSecondaryText,
              height: 1.6,
            ),
            textAlign: TextAlign.right,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _buildSpecialtyChip('قلب'),
              const SizedBox(width: 8),
              _buildSpecialtyChip('أوعية دموية'),
              const SizedBox(width: 8),
              _buildSpecialtyChip('ضغط دم'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSpecialtyChip(String specialty) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        specialty,
        style: const TextStyle(
          fontFamily: 'IBM Plex Sans Arabic',
          fontSize: 12,
          color: AppColors.primary,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildReviewsSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 2),
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {},
                child: const Text(
                  'عرض الكل',
                  style: TextStyle(
                    fontFamily: 'IBM Plex Sans Arabic',
                    fontSize: 14,
                    color: AppColors.primary,
                  ),
                ),
              ),
              const Text(
                'المراجعات والتقييمات',
                style: TextStyle(
                  fontFamily: 'IBM Plex Sans Arabic',
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: AppColors.primary,
                ),
                textAlign: TextAlign.right,
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildReviewItem(
            name: 'سارة محمد',
            rating: 5,
            comment: 'خدمة ممتازة وتشخيص دقيق. الطبيب محترف جداً.',
            time: 'منذ أسبوع',
          ),
          const SizedBox(height: 12),
          _buildReviewItem(
            name: 'أحمد علي',
            rating: 5,
            comment: 'تعامل رائع وشرح مفصل عن الحالة الصحية.',
            time: 'منذ أسبوعين',
          ),
        ],
      ),
    );
  }

  Widget _buildReviewItem({
    required String name,
    required int rating,
    required String comment,
    required String time,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Avatar
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primary.withOpacity(0.1),
          ),
          child: Center(
            child: Text(
              name.substring(0, 1),
              style: const TextStyle(
                fontFamily: 'IBM Plex Sans Arabic',
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
          ),
        ),

        const SizedBox(width: 12),

        // Review Content
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    time,
                    style: const TextStyle(
                      fontFamily: 'IBM Plex Sans Arabic',
                      fontSize: 12,
                      color: AppColors.homeSecondaryText,
                    ),
                  ),
                  Text(
                    name,
                    style: const TextStyle(
                      fontFamily: 'IBM Plex Sans Arabic',
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: AppColors.primary,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),

              const SizedBox(height: 4),

              // Stars
              Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(5, (index) {
                  return Icon(
                    index < rating ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                    size: 14,
                  );
                }),
              ),

              const SizedBox(height: 4),

              Text(
                comment,
                style: const TextStyle(
                  fontFamily: 'IBM Plex Sans Arabic',
                  fontSize: 14,
                  color: AppColors.homeSecondaryText,
                  height: 1.4,
                ),
                textAlign: TextAlign.right,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLocationSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 2),
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Text(
            'الموقع والعنوان',
            style: TextStyle(
              fontFamily: 'IBM Plex Sans Arabic',
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: AppColors.primary,
            ),
            textAlign: TextAlign.right,
          ),
          const SizedBox(height: 12),

          // Map Placeholder
          Container(
            height: 120,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: Icon(
                Icons.location_on,
                color: AppColors.primary,
                size: 40,
              ),
            ),
          ),

          const SizedBox(height: 12),

          const Text(
            'شارع الملك عبدالعزيز، حي العليا، الرياض',
            style: TextStyle(
              fontFamily: 'IBM Plex Sans Arabic',
              fontSize: 14,
              color: AppColors.homeSecondaryText,
            ),
            textAlign: TextAlign.right,
          ),

          const SizedBox(height: 8),

          const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'مستشفى الملك فيصل التخصصي',
                style: TextStyle(
                  fontFamily: 'IBM Plex Sans Arabic',
                  fontSize: 16,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.right,
              ),
              SizedBox(width: 8),
              Icon(
                Icons.location_on,
                color: AppColors.primary,
                size: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomActions(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 2),
            blurRadius: 8,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.primary),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'حجز موعد',
                style: TextStyle(
                  fontFamily: 'IBM Plex Sans Arabic',
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton(
              onPressed: () => Navigator.of(context).pushNamed(RouteNames.chat),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'بدء محادثة',
                style: TextStyle(
                  fontFamily: 'IBM Plex Sans Arabic',
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
