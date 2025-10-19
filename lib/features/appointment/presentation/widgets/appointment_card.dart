import 'package:flutter/material.dart';
import 'package:neurocare_app/core/constants/app_colors.dart';
import 'package:neurocare_app/features/appointment/domain/entities/appointment_entity.dart';

class AppointmentCard extends StatelessWidget {
  final AppointmentEntity appointment;
  final VoidCallback onTap;

  const AppointmentCard({
    super.key,
    required this.appointment,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status and Date
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStatusChip(context),
                Text(
                  _formatDate(appointment.appointmentDate),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.homeSecondaryText,
                      ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Doctor Info
            Row(
              children: [
                // Doctor Image
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(appointment.doctorImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                // Doctor Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        appointment.doctorName,
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: AppColors.homePrimaryText,
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      Text(
                        appointment.doctorSpecialty,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.homeSecondaryText,
                            ),
                      ),
                    ],
                  ),
                ),

                // Time and Price
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      appointment.timeSlot,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.homePrimaryText,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    if (appointment.price != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        '${appointment.price} ${appointment.currency ?? 'ريال'}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.homeAccentBlue,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ],
                  ],
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Location or Virtual indicator
            Row(
              children: [
                Icon(
                  appointment.isVirtual ? Icons.videocam : Icons.location_on,
                  size: 16,
                  color: AppColors.homeSecondaryText,
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    appointment.isVirtual
                        ? 'موعد افتراضي'
                        : (appointment.location ?? 'الموقع غير محدد'),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.homeSecondaryText,
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),

            // Notes preview (if any)
            if (appointment.notes != null && appointment.notes!.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                appointment.notes!,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.homeSecondaryText.withOpacity(0.8),
                    ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(BuildContext context) {
    Color backgroundColor;
    Color textColor;
    String statusText;

    switch (appointment.status) {
      case AppointmentStatus.pending:
        backgroundColor = Colors.orange.withOpacity(0.1);
        textColor = Colors.orange;
        statusText = 'في الانتظار';
        break;
      case AppointmentStatus.confirmed:
        backgroundColor = Colors.green.withOpacity(0.1);
        textColor = Colors.green;
        statusText = 'مؤكد';
        break;
      case AppointmentStatus.completed:
        backgroundColor = Colors.blue.withOpacity(0.1);
        textColor = Colors.blue;
        statusText = 'مكتمل';
        break;
      case AppointmentStatus.cancelled:
        backgroundColor = Colors.red.withOpacity(0.1);
        textColor = Colors.red;
        statusText = 'ملغي';
        break;
      case AppointmentStatus.rescheduled:
        backgroundColor = Colors.purple.withOpacity(0.1);
        textColor = Colors.purple;
        statusText = 'معاد جدولته';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        statusText,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: textColor,
              fontWeight: FontWeight.w500,
            ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final appointmentDay = DateTime(date.year, date.month, date.day);

    if (appointmentDay == today) {
      return 'اليوم';
    } else if (appointmentDay == today.add(const Duration(days: 1))) {
      return 'غداً';
    } else if (appointmentDay == today.subtract(const Duration(days: 1))) {
      return 'أمس';
    } else {
      // Format as Arabic date
      final months = [
        'يناير',
        'فبراير',
        'مارس',
        'أبريل',
        'مايو',
        'يونيو',
        'يوليو',
        'أغسطس',
        'سبتمبر',
        'أكتوبر',
        'نوفمبر',
        'ديسمبر'
      ];
      return '${date.day} ${months[date.month - 1]} ${date.year}';
    }
  }
}
