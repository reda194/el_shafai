import 'package:flutter/material.dart';
import 'package:neurocare_app/core/constants/app_colors.dart';

class TimeSlotSelector extends StatelessWidget {
  final List<String> availableSlots;
  final String? selectedSlot;
  final Function(String) onSlotSelected;
  final bool isLoading;

  const TimeSlotSelector({
    super.key,
    required this.availableSlots,
    this.selectedSlot,
    required this.onSlotSelected,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (availableSlots.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(24),
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
        child: const Column(
          children: [
            Icon(
              Icons.access_time,
              size: 48,
              color: AppColors.homeSecondaryText,
            ),
            SizedBox(height: 16),
            Text(
              'لا توجد أوقات متاحة لهذا التاريخ',
              style: TextStyle(
                fontFamily: 'IBM Plex Sans Arabic',
                fontSize: 16,
                color: AppColors.homeSecondaryText,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            Text(
              'يرجى اختيار تاريخ آخر',
              style: TextStyle(
                fontFamily: 'IBM Plex Sans Arabic',
                fontSize: 14,
                color: AppColors.homeSecondaryText,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

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
            'الأوقات المتاحة',
            style: TextStyle(
              fontFamily: 'IBM Plex Sans Arabic',
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
            textAlign: TextAlign.right,
          ),

          const SizedBox(height: 8),

          const Text(
            'اختر الوقت المناسب للموعد',
            style: TextStyle(
              fontFamily: 'IBM Plex Sans Arabic',
              fontSize: 14,
              color: AppColors.homeSecondaryText,
            ),
            textAlign: TextAlign.right,
          ),

          const SizedBox(height: 20),

          // Time slots grouped by morning/afternoon
          ..._buildTimeSlotGroups(),

          if (selectedSlot != null) ...[
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: AppColors.primary.withOpacity(0.3),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.access_time,
                    color: AppColors.primary,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'تم اختيار: $selectedSlot',
                    style: const TextStyle(
                      fontFamily: 'IBM Plex Sans Arabic',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  List<Widget> _buildTimeSlotGroups() {
    final morningSlots = availableSlots.where((slot) {
      final hour = int.parse(slot.split(':')[0]);
      return hour >= 8 && hour < 12;
    }).toList();

    final afternoonSlots = availableSlots.where((slot) {
      final hour = int.parse(slot.split(':')[0]);
      return hour >= 12 && hour < 17;
    }).toList();

    final eveningSlots = availableSlots.where((slot) {
      final hour = int.parse(slot.split(':')[0]);
      return hour >= 17 || hour < 8;
    }).toList();

    final groups = <Widget>[];

    if (morningSlots.isNotEmpty) {
      groups.addAll([
        _buildTimeGroup('الصباح', morningSlots, Icons.wb_sunny),
        const SizedBox(height: 20),
      ]);
    }

    if (afternoonSlots.isNotEmpty) {
      groups.addAll([
        _buildTimeGroup('الظهر', afternoonSlots, Icons.wb_cloudy),
        const SizedBox(height: 20),
      ]);
    }

    if (eveningSlots.isNotEmpty) {
      groups.addAll([
        _buildTimeGroup('المساء', eveningSlots, Icons.nightlight),
        const SizedBox(height: 20),
      ]);
    }

    return groups;
  }

  Widget _buildTimeGroup(String title, List<String> slots, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontFamily: 'IBM Plex Sans Arabic',
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              icon,
              color: AppColors.primary,
              size: 20,
            ),
          ],
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          alignment: WrapAlignment.end,
          children: slots.map((slot) => _buildTimeSlot(slot)).toList(),
        ),
      ],
    );
  }

  Widget _buildTimeSlot(String time) {
    final isSelected = selectedSlot == time;

    return GestureDetector(
      onTap: () => onSlotSelected(time),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? AppColors.primary
                : AppColors.homeSecondaryText.withOpacity(0.2),
            width: 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isSelected)
              const Icon(
                Icons.check,
                color: Colors.white,
                size: 16,
              ),
            if (isSelected) const SizedBox(width: 4),
            Text(
              _formatTimeDisplay(time),
              style: TextStyle(
                fontFamily: 'IBM Plex Sans Arabic',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTimeDisplay(String time) {
    final parts = time.split(':');
    final hour = int.parse(parts[0]);
    final minute = parts[1];

    if (hour == 0) return '12:$minute ص';
    if (hour < 12) return '$hour:$minute ص';
    if (hour == 12) return '12:$minute م';
    return '${hour - 12}:$minute م';
  }
}
