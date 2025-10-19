import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:neurocare_app/core/constants/app_assets.dart';
import 'package:neurocare_app/core/constants/app_colors.dart';
import 'package:neurocare_app/core/constants/app_strings.dart';
import 'package:neurocare_app/features/doctor/domain/entities/doctor.dart';
import 'package:neurocare_app/features/doctor/presentation/cubit/doctor_cubit.dart';

class DoctorProfileScreen extends StatefulWidget {
  const DoctorProfileScreen({super.key});

  @override
  State<DoctorProfileScreen> createState() => _DoctorProfileScreenState();
}

class _DoctorProfileScreenState extends State<DoctorProfileScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        context.read<DoctorCubit>().selectTab(_tabController.index);
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DoctorCubit, DoctorState>(
      listener: (context, state) {
        if (state is DoctorNavigation) {
          // Handle navigation
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Navigate to: ${state.route}')),
          );
        } else if (state is DoctorShared) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Doctor profile shared!')),
          );
        }
      },
      builder: (context, state) {
        if (state is DoctorLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is DoctorLoaded) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    expandedHeight: 400,
                    floating: false,
                    pinned: true,
                    backgroundColor: Colors.white,
                    elevation: 0,
                    leading: IconButton(
                      icon: SvgPicture.asset(AppAssets.arrowIcon),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    actions: [
                      IconButton(
                        icon: Icon(
                          state.isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: state.isFavorite ? Colors.red : Colors.grey,
                        ),
                        onPressed: () =>
                            context.read<DoctorCubit>().toggleFavorite(),
                      ),
                      IconButton(
                        icon: SvgPicture.asset(AppAssets.shareIcon),
                        onPressed: () =>
                            context.read<DoctorCubit>().shareDoctor(),
                      ),
                    ],
                    flexibleSpace: FlexibleSpaceBar(
                      background: _buildDoctorHeader(state.doctor),
                    ),
                  ),
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: _SliverAppBarDelegate(
                      TabBar(
                        controller: _tabController,
                        tabs: const [
                          Tab(text: 'عني'),
                          Tab(text: 'العنوان'),
                          Tab(text: 'التقييمات'),
                        ],
                        labelColor: AppColors.homePrimaryText,
                        unselectedLabelColor: AppColors.homeSecondaryText,
                        indicatorColor: AppColors.homeAccentBlue,
                      ),
                    ),
                  ),
                ];
              },
              body: TabBarView(
                controller: _tabController,
                children: [
                  _buildAboutTab(state.doctor),
                  _buildLocationTab(state.doctor),
                  _buildReviewsTab(state.doctor),
                ],
              ),
            ),
            bottomNavigationBar: _buildBottomBar(),
          );
        }

        return const Scaffold(
          body: Center(child: Text('Error loading doctor profile')),
        );
      },
    );
  }

  Widget _buildDoctorHeader(Doctor doctor) {
    return Container(
      padding: const EdgeInsets.only(top: 80, left: 20, right: 20),
      child: Column(
        children: [
          // Doctor Image
          Container(
            width: 110,
            height: 110,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(doctor.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Doctor Name and Specialty
          Text(
            doctor.name,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppColors.homePrimaryText,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            doctor.specialty,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.homeSecondaryText,
                ),
          ),
          const SizedBox(height: 16),

          // Stats Row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildStatItem('${doctor.rating}', 'التقييم'),
              Container(
                height: 40,
                width: 1,
                color: AppColors.homeDivider,
                margin: const EdgeInsets.symmetric(horizontal: 20),
              ),
              _buildStatItem('${doctor.experienceYears} سنوات', 'الخبرة'),
              Container(
                height: 40,
                width: 1,
                color: AppColors.homeDivider,
                margin: const EdgeInsets.symmetric(horizontal: 20),
              ),
              _buildStatItem('${doctor.patientCount}+', 'المرضى'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.homePrimaryText,
                fontWeight: FontWeight.bold,
              ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.homeSecondaryText,
              ),
        ),
      ],
    );
  }

  Widget _buildAboutTab(Doctor doctor) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'نبذة عن الطبيب',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.homePrimaryText,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          Text(
            doctor.bio,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.homeSecondaryText,
                  height: 1.6,
                ),
          ),
          const SizedBox(height: 24),

          // Specializations
          Text(
            'التخصصات',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.homePrimaryText,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: doctor.specializations.map((spec) {
              return Chip(
                label: Text(spec),
                backgroundColor: AppColors.homeAccentBlue.withOpacity(0.1),
                labelStyle: const TextStyle(color: AppColors.homeAccentBlue),
              );
            }).toList(),
          ),

          const SizedBox(height: 24),

          // Languages
          Text(
            'اللغات',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.homePrimaryText,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: doctor.languages.map((lang) {
              return Chip(
                label: Text(lang),
                backgroundColor: Colors.grey.withOpacity(0.1),
                labelStyle: const TextStyle(color: AppColors.homeSecondaryText),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationTab(Doctor doctor) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'موقع العيادة',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.homePrimaryText,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: Text('خريطة الموقع'),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            doctor.location,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.homeSecondaryText,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewsTab(Doctor doctor) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                '${doctor.rating}',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: AppColors.homePrimaryText,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: List.generate(5, (index) {
                      return Icon(
                        index < doctor.rating.floor()
                            ? Icons.star
                            : Icons.star_border,
                        color: Colors.amber,
                        size: 20,
                      );
                    }),
                  ),
                  Text(
                    '${doctor.reviewCount} مراجعة',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.homeSecondaryText,
                        ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Rating breakdown (placeholder)
          _buildRatingBreakdown(),

          const SizedBox(height: 24),

          // Sample reviews (placeholder)
          _buildSampleReviews(),
        ],
      ),
    );
  }

  Widget _buildRatingBreakdown() {
    return Column(
      children: [
        _buildRatingRow(5, 85),
        _buildRatingRow(4, 10),
        _buildRatingRow(3, 3),
        _buildRatingRow(2, 1),
        _buildRatingRow(1, 1),
      ],
    );
  }

  Widget _buildRatingRow(int stars, int percentage) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text('$stars نجمة'),
          const SizedBox(width: 12),
          Expanded(
            child: LinearProgressIndicator(
              value: percentage / 100,
              backgroundColor: Colors.grey.withOpacity(0.2),
              valueColor:
                  const AlwaysStoppedAnimation<Color>(AppColors.homeAccentBlue),
            ),
          ),
          const SizedBox(width: 12),
          Text('$percentage%'),
        ],
      ),
    );
  }

  Widget _buildSampleReviews() {
    return Column(
      children: [
        _buildReviewItem(),
        _buildReviewItem(),
        _buildReviewItem(),
      ],
    );
  }

  Widget _buildReviewItem() {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 16,
                child: Text('م'),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'محمد أحمد',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Row(
                      children: List.generate(5, (index) {
                        return const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 14,
                        );
                      }),
                    ),
                  ],
                ),
              ),
              Text(
                'منذ يومين',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.homeSecondaryText,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'خدمة ممتازة وتشخيص دقيق. الطبيب محترف ويعطي شرح مفصل عن الحالة.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.homeSecondaryText,
                  height: 1.5,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.homeAccentBlue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(11),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(AppAssets.arrowIcon, width: 16, height: 16),
                  const SizedBox(width: 8),
                  Text(
                    AppStrings.appointments,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppColors.homeAccentBlue,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: () => context.read<DoctorCubit>().chatWithDoctor(),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.homeAccentBlue,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(11),
                ),
                elevation: 0,
              ),
              child: Text(
                'المحادثة مع الطبيب',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;

  _SliverAppBarDelegate(this.tabBar);

  @override
  double get minExtent => tabBar.preferredSize.height;
  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
