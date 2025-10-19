import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:neurocare_app/core/constants/app_assets.dart';
import 'package:neurocare_app/core/constants/app_colors.dart';
import 'package:neurocare_app/core/routes/route_names.dart';
import 'package:neurocare_app/features/appointment/domain/entities/appointment_entity.dart';
import 'package:neurocare_app/shared/widgets/buttons/primary_button.dart';
import 'package:neurocare_app/shared/widgets/buttons/secondary_button.dart';
import 'package:neurocare_app/shared/widgets/common/bottom_nav_bar.dart';

class AppointmentDetailsScreen extends StatelessWidget {
  final AppointmentEntity appointment;

  const AppointmentDetailsScreen({
    super.key,
    required this.appointment,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.onboardingBackground,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'تفاصيل الموعد',
          style: TextStyle(
            fontFamily: 'IBM Plex Sans Arabic',
            fontSize: 18,
            fontWeight: FontWeight.bold,
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
          onPressed: () => context.pop(),
        ),
        actions: [
          if (appointment.status == 'upcoming')
            PopupMenuButton<String>(
              onSelected: (value) {
                switch (value) {
                  case 'reschedule':
                    _showRescheduleDialog(context);
                    break;
                  case 'cancel':
                    _showCancelDialog(context);
                    break;
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'reschedule',
                  child: Row(
                    children: [
                      Icon(Icons.schedule, color: AppColors.primary),
                      SizedBox(width: 8),
                      Text('إعادة جدولة'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'cancel',
                  child: Row(
                    children: [
                      Icon(Icons.cancel, color: Colors.red),
                      SizedBox(width: 8),
                      Text('إلغاء الموعد'),
                    ],
                  ),
                ),
              ],
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Status Badge
            _buildStatusBadge(),

            const SizedBox(height: 20),

            // Appointment Card
            _buildAppointmentCard(),

            const SizedBox(height: 24),

            // Doctor Information
            _buildDoctorSection(),

            const SizedBox(height: 24),

            // Appointment Details
            _buildDetailsSection(),

            const SizedBox(height: 24),

            // Action Buttons
            _buildActionButtons(context),

            const SizedBox(height: 100), // Space for bottom nav
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: -1),
    );
  }

  Widget _buildStatusBadge() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: _getStatusColor().withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _getStatusColor(),
            width: 1,
          ),
        ),
        child: Text(
          _getStatusText(),
          style: TextStyle(
            fontFamily: 'IBM Plex Sans Arabic',
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: _getStatusColor(),
          ),
        ),
      ),
    );
  }

  Widget _buildAppointmentCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Appointment Type Icon
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Icon(
              _getAppointmentTypeIcon(),
              color: AppColors.primary,
              size: 30,
            ),
          ),

          const SizedBox(height: 16),

          // Appointment Type
          Text(
            _getAppointmentTypeText(),
            style: const TextStyle(
              fontFamily: 'IBM Plex Sans Arabic',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),

          const SizedBox(height: 8),

          // Date and Time
          Text(
            DateFormat('EEEE، d MMMM y', 'ar')
                .format(appointment.appointmentDate),
            style: const TextStyle(
              fontFamily: 'IBM Plex Sans Arabic',
              fontSize: 16,
              color: AppColors.homeSecondaryText,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            appointment.timeSlot,
            style: const TextStyle(
              fontFamily: 'IBM Plex Sans Arabic',
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),

          const SizedBox(height: 16),

          // Price
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '${appointment.price} جنيه',
              style: const TextStyle(
                fontFamily: 'IBM Plex Sans Arabic',
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDoctorSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Text(
            'معلومات الطبيب',
            style: TextStyle(
              fontFamily: 'IBM Plex Sans Arabic',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
            textAlign: TextAlign.right,
          ),

          const SizedBox(height: 16),

          Row(
            children: [
              // Doctor Image
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  image: const DecorationImage(
                    image: AssetImage(AppAssets.doctorImage),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              const SizedBox(width: 16),

              // Doctor Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      appointment.doctorName,
                      style: const TextStyle(
                        fontFamily: 'IBM Plex Sans Arabic',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                      textAlign: TextAlign.right,
                    ),

                    const SizedBox(height: 4),

                    Text(
                      appointment.doctorSpecialty,
                      style: const TextStyle(
                        fontFamily: 'IBM Plex Sans Arabic',
                        fontSize: 14,
                        color: AppColors.homeSecondaryText,
                      ),
                      textAlign: TextAlign.right,
                    ),

                    const SizedBox(height: 8),

                    // Rating
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          '4.9', // TODO: Add rating to appointment entity
                          style: TextStyle(
                            fontFamily: 'IBM Plex Sans Arabic',
                            fontSize: 14,
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: 4),
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 16,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Contact Actions
          Builder(
            builder: (context) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildContactButton(
                  icon: Icons.chat,
                  label: 'المحادثة',
                  onTap: () => context.push(RouteNames.chat),
                ),
                _buildContactButton(
                  icon: Icons.phone,
                  label: 'الاتصال',
                  onTap: () => context.push(RouteNames.audioCall),
                ),
                _buildContactButton(
                  icon: Icons.videocam,
                  label: 'فيديو',
                  onTap: () => context.push(RouteNames.videoCall),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: AppColors.primary,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                fontFamily: 'IBM Plex Sans Arabic',
                fontSize: 12,
                color: AppColors.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailsSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Text(
            'تفاصيل الموعد',
            style: TextStyle(
              fontFamily: 'IBM Plex Sans Arabic',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
            textAlign: TextAlign.right,
          ),
          const SizedBox(height: 16),
          _buildDetailRow('رقم الموعد', appointment.id),
          _buildDetailRow('تاريخ الإنشاء',
              DateFormat('d MMMM y', 'ar').format(appointment.createdAt)),
          if (appointment.notes != null && appointment.notes!.isNotEmpty)
            _buildDetailRow('الملاحظات', appointment.notes!),
          if (appointment.status == 'completed' &&
              appointment.prescription != null)
            _buildDetailRow('الوصفة الطبية', appointment.prescription!),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontFamily: 'IBM Plex Sans Arabic',
                fontSize: 16,
                color: AppColors.primary,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.right,
            ),
          ),
          Text(
            '$label:',
            style: const TextStyle(
              fontFamily: 'IBM Plex Sans Arabic',
              fontSize: 14,
              color: AppColors.homeSecondaryText,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    if (appointment.status == AppointmentStatus.completed) {
      return Column(
        children: [
          PrimaryButton(
            text: 'تقييم الطبيب',
            onPressed: () => context.push(
              RouteNames.review,
              extra: {
                'targetId': appointment.doctorId,
                'reviewType': 'doctor',
                'targetName': appointment.doctorName,
              },
            ),
          ),
          const SizedBox(height: 12),
          if (appointment.prescription != null)
            SecondaryButton(
              text: 'عرض الوصفة الطبية',
              onPressed: () {
                // TODO: Navigate to prescription screen
              },
            ),
        ],
      );
    }

    if (appointment.status == AppointmentStatus.confirmed ||
        appointment.status == AppointmentStatus.pending) {
      return Row(
        children: [
          Expanded(
            child: SecondaryButton(
              text: 'إعادة جدولة',
              onPressed: () => _showRescheduleDialog(context),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: PrimaryButton(
              text: 'تعديل الموعد',
              onPressed: () {
                // TODO: Navigate to reschedule screen
              },
            ),
          ),
        ],
      );
    }

    return const SizedBox.shrink();
  }

  void _showRescheduleDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'إعادة جدولة الموعد',
          style: TextStyle(
            fontFamily: 'IBM Plex Sans Arabic',
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.right,
        ),
        content: const Text(
          'هل تريد إعادة جدولة هذا الموعد؟ سيتم إخطار الطبيب بتغيير الموعد.',
          style: TextStyle(
            fontFamily: 'IBM Plex Sans Arabic',
          ),
          textAlign: TextAlign.right,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'إلغاء',
              style: TextStyle(
                fontFamily: 'IBM Plex Sans Arabic',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              // TODO: Implement reschedule logic
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('سيتم إرسال طلب إعادة الجدولة')),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
            ),
            child: const Text(
              'تأكيد',
              style: TextStyle(
                fontFamily: 'IBM Plex Sans Arabic',
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showCancelDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'إلغاء الموعد',
          style: TextStyle(
            fontFamily: 'IBM Plex Sans Arabic',
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.right,
        ),
        content: const Text(
          'هل أنت متأكد من إلغاء هذا الموعد؟ سيتم رد المبلغ المستحق خلال 3-5 أيام عمل.',
          style: TextStyle(
            fontFamily: 'IBM Plex Sans Arabic',
          ),
          textAlign: TextAlign.right,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'تراجع',
              style: TextStyle(
                fontFamily: 'IBM Plex Sans Arabic',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              // TODO: Implement cancel logic
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('تم إلغاء الموعد بنجاح')),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text(
              'إلغاء الموعد',
              style: TextStyle(
                fontFamily: 'IBM Plex Sans Arabic',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor() {
    switch (appointment.status) {
      case AppointmentStatus.pending:
      case AppointmentStatus.confirmed:
        return Colors.blue;
      case AppointmentStatus.completed:
        return Colors.green;
      case AppointmentStatus.cancelled:
        return Colors.red;
      case AppointmentStatus.rescheduled:
        return Colors.orange;
    }
  }

  String _getStatusText() {
    switch (appointment.status) {
      case AppointmentStatus.pending:
        return 'معلق';
      case AppointmentStatus.confirmed:
        return 'مؤكد';
      case AppointmentStatus.completed:
        return 'مكتمل';
      case AppointmentStatus.cancelled:
        return 'ملغي';
      case AppointmentStatus.rescheduled:
        return 'معاد جدولته';
    }
  }

  IconData _getAppointmentTypeIcon() {
    switch (appointment.type) {
      case AppointmentType.telemedicine:
        return Icons.videocam;
      case AppointmentType.consultation:
        return Icons.medical_services;
      case AppointmentType.followUp:
        return Icons.follow_the_signs;
      case AppointmentType.emergency:
        return Icons.emergency;
    }
  }

  String _getAppointmentTypeText() {
    switch (appointment.type) {
      case AppointmentType.telemedicine:
        return 'استشارة عن بعد';
      case AppointmentType.consultation:
        return 'استشارة';
      case AppointmentType.followUp:
        return 'متابعة';
      case AppointmentType.emergency:
        return 'طوارئ';
    }
  }
}
