import 'package:flutter/material.dart';
import 'package:neurocare_app/core/constants/app_colors.dart';
import 'package:neurocare_app/features/profile/domain/entities/user_profile.dart';

class ProfileHeader extends StatelessWidget {
  final UserProfile profile;
  final VoidCallback? onEditPressed;

  const ProfileHeader({
    super.key,
    required this.profile,
    this.onEditPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Profile Image
          Stack(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: AppColors.primary,
                backgroundImage: profile.profileImageUrl != null
                    ? NetworkImage(profile.profileImageUrl!)
                    : null,
                child: profile.profileImageUrl == null
                    ? const Icon(
                        Icons.person,
                        size: 50,
                        color: Colors.white,
                      )
                    : null,
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: InkWell(
                  onTap: onEditPressed,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.edit,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Name
          Text(
            profile.fullName,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 8),

          // Email
          Text(
            profile.email,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.homeSecondaryText,
                ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 16),

          // Phone Number
          if (profile.phoneNumber != null) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.phone,
                  color: AppColors.primary,
                  size: 16,
                ),
                const SizedBox(width: 8),
                Text(
                  profile.phoneNumber!,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.homePrimaryText,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 8),
          ],

          // Address
          if (profile.address != null) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.location_on,
                  color: AppColors.primary,
                  size: 16,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    profile.address!,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.homePrimaryText,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
