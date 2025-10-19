import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:neurocare_app/core/constants/app_assets.dart';
import 'package:neurocare_app/core/constants/app_colors.dart';
import 'package:neurocare_app/shared/widgets/buttons/primary_button.dart';
import 'package:neurocare_app/shared/widgets/buttons/secondary_button.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  // Filter options
  String? selectedSpecialty;
  String? selectedLocation;
  double minRating = 0.0;
  RangeValues priceRange = const RangeValues(50, 300);
  List<String> selectedAppointmentTypes = [];
  bool availableToday = false;
  bool acceptsInsurance = false;
  String? selectedLanguage;
  String? selectedGender;
  String sortBy = 'rating';

  final List<String> specialties = [
    'أعصاب',
    'قلب',
    'باطنة',
    'نساء وتوليد',
    'أطفال',
    'جلدية',
    'عيون',
    'أنف وأذن وحنجرة',
    'أسنان',
    'جراحة',
    'طب نفسي',
    'تغذية',
  ];

  final List<String> locations = [
    'القاهرة',
    'الجيزة',
    'الإسكندرية',
    'المنصورة',
    'طنطا',
    'أسيوط',
    'سوهاج',
    'الأقصر',
  ];

  final List<String> appointmentTypes = [
    'مكالمة فيديو',
    'مكالمة صوتية',
    'زيارة في العيادة',
  ];

  final List<String> languages = [
    'العربية',
    'English',
    'Français',
  ];

  final List<String> genders = [
    'ذكر',
    'أنثى',
  ];

  final List<String> sortOptions = [
    'rating',
    'price_low',
    'price_high',
    'experience',
    'distance',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.onboardingBackground,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'تصفية البحث',
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
          TextButton(
            onPressed: _resetFilters,
            child: const Text(
              'إعادة تعيين',
              style: TextStyle(
                fontFamily: 'IBM Plex Sans Arabic',
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Specialty Filter
            _buildSectionHeader('التخصص'),
            _buildSpecialtyGrid(),

            const SizedBox(height: 24),

            // Location Filter
            _buildSectionHeader('الموقع'),
            _buildLocationDropdown(),

            const SizedBox(height: 24),

            // Rating Filter
            _buildSectionHeader('التقييم'),
            _buildRatingSlider(),

            const SizedBox(height: 24),

            // Price Range Filter
            _buildSectionHeader('نطاق السعر (جنيه)'),
            _buildPriceRangeSlider(),

            const SizedBox(height: 24),

            // Appointment Type Filter
            _buildSectionHeader('نوع الموعد'),
            _buildAppointmentTypeChips(),

            const SizedBox(height: 24),

            // Additional Filters
            _buildSectionHeader('خيارات إضافية'),
            _buildAdditionalFilters(),

            const SizedBox(height: 24),

            // Language Filter
            _buildSectionHeader('اللغة'),
            _buildLanguageChips(),

            const SizedBox(height: 24),

            // Gender Filter
            _buildSectionHeader('الجنس'),
            _buildGenderChips(),

            const SizedBox(height: 24),

            // Sort By
            _buildSectionHeader('ترتيب حسب'),
            _buildSortOptions(),

            const SizedBox(height: 40),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: SecondaryButton(
                    text: 'إلغاء',
                    onPressed: () => context.pop(),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: PrimaryButton(
                    text: 'تطبيق التصفية',
                    onPressed: _applyFilters,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontFamily: 'IBM Plex Sans Arabic',
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: AppColors.primary,
        ),
        textAlign: TextAlign.right,
      ),
    );
  }

  Widget _buildSpecialtyGrid() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        alignment: WrapAlignment.end,
        children: specialties.map((specialty) {
          final isSelected = selectedSpecialty == specialty;
          return InkWell(
            onTap: () {
              setState(() {
                selectedSpecialty = isSelected ? null : specialty;
              });
            },
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected ? AppColors.primary : Colors.grey.shade300,
                ),
              ),
              child: Text(
                specialty,
                style: TextStyle(
                  fontFamily: 'IBM Plex Sans Arabic',
                  fontSize: 14,
                  color: isSelected ? Colors.white : AppColors.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildLocationDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: DropdownButtonFormField<String>(
        initialValue: selectedLocation,
        hint: const Text(
          'اختر الموقع',
          style: TextStyle(
            fontFamily: 'IBM Plex Sans Arabic',
            color: AppColors.homeSecondaryText,
          ),
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 16),
        ),
        items: locations.map((location) {
          return DropdownMenuItem(
            value: location,
            alignment: Alignment.centerRight,
            child: Text(
              location,
              style: const TextStyle(
                fontFamily: 'IBM Plex Sans Arabic',
                color: AppColors.primary,
              ),
              textAlign: TextAlign.right,
            ),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            selectedLocation = value;
          });
        },
        icon: const Icon(
          Icons.keyboard_arrow_down,
          color: AppColors.primary,
        ),
        dropdownColor: Colors.white,
      ),
    );
  }

  Widget _buildRatingSlider() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${minRating.toStringAsFixed(1)} نجمة فما فوق',
                style: const TextStyle(
                  fontFamily: 'IBM Plex Sans Arabic',
                  fontSize: 14,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Row(
                children: List.generate(5, (index) {
                  return Icon(
                    index < minRating ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                    size: 16,
                  );
                }),
              ),
            ],
          ),
          Slider(
            value: minRating,
            min: 0,
            max: 5,
            divisions: 10,
            activeColor: AppColors.primary,
            inactiveColor: Colors.grey.shade300,
            onChanged: (value) {
              setState(() {
                minRating = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRangeSlider() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${priceRange.start.toInt()} - ${priceRange.end.toInt()} جنيه',
                style: const TextStyle(
                  fontFamily: 'IBM Plex Sans Arabic',
                  fontSize: 14,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          RangeSlider(
            values: priceRange,
            min: 0,
            max: 500,
            divisions: 50,
            activeColor: AppColors.primary,
            inactiveColor: Colors.grey.shade300,
            labels: RangeLabels(
              priceRange.start.toInt().toString(),
              priceRange.end.toInt().toString(),
            ),
            onChanged: (values) {
              setState(() {
                priceRange = values;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAppointmentTypeChips() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        alignment: WrapAlignment.end,
        children: appointmentTypes.map((type) {
          final isSelected = selectedAppointmentTypes.contains(type);
          return FilterChip(
            label: Text(
              type,
              style: TextStyle(
                fontFamily: 'IBM Plex Sans Arabic',
                fontSize: 14,
                color: isSelected ? Colors.white : AppColors.primary,
              ),
            ),
            selected: isSelected,
            onSelected: (selected) {
              setState(() {
                if (selected) {
                  selectedAppointmentTypes.add(type);
                } else {
                  selectedAppointmentTypes.remove(type);
                }
              });
            },
            backgroundColor: Colors.grey.shade100,
            selectedColor: AppColors.primary,
            checkmarkColor: Colors.white,
          );
        }).toList(),
      ),
    );
  }

  Widget _buildAdditionalFilters() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
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
          SwitchListTile(
            title: const Text(
              'متاح اليوم',
              style: TextStyle(
                fontFamily: 'IBM Plex Sans Arabic',
                fontSize: 16,
                color: AppColors.primary,
              ),
              textAlign: TextAlign.right,
            ),
            value: availableToday,
            onChanged: (value) {
              setState(() {
                availableToday = value;
              });
            },
            activeThumbColor: AppColors.primary,
          ),
          const Divider(),
          SwitchListTile(
            title: const Text(
              'يقبل التأمين الصحي',
              style: TextStyle(
                fontFamily: 'IBM Plex Sans Arabic',
                fontSize: 16,
                color: AppColors.primary,
              ),
              textAlign: TextAlign.right,
            ),
            value: acceptsInsurance,
            onChanged: (value) {
              setState(() {
                acceptsInsurance = value;
              });
            },
            activeThumbColor: AppColors.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageChips() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        alignment: WrapAlignment.end,
        children: languages.map((language) {
          final isSelected = selectedLanguage == language;
          return InkWell(
            onTap: () {
              setState(() {
                selectedLanguage = isSelected ? null : language;
              });
            },
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected ? AppColors.primary : Colors.grey.shade300,
                ),
              ),
              child: Text(
                language,
                style: TextStyle(
                  fontFamily: 'IBM Plex Sans Arabic',
                  fontSize: 14,
                  color: isSelected ? Colors.white : AppColors.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildGenderChips() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        alignment: WrapAlignment.end,
        children: genders.map((gender) {
          final isSelected = selectedGender == gender;
          return InkWell(
            onTap: () {
              setState(() {
                selectedGender = isSelected ? null : gender;
              });
            },
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected ? AppColors.primary : Colors.grey.shade300,
                ),
              ),
              child: Text(
                gender,
                style: TextStyle(
                  fontFamily: 'IBM Plex Sans Arabic',
                  fontSize: 14,
                  color: isSelected ? Colors.white : AppColors.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSortOptions() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
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
          _buildSortOption('التقييم', 'rating'),
          const Divider(),
          _buildSortOption('السعر (من الأقل للأعلى)', 'price_low'),
          const Divider(),
          _buildSortOption('السعر (من الأعلى للأقل)', 'price_high'),
          const Divider(),
          _buildSortOption('سنوات الخبرة', 'experience'),
          const Divider(),
          _buildSortOption('المسافة', 'distance'),
        ],
      ),
    );
  }

  Widget _buildSortOption(String label, String value) {
    final isSelected = sortBy == value;
    return InkWell(
      onTap: () {
        setState(() {
          sortBy = value;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (isSelected)
              const Icon(
                Icons.check,
                color: AppColors.primary,
                size: 20,
              ),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'IBM Plex Sans Arabic',
                fontSize: 16,
                color: isSelected
                    ? AppColors.primary
                    : AppColors.homeSecondaryText,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
              textAlign: TextAlign.right,
            ),
          ],
        ),
      ),
    );
  }

  void _resetFilters() {
    setState(() {
      selectedSpecialty = null;
      selectedLocation = null;
      minRating = 0.0;
      priceRange = const RangeValues(50, 300);
      selectedAppointmentTypes = [];
      availableToday = false;
      acceptsInsurance = false;
      selectedLanguage = null;
      selectedGender = null;
      sortBy = 'rating';
    });
  }

  void _applyFilters() {
    // Create filter object to pass back
    final filters = {
      'specialty': selectedSpecialty,
      'location': selectedLocation,
      'minRating': minRating,
      'priceRange': priceRange,
      'appointmentTypes': selectedAppointmentTypes,
      'availableToday': availableToday,
      'acceptsInsurance': acceptsInsurance,
      'language': selectedLanguage,
      'gender': selectedGender,
      'sortBy': sortBy,
    };

    context.pop(filters);
  }
}
