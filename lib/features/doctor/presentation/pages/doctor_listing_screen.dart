import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:neurocare_app/core/constants/app_assets.dart';
import 'package:neurocare_app/core/constants/app_colors.dart';
import 'package:neurocare_app/core/constants/app_strings.dart';
import 'package:neurocare_app/features/doctor/domain/entities/doctor.dart';
import 'package:neurocare_app/features/doctor/presentation/cubit/doctor_cubit.dart';
import 'package:neurocare_app/features/doctor/presentation/cubit/doctor_listing_cubit.dart';
import 'package:neurocare_app/features/doctor/presentation/pages/doctor_profile_screen.dart';

class DoctorListingScreen extends StatefulWidget {
  const DoctorListingScreen({super.key});

  @override
  State<DoctorListingScreen> createState() => _DoctorListingScreenState();
}

class _DoctorListingScreenState extends State<DoctorListingScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<DoctorListingCubit>().loadDoctors();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.homeBackground,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset(AppAssets.arrowIcon),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          AppStrings.doctors,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppColors.homePrimaryText,
                fontWeight: FontWeight.bold,
              ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.homeCardBackground,
                borderRadius: BorderRadius.circular(25),
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: AppStrings.searchDoctor,
                  hintStyle:
                      const TextStyle(color: AppColors.homeSecondaryText),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(12),
                    child: SvgPicture.asset(AppAssets.searchIcon,
                        width: 20, height: 20),
                  ),
                  border: InputBorder.none,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                ),
                onChanged: (value) {
                  context.read<DoctorListingCubit>().searchDoctors(value);
                },
              ),
            ),
          ),

          // Filters
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                _buildFilterChip(AppStrings.all, true),
                const SizedBox(width: 12),
                _buildFilterChip(AppStrings.cardiology, false),
                const SizedBox(width: 12),
                _buildFilterChip(AppStrings.neurology, false),
                const SizedBox(width: 12),
                _buildFilterChip(AppStrings.dentistry, false),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Doctor List
          Expanded(
            child: BlocBuilder<DoctorListingCubit, DoctorListingState>(
              builder: (context, state) {
                if (state is DoctorListingLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is DoctorListingLoaded) {
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: state.doctors.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: DoctorListingCard(
                          doctor: state.doctors[index],
                          onTap: () =>
                              _navigateToDoctorProfile(state.doctors[index]),
                        ),
                      );
                    },
                  );
                }

                if (state is DoctorListingError) {
                  return Center(
                    child: Text(
                      'خطأ في تحميل قائمة الأطباء',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: AppColors.error,
                          ),
                    ),
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.homeAccentBlue : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected ? AppColors.homeAccentBlue : AppColors.homeDivider,
          width: 1,
        ),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: isSelected ? Colors.white : AppColors.homeSecondaryText,
              fontWeight: FontWeight.w500,
            ),
      ),
    );
  }

  void _navigateToDoctorProfile(Doctor doctor) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) => DoctorCubit()..loadDoctor(doctor.id),
          child: const DoctorProfileScreen(),
        ),
      ),
    );
  }
}

class DoctorListingCard extends StatelessWidget {
  final Doctor doctor;
  final VoidCallback onTap;

  const DoctorListingCard({
    super.key,
    required this.doctor,
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
        child: Row(
          children: [
            // Doctor Image
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(doctor.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(width: 16),

            // Doctor Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doctor.name,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppColors.homePrimaryText,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    doctor.specialty,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.homeSecondaryText,
                        ),
                  ),
                  const SizedBox(height: 8),

                  // Rating and Reviews
                  Row(
                    children: [
                      SvgPicture.asset(AppAssets.starIcon,
                          width: 14, height: 14),
                      const SizedBox(width: 4),
                      Text(
                        '${doctor.rating}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.homePrimaryText,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      Text(
                        ' (${doctor.reviewCount} تقييم)',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.homeSecondaryText,
                            ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // Location
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        size: 16,
                        color: AppColors.homeSecondaryText,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          doctor.location,
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: AppColors.homeSecondaryText,
                                  ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Price and Arrow
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${doctor.price} ${doctor.priceUnit}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.homeAccentBlue,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  doctor.priceDescription,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.homeSecondaryText,
                      ),
                ),
                const SizedBox(height: 8),
                SvgPicture.asset(
                  AppAssets.arrowIcon,
                  width: 20,
                  height: 16,
                  colorFilter: const ColorFilter.mode(
                    AppColors.homeAccentBlue,
                    BlendMode.srcIn,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
