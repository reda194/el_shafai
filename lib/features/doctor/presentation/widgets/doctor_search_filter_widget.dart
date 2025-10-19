import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neurocare_app/core/constants/app_colors.dart';
import 'package:neurocare_app/core/constants/app_dimensions.dart';
import 'package:neurocare_app/core/constants/app_text_styles.dart';
import 'package:neurocare_app/features/doctor/presentation/cubit/doctor_search_cubit.dart';

class DoctorSearchFilterWidget extends StatefulWidget {
  const DoctorSearchFilterWidget({super.key});

  @override
  State<DoctorSearchFilterWidget> createState() =>
      _DoctorSearchFilterWidgetState();
}

class _DoctorSearchFilterWidgetState extends State<DoctorSearchFilterWidget> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedSpecialty = 'الكل';
  String _sortBy = 'التقييم';
  bool _isAvailableNow = false;
  RangeValues _priceRange = const RangeValues(0, 500);

  final List<String> _specialties = [
    'الكل',
    'أخصائي قلب',
    'أخصائي أعصاب',
    'أخصائي باطنة',
    'أخصائي أطفال',
    'أخصائية نساء وتوليد',
    'أخصائي عظام',
    'أخصائي جلدية',
    'أخصائي نفسي',
    'أخصائي أنف وأذن',
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.homeCardBackground,
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.spacingLg),
        child: Column(
          children: [
            // Search Bar
            _buildSearchBar(),
            const SizedBox(height: AppDimensions.spacingLg),

            // Filter Options
            ExpansionTile(
              title: Text(
                'خيارات البحث المتقدمة',
                style: AppTextStyles.titleMedium.copyWith(
                  color: AppColors.homePrimaryText,
                ),
              ),
              tilePadding: EdgeInsets.zero,
              children: [
                const SizedBox(height: AppDimensions.spacingMd),

                // Specialty Filter
                _buildSpecialtyFilter(),
                const SizedBox(height: AppDimensions.spacingMd),

                // Sort Options
                _buildSortOptions(),
                const SizedBox(height: AppDimensions.spacingMd),

                // Availability Filter
                _buildAvailabilityFilter(),
                const SizedBox(height: AppDimensions.spacingMd),

                // Price Range Filter
                _buildPriceRangeFilter(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      controller: _searchController,
      textAlign: TextAlign.right,
      decoration: InputDecoration(
        hintText: 'ابحث عن اسم طبيب أو تخصص',
        hintStyle: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.homeTertiaryText,
        ),
        suffixIcon: const Padding(
          padding: EdgeInsetsDirectional.only(
            end: AppDimensions.spacingMd,
          ),
          child: Icon(
            Icons.search,
            color: AppColors.homeTertiaryText,
          ),
        ),
        prefixIcon: const Padding(
          padding: EdgeInsetsDirectional.only(
            start: AppDimensions.spacingMd,
          ),
          child: Icon(
            Icons.mic,
            color: AppColors.homeAccentBlue,
          ),
        ),
        filled: true,
        fillColor: AppColors.homeCardBackground,
        contentPadding: const EdgeInsetsDirectional.symmetric(
          horizontal: AppDimensions.spacingMd,
          vertical: AppDimensions.spacingMd,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
          borderSide: const BorderSide(
            color: AppColors.homeDivider,
            width: 1.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
          borderSide: const BorderSide(
            color: AppColors.homeDivider,
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
          borderSide: const BorderSide(
            color: AppColors.homeAccentBlue,
            width: 2.0,
          ),
        ),
      ),
      style: AppTextStyles.bodyMedium.copyWith(
        color: AppColors.homePrimaryText,
      ),
      onChanged: (value) {
        // Trigger search
        context.read<DoctorSearchCubit>().searchDoctors(
              query: value,
              specialty: _selectedSpecialty,
              sortBy: _sortBy,
              availableNow: _isAvailableNow,
              priceRange: _priceRange,
            );
      },
    );
  }

  Widget _buildSpecialtyFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          'التخصص',
          style: AppTextStyles.titleSmall.copyWith(
            color: AppColors.homePrimaryText,
          ),
        ),
        const SizedBox(height: AppDimensions.spacingSm),
        SizedBox(
          height: 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _specialties.length,
            itemBuilder: (context, index) {
              final specialty = _specialties[index];
              final isSelected = specialty == _selectedSpecialty;

              return Padding(
                padding: const EdgeInsetsDirectional.only(
                    end: AppDimensions.spacingSm),
                child: FilterChip(
                  label: Text(specialty),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      _selectedSpecialty = specialty;
                    });
                    // Trigger search with new specialty
                    context.read<DoctorSearchCubit>().searchDoctors(
                          query: _searchController.text,
                          specialty: _selectedSpecialty,
                          sortBy: _sortBy,
                          availableNow: _isAvailableNow,
                          priceRange: _priceRange,
                        );
                  },
                  backgroundColor: AppColors.homeCardBackground,
                  selectedColor: AppColors.homeAccentBlue,
                  checkmarkColor: Colors.white,
                  side: BorderSide(
                    color:
                        isSelected ? Colors.transparent : AppColors.homeDivider,
                    width: 1.0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
                  ),
                  labelStyle: AppTextStyles.labelMedium.copyWith(
                    color:
                        isSelected ? Colors.white : AppColors.homePrimaryText,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSortOptions() {
    final sortOptions = [
      {'value': 'التقييم', 'label': 'الأعلى تقييمًا'},
      {'value': 'الخبرة', 'label': 'الأكثر خبرة'},
      {'value': 'السعر', 'label': 'الأقل سعرًا'},
      {'value': 'المسافة', 'label': 'الأقرب مسافة'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          'ترتيب حسب',
          style: AppTextStyles.titleSmall.copyWith(
            color: AppColors.homePrimaryText,
          ),
        ),
        const SizedBox(height: AppDimensions.spacingSm),
        DropdownButtonFormField<String>(
          initialValue: _sortBy,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.homeCardBackground,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
              borderSide: const BorderSide(color: AppColors.homeDivider),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
              borderSide: const BorderSide(color: AppColors.homeDivider),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
              borderSide: const BorderSide(color: AppColors.homeAccentBlue),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.spacingMd,
              vertical: AppDimensions.spacingMd,
            ),
          ),
          items: sortOptions.map((option) {
            return DropdownMenuItem<String>(
              value: option['value'] as String,
              child: Text(
                option['label'] as String,
                style: AppTextStyles.bodyMedium,
                textAlign: TextAlign.right,
              ),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              setState(() {
                _sortBy = value;
              });
              // Trigger search with new sort option
              context.read<DoctorSearchCubit>().searchDoctors(
                    query: _searchController.text,
                    specialty: _selectedSpecialty,
                    sortBy: _sortBy,
                    availableNow: _isAvailableNow,
                    priceRange: _priceRange,
                  );
            }
          },
        ),
      ],
    );
  }

  Widget _buildAvailabilityFilter() {
    return CheckboxListTile(
      title: Text(
        'متاحد الآن',
        style: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.homePrimaryText,
        ),
      ),
      value: _isAvailableNow,
      onChanged: (value) {
        setState(() {
          _isAvailableNow = value ?? false;
        });
        // Trigger search with availability filter
        context.read<DoctorSearchCubit>().searchDoctors(
              query: _searchController.text,
              specialty: _selectedSpecialty,
              sortBy: _sortBy,
              availableNow: _isAvailableNow,
              priceRange: _priceRange,
            );
      },
      activeColor: AppColors.homeAccentBlue,
      controlAffinity: ListTileControlAffinity.leading,
      contentPadding: EdgeInsets.zero,
    );
  }

  Widget _buildPriceRangeFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          'نطاق السعر: ${_priceRange.start.toInt()} - ${_priceRange.end.toInt()} ريال',
          style: AppTextStyles.titleSmall.copyWith(
            color: AppColors.homePrimaryText,
          ),
        ),
        const SizedBox(height: AppDimensions.spacingMd),
        RangeSlider(
          values: _priceRange,
          min: 0,
          max: 500,
          divisions: 10,
          labels: RangeLabels(
            '${_priceRange.start.toInt()}',
            '${_priceRange.end.toInt()}',
          ),
          onChanged: (values) {
            setState(() {
              _priceRange = values;
            });
            // Trigger search with new price range
            context.read<DoctorSearchCubit>().searchDoctors(
                  query: _searchController.text,
                  specialty: _selectedSpecialty,
                  sortBy: _sortBy,
                  availableNow: _isAvailableNow,
                  priceRange: _priceRange,
                );
          },
          activeColor: AppColors.homeAccentBlue,
          inactiveColor: AppColors.homeDivider,
        ),
      ],
    );
  }
}
