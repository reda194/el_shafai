import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:neurocare_app/config/dependency_injection.dart';
import 'package:neurocare_app/core/constants/app_colors.dart';
import 'package:neurocare_app/core/constants/app_strings.dart';
import 'package:neurocare_app/core/routes/route_names.dart';
import 'package:neurocare_app/features/profile/domain/usecases/get_user_profile_usecase.dart';
import 'package:neurocare_app/features/profile/domain/usecases/update_user_profile_usecase.dart';
import 'package:neurocare_app/features/profile/domain/usecases/upload_profile_image_usecase.dart';
import 'package:neurocare_app/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:neurocare_app/features/profile/presentation/widgets/profile_header.dart';
import 'package:neurocare_app/features/profile/presentation/widgets/settings_section.dart';
import 'package:neurocare_app/shared/widgets/common/bottom_nav_bar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc(
        getUserProfile: GetUserProfileUseCase(getIt()),
        updateUserProfile: UpdateUserProfileUseCase(getIt()),
        uploadProfileImage: UploadProfileImageUseCase(getIt()),
      )..add(LoadUserProfile()),
      child: Scaffold(
        backgroundColor: AppColors.onboardingBackground,
        appBar: AppBar(
          backgroundColor: AppColors.onboardingBackground,
          elevation: 0,
          title: Text(
            AppStrings.profile,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.edit, color: AppColors.primary),
              onPressed: () => context.go(RouteNames.editProfile),
            ),
          ],
        ),
        body: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProfileLoaded) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    ProfileHeader(
                      profile: state.profile,
                      onEditPressed: () =>
                          _navigateToEditProfile(context, state),
                    ),
                    const SizedBox(height: 24),
                    const SettingsSection(),
                    const SizedBox(height: 100), // Space for bottom navigation
                  ],
                ),
              );
            } else if (state is ProfileError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(state.message),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () =>
                          context.read<ProfileBloc>().add(LoadUserProfile()),
                      child: const Text('إعادة المحاولة'),
                    ),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
        bottomNavigationBar: const BottomNavBar(currentIndex: 4),
      ),
    );
  }

  void _navigateToEditProfile(BuildContext context, state) {
    if (state is ProfileLoaded) {
      context.push(
        RouteNames.editProfile,
        extra: state.profile,
      );
    }
  }
}
