import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:neurocare_app/core/constants/app_colors.dart';

class AppointmentCalendar extends StatefulWidget {
  final DateTime? selectedDate;
  final Function(DateTime) onDateSelected;
  final List<DateTime> availableDates;

  const AppointmentCalendar({
    super.key,
    this.selectedDate,
    required this.onDateSelected,
    this.availableDates = const [],
  });

  @override
  State<AppointmentCalendar> createState() => _AppointmentCalendarState();
}

class _AppointmentCalendarState extends State<AppointmentCalendar> {
  late DateTime _currentMonth;

  @override
  void initState() {
    super.initState();
    _currentMonth = DateTime.now();
  }

  bool _isDateAvailable(DateTime date) {
    if (widget.availableDates.isEmpty) {
      // If no specific available dates provided, make weekdays available
      return date.weekday != DateTime.friday &&
          date.weekday != DateTime.saturday;
    }
    return widget.availableDates.any((availableDate) =>
        availableDate.year == date.year &&
        availableDate.month == date.month &&
        availableDate.day == date.day);
  }

  bool _isDateSelected(DateTime date) {
    return widget.selectedDate != null &&
        widget.selectedDate!.year == date.year &&
        widget.selectedDate!.month == date.month &&
        widget.selectedDate!.day == date.day;
  }

  @override
  Widget build(BuildContext context) {
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
          // Month Navigation
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    _currentMonth =
                        DateTime(_currentMonth.year, _currentMonth.month - 1);
                  });
                },
                icon: const Icon(
                  Icons.chevron_right,
                  color: AppColors.primary,
                  size: 28,
                ),
              ),
              Text(
                DateFormat('MMMM y', 'ar').format(_currentMonth),
                style: const TextStyle(
                  fontFamily: 'IBM Plex Sans Arabic',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    _currentMonth =
                        DateTime(_currentMonth.year, _currentMonth.month + 1);
                  });
                },
                icon: const Icon(
                  Icons.chevron_left,
                  color: AppColors.primary,
                  size: 28,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Day Labels
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              'السبت',
              'الجمعة',
              'الخميس',
              'الأربعاء',
              'الثلاثاء',
              'الاثنين',
              'الأحد'
            ]
                .map((day) => Expanded(
                      child: Center(
                        child: Text(
                          day,
                          style: const TextStyle(
                            fontFamily: 'IBM Plex Sans Arabic',
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.homeSecondaryText,
                          ),
                        ),
                      ),
                    ))
                .toList(),
          ),

          const SizedBox(height: 12),

          // Calendar Grid
          _buildCalendarGrid(),

          const SizedBox(height: 20),

          // Selected Date Display
          if (widget.selectedDate != null)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.primary.withOpacity(0.3),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.calendar_today,
                    color: AppColors.primary,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'تم اختيار: ${DateFormat('EEEE، d MMMM y', 'ar').format(widget.selectedDate!)}',
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
      ),
    );
  }

  Widget _buildCalendarGrid() {
    final firstDayOfMonth =
        DateTime(_currentMonth.year, _currentMonth.month, 1);
    final lastDayOfMonth =
        DateTime(_currentMonth.year, _currentMonth.month + 1, 0);
    final firstDayOfWeek = firstDayOfMonth.weekday;

    // Calculate the starting day (Saturday = 6 in Flutter, we want Saturday = 0)
    final startDay =
        (firstDayOfWeek - 6) % 7; // Adjust for Arabic week (Saturday first)

    final daysInMonth = lastDayOfMonth.day;
    const totalCells = 42; // 6 weeks * 7 days
    final days = <DateTime>[];

    // Add previous month days
    final prevMonth = DateTime(_currentMonth.year, _currentMonth.month - 1);
    final prevMonthDays = DateTime(prevMonth.year, prevMonth.month + 1, 0).day;

    for (int i = startDay - 1; i >= 0; i--) {
      days.add(DateTime(prevMonth.year, prevMonth.month, prevMonthDays - i));
    }

    // Add current month days
    for (int day = 1; day <= daysInMonth; day++) {
      days.add(DateTime(_currentMonth.year, _currentMonth.month, day));
    }

    // Add next month days
    final remainingCells = totalCells - days.length;
    for (int day = 1; day <= remainingCells; day++) {
      days.add(DateTime(_currentMonth.year, _currentMonth.month + 1, day));
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemCount: days.length,
      itemBuilder: (context, index) {
        final date = days[index];
        final isCurrentMonth = date.month == _currentMonth.month;
        final isToday = date.year == DateTime.now().year &&
            date.month == DateTime.now().month &&
            date.day == DateTime.now().day;
        final isSelected = _isDateSelected(date);
        final isAvailable = _isDateAvailable(date);
        final isPast =
            date.isBefore(DateTime.now().subtract(const Duration(days: 1)));

        return GestureDetector(
          onTap: (isCurrentMonth && !isPast && isAvailable)
              ? () => widget.onDateSelected(date)
              : null,
          child: Container(
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.primary
                  : isToday && isCurrentMonth
                      ? AppColors.primary.withOpacity(0.1)
                      : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              border: isSelected
                  ? null
                  : Border.all(
                      color: isToday && isCurrentMonth
                          ? AppColors.primary.withOpacity(0.3)
                          : Colors.transparent,
                      width: 1,
                    ),
            ),
            child: Center(
              child: Text(
                date.day.toString(),
                style: TextStyle(
                  fontFamily: 'IBM Plex Sans Arabic',
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: !isCurrentMonth
                      ? AppColors.homeSecondaryText.withOpacity(0.3)
                      : isSelected
                          ? Colors.white
                          : isPast || !isAvailable
                              ? AppColors.homeSecondaryText.withOpacity(0.5)
                              : isToday
                                  ? AppColors.primary
                                  : AppColors.primary,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
