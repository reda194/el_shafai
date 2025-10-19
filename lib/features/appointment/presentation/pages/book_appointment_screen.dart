import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:neurocare_app/core/constants/app_assets.dart';
import 'package:neurocare_app/core/constants/app_colors.dart';
import 'package:neurocare_app/core/routes/route_names.dart';
import 'package:neurocare_app/features/appointment/presentation/widgets/appointment_calendar.dart';
import 'package:neurocare_app/features/appointment/presentation/widgets/time_slot_selector.dart';
import 'package:neurocare_app/shared/widgets/buttons/primary_button.dart';
import 'package:neurocare_app/shared/widgets/buttons/secondary_button.dart';
import 'package:neurocare_app/shared/widgets/common/bottom_nav_bar.dart';

class BookAppointmentScreen extends StatefulWidget {
  final String? doctorId;
  final String? doctorName;

  const BookAppointmentScreen({
    super.key,
    this.doctorId,
    this.doctorName,
  });

  @override
  State<BookAppointmentScreen> createState() => _BookAppointmentScreenState();
}

class _BookAppointmentScreenState extends State<BookAppointmentScreen> {
  int _currentStep = 0;
  DateTime? _selectedDate;
  String? _selectedTimeSlot;
  String _appointmentType = 'مكالمة فيديو';
  String _notes = '';

  // Mock doctor data (in real app, this would come from navigation params or API)
  final Map<String, dynamic> _doctorData = {
    'id': '1',
    'name': 'د. أحمد محمد',
    'specialty': 'أخصائي أعصاب',
    'rating': 4.9,
    'reviews': 125,
    'price': 150,
    'currency': 'جنيه',
    'image': AppAssets.doctorImage,
    'availableSlots': [
      '09:00',
      '10:00',
      '11:00',
      '14:00',
      '15:00',
      '16:00',
    ],
  };

