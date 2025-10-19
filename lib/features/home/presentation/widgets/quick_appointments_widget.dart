import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:neurocare_app/core/constants/app_colors.dart';
import 'package:neurocare_app/core/constants/app_dimensions.dart';
import 'package:neurocare_app/core/constants/app_text_styles.dart';
import 'package:neurocare_app/core/constants/app_assets.dart';
import 'package:neurocare_app/core/routes/route_names.dart';

class QuickAppointmentsWidget extends StatelessWidget {
  const QuickAppointmentsWidget({super.key});

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
                  'المواعيد السريعة',
                  style: isTablet
                      ? AppTextStyles.headlineSmall
                          .copyWith(fontWeight: FontWeight.w600)
                      : AppTextStyles.titleLarge
                          .copyWith(fontWeight: FontWeight.w600),
                ),
                Semantics(
                  label: 'عرض جميع المواعيد',
                  hint: 'فتح صفحة المواعيد المفصلة',
                  button: true,
                  child: IconButton(
                    icon: const Icon(
                      Icons.calendar_today,
                      color: AppColors.homeTertiaryText,
                      size: AppDimensions.iconSm,
                    ),
                    onPressed: () {
                      context.go(RouteNames.appointments);
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: AppDimensions.spacingLg),

            // Upcoming Appointments
            _buildUpcomingAppointments(context),

            const SizedBox(height: AppDimensions.spacingLg),

            // Quick Action Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  context.go(RouteNames.bookAppointment);
                },
                icon: const Icon(
                  Icons.add,
                  size: 20,
                ),
                label: const Text(
                  'حجز موعد جديد',
                  style: AppTextStyles.homeButtonText,
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.homeAccentBlue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                      vertical: AppDimensions.spacingMd),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
                  ),
                  elevation: 0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUpcomingAppointments(BuildContext context) {
    final appointments = [
      {
        'doctor': 'د. سارة أحمد',
        'specialty': 'أخصائية قلب',
        'date': ' اليوم',
        'time': '2:00 م',
        'type': 'فيديو',
        'avatar': AppAssets.doctorImage,
        'status': 'قادم',
      },
      {
        'doctor': 'د. محمد علي',
        'specialty': 'أخصائي باطنة',
        'date': 'غداً',
        'time': '10:00 ص',
        'type': 'عيادة',
        'avatar': AppAssets.doctorImage,
        'status': 'مؤكد',
      },
    ];

    return Column(
      children: appointments.asMap().entries.map((entry) {
        final index = entry.key;
        final appointment = entry.value;

        return Column(
          children: [
            if (index > 0) const SizedBox(height: AppDimensions.spacingMd),
            _AppointmentCard(
              doctor: appointment['doctor'] as String,
              specialty: appointment['specialty'] as String,
              date: appointment['date'] as String,
              time: appointment['time'] as String,
              type: appointment['type'] as String,
              avatar: appointment['avatar'] as String,
              status: appointment['status'] as String,
            ),
          ],
        );
      }).toList(),
    );
  }
}

class _AppointmentCard extends StatelessWidget {
  final String doctor;
  final String specialty;
  final String date;
  final String time;
  final String type;
  final String avatar;
  final String status;

  const _AppointmentCard({
    required this.doctor,
    required this.specialty,
    required this.date,
    required this.time,
    required this.type,
    required this.avatar,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'موعد مع $doctor المتخصص في $specialty',
      hint: '$date - $time - $type',
      button: true,
      child: InkWell(
        onTap: () {
          // TODO: Navigate to appointment details
        },
        borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
        child: Container(
          padding: const EdgeInsets.all(AppDimensions.spacingMd),
          decoration: BoxDecoration(
            color: AppColors.homeCardBackground,
            borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
            border: Border.all(
              color: AppColors.homeDivider,
              width: 1,
            ),
          ),
          child: Row(
            children: [
              // Doctor Avatar
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  image: DecorationImage(
                    image: AssetImage(avatar),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              const SizedBox(width: AppDimensions.spacingMd),

              // Appointment Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Doctor Name
                    Text(
                      doctor,
                      style: AppTextStyles.homeDoctorName,
                      textAlign: TextAlign.right,
                    ),

                    const SizedBox(height: AppDimensions.spacing2xs),

                    // Specialty
                    Text(
                      specialty,
                      style: AppTextStyles.homeDoctorSpecialty,
                      textAlign: TextAlign.right,
                    ),

                    const SizedBox(height: AppDimensions.spacingXs),

                    // Date and Time
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppDimensions.spacingXs,
                            vertical: AppDimensions.spacing2xs,
                          ),
                          decoration: BoxDecoration(
                            color: type == 'فيديو'
                                ? AppColors.homeAccentBlue.withOpacity(0.1)
                                : AppColors.quickActionGreen.withOpacity(0.1),
                            borderRadius:
                                BorderRadius.circular(AppDimensions.radiusSm),
                          ),
                          child: Text(
                            type,
                            style: AppTextStyles.bodySmall.copyWith(
                              color: type == 'فيديو'
                                  ? AppColors.homeAccentBlue
                                  : AppColors.quickActionGreen,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(width: AppDimensions.spacingSm),
                        Text(
                          '$date • $time',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.homeTertiaryText,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Status/Action Icon
              const Icon(
                Icons.arrow_forward_ios,
                color: AppColors.homeTertiaryText,
                size: AppDimensions.iconSm,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
