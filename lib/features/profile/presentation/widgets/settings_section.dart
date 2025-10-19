import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:neurocare_app/core/constants/app_colors.dart';
import 'package:neurocare_app/core/constants/app_strings.dart';
import 'package:neurocare_app/core/routes/route_names.dart';

class SettingsSection extends StatelessWidget {
  const SettingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildSettingsItem(
            context,
            icon: Icons.person,
            title: AppStrings.personalInfo,
            onTap: () => _navigateToPersonalInfo(context),
          ),
          _buildDivider(),
          _buildSettingsItem(
            context,
            icon: Icons.settings,
            title: AppStrings.accountSettings,
            onTap: () => _navigateToAccountSettings(context),
          ),
          _buildDivider(),
          _buildSettingsItem(
            context,
            icon: Icons.notifications,
            title: AppStrings.notificationsSettings,
            onTap: () => _navigateToNotificationsSettings(context),
          ),
          _buildDivider(),
          _buildSettingsItem(
            context,
            icon: Icons.language,
            title: AppStrings.language,
            trailing: const Text('العربية'),
            onTap: () => _showLanguageDialog(context),
          ),
          _buildDivider(),
          _buildSettingsItem(
            context,
            icon: Icons.privacy_tip,
            title: AppStrings.privacyPolicy,
            onTap: () => _navigateToPrivacyPolicy(context),
          ),
          _buildDivider(),
          _buildSettingsItem(
            context,
            icon: Icons.help,
            title: AppStrings.helpSupport,
            onTap: () => _navigateToHelpSupport(context),
          ),
          _buildDivider(),
          _buildSettingsItem(
            context,
            icon: Icons.logout,
            title: AppStrings.signOut,
            textColor: AppColors.error,
            onTap: () => _showSignOutDialog(context),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    Widget? trailing,
    Color? textColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            Icon(
              icon,
              color: textColor ?? AppColors.primary,
              size: 24,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: textColor ?? AppColors.homePrimaryText,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
            if (trailing != null) trailing,
            const Icon(
              Icons.arrow_forward_ios,
              color: AppColors.homeSecondaryText,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(
      color: AppColors.border,
      height: 1,
      thickness: 1,
    );
  }

  void _navigateToPersonalInfo(BuildContext context) {
    // TODO: Navigate to personal info screen
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('المعلومات الشخصية - قريباً')),
    );
  }

  void _navigateToAccountSettings(BuildContext context) {
    context.go(RouteNames.settings);
  }

  void _navigateToNotificationsSettings(BuildContext context) {
    context.go(RouteNames.settings);
  }

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(AppStrings.language),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('العربية'),
                leading: Radio<String>(
                  value: 'ar',
                  groupValue: 'ar',
                  onChanged: (value) {},
                ),
              ),
              ListTile(
                title: const Text('English'),
                leading: Radio<String>(
                  value: 'en',
                  groupValue: 'ar',
                  onChanged: (value) {},
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(AppStrings.cancel),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(AppStrings.save),
            ),
          ],
        );
      },
    );
  }

  void _navigateToPrivacyPolicy(BuildContext context) {
    // TODO: Navigate to privacy policy screen
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('سياسة الخصوصية - قريباً')),
    );
  }

  void _navigateToHelpSupport(BuildContext context) {
    context.go(RouteNames.settings);
  }

  void _showSignOutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(AppStrings.signOut),
          content: const Text('هل أنت متأكد من تسجيل الخروج؟'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(AppStrings.cancel),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.error,
              ),
              onPressed: () {
                Navigator.of(context).pop();
                // Navigate to login screen
                context.go(RouteNames.login);
              },
              child: const Text(AppStrings.signOut),
            ),
          ],
        );
      },
    );
  }
}