  final List<String> _appointmentTypes = [
    'مكالمة فيديو',
    'مكالمة صوتية',
    'زيارة في العيادة',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.onboardingBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.primary,
          ),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'حجز موعد',
          style: TextStyle(
            fontFamily: 'IBM Plex Sans Arabic',
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: AppColors.primary,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Progress Indicator
          _buildProgressIndicator(),

          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: _buildCurrentStepContent(),
            ),
          ),

          // Bottom Actions
          _buildBottomActions(),
        ],
      ),
      bottomNavigationBar:
          const BottomNavBar(currentIndex: -1), // Not in main nav
    );
  }

  Widget _buildProgressIndicator() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: List.generate(3, (index) {
          return Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              height: 4,
              decoration: BoxDecoration(
                color: index <= _currentStep
                    ? AppColors.primary
                    : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildCurrentStepContent() {
    switch (_currentStep) {
      case 0:
        return _buildDoctorSelectionStep();
      case 1:
        return _buildDateTimeSelectionStep();
      case 2:
        return _buildConfirmationStep();
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildDoctorSelectionStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // Step Title
        const Text(
          'اختر الطبيب',
          style: TextStyle(
            fontFamily: 'IBM Plex Sans Arabic',
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
          textAlign: TextAlign.right,
        ),

        const SizedBox(height: 8),

        const Text(
          'اختر الطبيب الذي تريد حجز موعد معه',
          style: TextStyle(
            fontFamily: 'IBM Plex Sans Arabic',
            fontSize: 16,
            color: AppColors.homeSecondaryText,
          ),
          textAlign: TextAlign.right,
        ),

        const SizedBox(height: 32),

        // Doctor Card
        Container(
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
              // Doctor Info
              Row(
                children: [
                  // Doctor Image
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      image: DecorationImage(
                        image: AssetImage(_doctorData['image']),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  const SizedBox(width: 16),

                  // Doctor Details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          _doctorData['name'],
                          style: const TextStyle(
                            fontFamily: 'IBM Plex Sans Arabic',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                          textAlign: TextAlign.right,
                        ),

                        const SizedBox(height: 4),

                        Text(
                          _doctorData['specialty'],
                          style: const TextStyle(
                            fontFamily: 'IBM Plex Sans Arabic',
                            fontSize: 16,
                            color: AppColors.homeSecondaryText,
                          ),
                          textAlign: TextAlign.right,
                        ),

                        const SizedBox(height: 8),

                        // Rating
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              '${_doctorData['rating']} (${_doctorData['reviews']} مراجعة)',
                              style: const TextStyle(
                                fontFamily: 'IBM Plex Sans Arabic',
                                fontSize: 14,
                                color: AppColors.homeSecondaryText,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 16,
                            ),
                          ],
                        ),

                        const SizedBox(height: 8),

                        // Price
                        Text(
                          '${_doctorData['price']} ${_doctorData['currency']}',
                          style: const TextStyle(
                            fontFamily: 'IBM Plex Sans Arabic',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Appointment Type Selection
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    'نوع الموعد',
                    style: TextStyle(
                      fontFamily: 'IBM Plex Sans Arabic',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(height: 12),
                  ..._appointmentTypes
                      .map((type) => _buildAppointmentTypeOption(type)),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 32),

        // Notes Section
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text(
              'ملاحظات إضافية (اختياري)',
              style: TextStyle(
                fontFamily: 'IBM Plex Sans Arabic',
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
              textAlign: TextAlign.right,
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: TextEditingController(text: _notes),
                textAlign: TextAlign.right,
                maxLines: 3,
                onChanged: (value) => setState(() => _notes = value),
                decoration: const InputDecoration(
                  hintText: 'اكتب أي ملاحظات تريد إخبار الطبيب بها...',
                  hintStyle: TextStyle(
                    fontFamily: 'IBM Plex Sans Arabic',
                    color: Color(0xFF888888),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.all(16),
                ),
                style: const TextStyle(
                  fontFamily: 'IBM Plex Sans Arabic',
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAppointmentTypeOption(String type) {
    final isSelected = _appointmentType == type;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: () => setState(() => _appointmentType = type),
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.primary.withOpacity(0.1)
                : Colors.grey.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isSelected ? AppColors.primary : Colors.grey.shade300,
            ),
          ),
          child: Row(
            children: [
              Icon(
                _getAppointmentTypeIcon(type),
                color: isSelected ? AppColors.primary : Colors.grey.shade600,
                size: 20,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  type,
                  style: TextStyle(
                    fontFamily: 'IBM Plex Sans Arabic',
                    fontSize: 16,
                    color: isSelected
                        ? AppColors.primary
                        : AppColors.homeSecondaryText,
                    fontWeight:
                        isSelected ? FontWeight.w600 : FontWeight.normal,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
              if (isSelected)
                const Icon(
                  Icons.check_circle,
                  color: AppColors.primary,
                  size: 20,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateTimeSelectionStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // Step Title
        const Text(
          'اختر التاريخ والوقت',
          style: TextStyle(
            fontFamily: 'IBM Plex Sans Arabic',
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
          textAlign: TextAlign.right,
        ),

        const SizedBox(height: 8),

        const Text(
          'اختر التاريخ والوقت المناسب للموعد',
          style: TextStyle(
            fontFamily: 'IBM Plex Sans Arabic',
            fontSize: 16,
            color: AppColors.homeSecondaryText,
          ),
          textAlign: TextAlign.right,
        ),

        const SizedBox(height: 32),

        // Enhanced Calendar
        AppointmentCalendar(
          selectedDate: _selectedDate,
          onDateSelected: (date) {
            setState(() {
              _selectedDate = date;
              _selectedTimeSlot = null; // Reset time slot when date changes
            });
          },
          availableDates: _getAvailableDates(),
        ),

        const SizedBox(height: 32),

        // Enhanced Time Slots
        if (_selectedDate != null)
          TimeSlotSelector(
            availableSlots: _doctorData['availableSlots'],
            selectedSlot: _selectedTimeSlot,
            onSlotSelected: (slot) {
              setState(() => _selectedTimeSlot = slot);
            },
          ),
      ],
    );
  }

  List<DateTime> _getAvailableDates() {
    // Generate available dates for the next 30 days (excluding weekends)
    final availableDates = <DateTime>[];
    final now = DateTime.now();

    for (int i = 0; i < 30; i++) {
      final date = now.add(Duration(days: i + 1));
      // Make weekdays available (exclude Friday and Saturday)
      if (date.weekday != DateTime.friday &&
          date.weekday != DateTime.saturday) {
        availableDates.add(date);
      }
    }

    return availableDates;
  }

  Widget _buildConfirmationStep() {
    final selectedDateTime = _selectedDate != null && _selectedTimeSlot != null
        ? DateTime(
            _selectedDate!.year,
            _selectedDate!.month,
            _selectedDate!.day,
            int.parse(_selectedTimeSlot!.split(':')[0]),
            int.parse(_selectedTimeSlot!.split(':')[1]),
          )
        : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // Step Title
        const Text(
          'تأكيد الموعد',
          style: TextStyle(
            fontFamily: 'IBM Plex Sans Arabic',
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
          textAlign: TextAlign.right,
        ),

        const SizedBox(height: 8),

        const Text(
          'راجع تفاصيل الموعد قبل التأكيد',
          style: TextStyle(
            fontFamily: 'IBM Plex Sans Arabic',
            fontSize: 16,
            color: AppColors.homeSecondaryText,
          ),
          textAlign: TextAlign.right,
        ),

        const SizedBox(height: 32),

        // Appointment Summary
        Container(
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
          child: Column(
            children: [
              // Doctor Info
              Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      image: DecorationImage(
                        image: AssetImage(_doctorData['image']),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          _doctorData['name'],
                          style: const TextStyle(
                            fontFamily: 'IBM Plex Sans Arabic',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                          textAlign: TextAlign.right,
                        ),
                        Text(
                          _doctorData['specialty'],
                          style: const TextStyle(
                            fontFamily: 'IBM Plex Sans Arabic',
                            fontSize: 14,
                            color: AppColors.homeSecondaryText,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Appointment Details
              _buildDetailRow(
                  'التاريخ',
                  selectedDateTime != null
                      ? DateFormat('EEEE، d MMMM y', 'ar')
                          .format(selectedDateTime)
                      : 'غير محدد'),
              _buildDetailRow('الوقت', _selectedTimeSlot ?? 'غير محدد'),
              _buildDetailRow('النوع', _appointmentType),
              _buildDetailRow('السعر',
                  '${_doctorData['price']} ${_doctorData['currency']}'),

              if (_notes.isNotEmpty) ...[
                const SizedBox(height: 16),
                _buildDetailRow('الملاحظات', _notes),
              ],
            ],
          ),
        ),

        const SizedBox(height: 32),

        // Payment Notice
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.blue.withOpacity(0.3),
            ),
          ),
          child: const Row(
            children: [
              Icon(
                Icons.info,
                color: Colors.blue,
                size: 20,
              ),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'سيتم خصم المبلغ من طريقة الدفع الافتراضية الخاصة بك',
                  style: TextStyle(
                    fontFamily: 'IBM Plex Sans Arabic',
                    fontSize: 14,
                    color: Colors.blue,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
        ),
      ],
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

  Widget _buildBottomActions() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: [
          if (_currentStep > 0)
            Expanded(
              child: SecondaryButton(
                text: 'السابق',
                onPressed: _previousStep,
              ),
            ),
          if (_currentStep > 0) const SizedBox(width: 16),
          Expanded(
            flex: _currentStep > 0 ? 1 : 1,
            child: PrimaryButton(
              text: _getNextButtonText(),
              onPressed: _canProceed() ? _nextStep : null,
            ),
          ),
        ],
      ),
    );
  }

  String _getNextButtonText() {
    switch (_currentStep) {
      case 0:
        return 'التالي';
      case 1:
        return 'التأكيد';
      case 2:
        return 'حجز الموعد';
      default:
        return 'التالي';
    }
  }

  bool _canProceed() {
    switch (_currentStep) {
      case 0:
        return true; // Doctor is pre-selected
      case 1:
        return _selectedDate != null && _selectedTimeSlot != null;
      case 2:
        return true; // Confirmation step
      default:
        return false;
    }
  }

  void _nextStep() {
    if (_currentStep < 2) {
      setState(() => _currentStep++);
    } else {
      _confirmAppointment();
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
    }
  }

  void _confirmAppointment() async {
    // Validate required fields
    if (_selectedDate == null || _selectedTimeSlot == null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text(
            'خطأ في البيانات',
            style: TextStyle(
              fontFamily: 'IBM Plex Sans Arabic',
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.right,
          ),
          content: const Text(
            'يرجى اختيار التاريخ والوقت للموعد.',
            style: TextStyle(
              fontFamily: 'IBM Plex Sans Arabic',
            ),
            textAlign: TextAlign.right,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'موافق',
                style: TextStyle(
                  fontFamily: 'IBM Plex Sans Arabic',
                ),
              ),
            ),
          ],
        ),
      );
      return;
    }

    // Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 16),
            Text(
              'جاري الحجز...',
              style: TextStyle(
                fontFamily: 'IBM Plex Sans Arabic',
              ),
            ),
          ],
        ),
      ),
    );

    try {
      // TODO: Implement actual API call to book appointment
      // For now, simulate API call with delay
      await Future.delayed(const Duration(seconds: 2));

      // Close loading dialog
      Navigator.of(context).pop();

      // Show success dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: const Text(
            'تم الحجز بنجاح!',
            style: TextStyle(
              fontFamily: 'IBM Plex Sans Arabic',
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.right,
          ),
          content: Text(
            'تم حجز موعدك مع ${widget.doctorName ?? _doctorData['name']} في $_selectedTimeSlot يوم ${DateFormat('EEEE، d MMMM y', 'ar').format(_selectedDate!)}.\nستتلقى تذكير قبل الموعد بساعة.',
            style: const TextStyle(
              fontFamily: 'IBM Plex Sans Arabic',
            ),
            textAlign: TextAlign.right,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                context.go(RouteNames.home);
              },
              child: const Text(
                'موافق',
                style: TextStyle(
                  fontFamily: 'IBM Plex Sans Arabic',
                ),
              ),
            ),
          ],
        ),
      );
    } catch (e) {
      // Close loading dialog
      Navigator.of(context).pop();

      // Show error dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text(
            'خطأ في الحجز',
            style: TextStyle(
              fontFamily: 'IBM Plex Sans Arabic',
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.right,
          ),
          content: const Text(
            'حدث خطأ أثناء الحجز. يرجى المحاولة مرة أخرى.',
            style: TextStyle(
              fontFamily: 'IBM Plex Sans Arabic',
            ),
            textAlign: TextAlign.right,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'موافق',
                style: TextStyle(
                  fontFamily: 'IBM Plex Sans Arabic',
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

  IconData _getAppointmentTypeIcon(String type) {
    switch (type) {
      case 'مكالمة فيديو':
        return Icons.videocam;
      case 'مكالمة صوتية':
        return Icons.phone;
      case 'زيارة في العيادة':
        return Icons.location_on;
      default:
        return Icons.calendar_today;
    }
  }
}
