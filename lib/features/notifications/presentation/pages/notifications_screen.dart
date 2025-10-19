import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:neurocare_app/core/constants/app_assets.dart';
import 'package:neurocare_app/core/constants/app_colors.dart';
import 'package:neurocare_app/core/constants/app_strings.dart';
import 'package:neurocare_app/shared/widgets/common/bottom_nav_bar.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.onboardingBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          AppStrings.notifications,
          style: TextStyle(
            fontFamily: 'IBM Plex Sans Arabic',
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: AppColors.primary,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: SvgPicture.asset(
            AppAssets.arrowIcon,
            width: 24,
            height: 24,
            colorFilter: const ColorFilter.mode(
              AppColors.primary,
              BlendMode.srcIn,
            ),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Today Section
            _buildSectionTitle('اليوم'),
            const SizedBox(height: 16),
            _buildNotificationCard(
              title: 'تم تأكيد موعدك',
              message: 'تم تأكيد موعدك مع د. أحمد محمد في 15 ديسمبر 2024',
              time: 'منذ 2 ساعات',
              isNew: true,
            ),
            const SizedBox(height: 12),
            _buildNotificationCard(
              title: 'تذكير بالدواء',
              message: 'حان وقت تناول دواء الضغط',
              time: 'منذ 4 ساعات',
              isNew: true,
            ),

            const SizedBox(height: 32),

            // Yesterday Section
            _buildSectionTitle('أمس'),
            const SizedBox(height: 16),
            _buildNotificationCard(
              title: 'نتائج الفحوصات جاهزة',
              message: 'نتائج فحوصاتك الطبية متاحة الآن',
              time: 'أمس',
              isNew: false,
            ),
            const SizedBox(height: 12),
            _buildNotificationCard(
              title: 'تحديث التطبيق',
              message: 'تم تحديث التطبيق بميزات جديدة',
              time: 'أمس',
              isNew: false,
            ),

            const SizedBox(height: 32),

            // This Week Section
            _buildSectionTitle('هذا الأسبوع'),
            const SizedBox(height: 16),
            _buildNotificationCard(
              title: 'موعد طبي قادم',
              message: 'تذكير بموعدك مع د. سارة أحمد غداً',
              time: 'منذ 3 أيام',
              isNew: false,
            ),
            const SizedBox(height: 12),
            _buildNotificationCard(
              title: 'نصائح صحية',
              message: 'اقرأ نصيحتنا الجديدة عن الصحة القلبية',
              time: 'منذ 5 أيام',
              isNew: false,
            ),

            const SizedBox(height: 100), // Space for bottom navigation
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 3),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontFamily: 'IBM Plex Sans Arabic',
        fontWeight: FontWeight.bold,
        fontSize: 18,
        color: AppColors.primary,
      ),
      textAlign: TextAlign.right,
    );
  }

  Widget _buildNotificationCard({
    required String title,
    required String message,
    required String time,
    required bool isNew,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
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
          // Notification Icon
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: isNew
                  ? AppColors.primary.withOpacity(0.1)
                  : AppColors.authButtonTransparent,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Center(
              child: SvgPicture.asset(
                isNew ? AppAssets.notificationIcon : AppAssets.calendarNavIcon,
                width: 20,
                height: 20,
                colorFilter: ColorFilter.mode(
                  isNew ? AppColors.primary : AppColors.homeSecondaryText,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),

          const SizedBox(width: 12),

          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Time
                    Text(
                      time,
                      style: const TextStyle(
                        fontFamily: 'IBM Plex Sans Arabic',
                        fontSize: 12,
                        color: AppColors.homeSecondaryText,
                      ),
                    ),

                    // New Indicator
                    if (isNew)
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),

                const SizedBox(height: 4),

                // Title
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'IBM Plex Sans Arabic',
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: AppColors.primary,
                  ),
                  textAlign: TextAlign.right,
                ),

                const SizedBox(height: 4),

                // Message
                Text(
                  message,
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
      ),
    );
  }
}
