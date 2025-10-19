import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:neurocare_app/core/constants/app_assets.dart';
import 'package:neurocare_app/core/constants/app_colors.dart';
import 'package:neurocare_app/core/localization/localization_extension.dart';
import 'package:neurocare_app/core/providers/language_provider.dart';
import 'package:neurocare_app/core/routes/route_names.dart';
import 'package:neurocare_app/shared/widgets/common/bottom_nav_bar.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _locationServicesEnabled = true;
  bool _biometricEnabled = false;
  bool _darkModeEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.onboardingBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'الإعدادات',
          style: TextStyle(
            fontFamily: 'IBM Plex Sans Arabic',
            fontWeight: FontWeight.bold,
            fontSize: 24,
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
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Account Section
            _buildSectionTitle('الحساب'),
            const SizedBox(height: 12),
            _buildSettingsCard(
              children: [
                _buildSettingsItem(
                  icon: Icons.person_outline,
                  title: 'الملف الشخصي',
                  subtitle: 'تحديث معلوماتك الشخصية',
                  onTap: () => context.go(RouteNames.editProfile),
                ),
                const Divider(height: 1),
                _buildSettingsItem(
                  icon: Icons.lock_outline,
                  title: 'كلمة المرور',
                  subtitle: 'تغيير كلمة المرور',
                  onTap: () => context.go(RouteNames.resetPassword),
                ),
                const Divider(height: 1),
                _buildSettingsItem(
                  icon: Icons.payment_outlined,
                  title: 'الدفع',
                  subtitle: 'إدارة طرق الدفع',
                  onTap: () => context.go(RouteNames.paymentMethods),
                ),
              ],
            ),

            const SizedBox(height: 32),

            // Preferences Section
            _buildSectionTitle('التفضيلات'),
            const SizedBox(height: 12),
            _buildSettingsCard(
              children: [
                _buildSwitchItem(
                  icon: Icons.notifications_outlined,
                  title: 'الإشعارات',
                  subtitle: 'تفعيل وإلغاء تفعيل الإشعارات',
                  value: _notificationsEnabled,
                  onChanged: (value) =>
                      setState(() => _notificationsEnabled = value),
                ),
                const Divider(height: 1),
                _buildSwitchItem(
                  icon: Icons.location_on_outlined,
                  title: 'خدمات الموقع',
                  subtitle: 'السماح بالوصول إلى الموقع',
                  value: _locationServicesEnabled,
                  onChanged: (value) =>
                      setState(() => _locationServicesEnabled = value),
                ),
                const Divider(height: 1),
                _buildSwitchItem(
                  icon: Icons.fingerprint,
                  title: 'البصمة والتعرف',
                  subtitle: 'تسجيل الدخول بالبصمة',
                  value: _biometricEnabled,
                  onChanged: (value) =>
                      setState(() => _biometricEnabled = value),
                ),
                const Divider(height: 1),
                _buildSwitchItem(
                  icon: Icons.dark_mode_outlined,
                  title: 'الوضع المظلم',
                  subtitle: 'تبديل بين الوضع الفاتح والمظلم',
                  value: _darkModeEnabled,
                  onChanged: (value) =>
                      setState(() => _darkModeEnabled = value),
                ),
                const Divider(height: 1),
                _buildLanguageSelector(),
              ],
            ),

            const SizedBox(height: 32),

            // Support Section
            _buildSectionTitle('المساعدة والدعم'),
            const SizedBox(height: 12),
            _buildSettingsCard(
              children: [
                _buildSettingsItem(
                  icon: Icons.help_outline,
                  title: 'الأسئلة الشائعة',
                  subtitle: 'الحصول على إجابات للأسئلة الشائعة',
                  onTap: () => _showFAQ(),
                ),
                const Divider(height: 1),
                _buildSettingsItem(
                  icon: Icons.contact_support_outlined,
                  title: 'تواصل معنا',
                  subtitle: 'إرسال رسالة أو الاتصال بالدعم',
                  onTap: () => _showContactSupport(),
                ),
                const Divider(height: 1),
                _buildSettingsItem(
                  icon: Icons.report_problem_outlined,
                  title: 'الإبلاغ عن مشكلة',
                  subtitle: 'إبلاغ عن خطأ أو مشكلة تقنية',
                  onTap: () => _showReportIssue(),
                ),
              ],
            ),

            const SizedBox(height: 32),

            // Legal Section
            _buildSectionTitle('القانونية'),
            const SizedBox(height: 12),
            _buildSettingsCard(
              children: [
                _buildSettingsItem(
                  icon: Icons.privacy_tip_outlined,
                  title: 'سياسة الخصوصية',
                  subtitle: 'قراءة سياسة الخصوصية والأمان',
                  onTap: () => _showPrivacyPolicy(),
                ),
                const Divider(height: 1),
                _buildSettingsItem(
                  icon: Icons.description_outlined,
                  title: 'الشروط والأحكام',
                  subtitle: 'قراءة شروط استخدام التطبيق',
                  onTap: () => _showTermsAndConditions(),
                ),
                const Divider(height: 1),
                _buildSettingsItem(
                  icon: Icons.info_outline,
                  title: 'حول التطبيق',
                  subtitle: 'معلومات عن التطبيق والإصدار',
                  onTap: () => _showAbout(),
                ),
              ],
            ),

            const SizedBox(height: 32),

            // Logout Button
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    offset: const Offset(0, 2),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _showLogoutDialog,
                      icon: const Icon(
                        Icons.logout,
                        color: Colors.red,
                      ),
                      label: const Text(
                        'تسجيل الخروج',
                        style: TextStyle(
                          fontFamily: 'IBM Plex Sans Arabic',
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.withOpacity(0.1),
                        foregroundColor: Colors.red,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'الإصدار 1.0.0',
                    style: TextStyle(
                      fontFamily: 'IBM Plex Sans Arabic',
                      fontSize: 12,
                      color: AppColors.homeSecondaryText,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 100), // Space for bottom navigation
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 4),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontFamily: 'IBM Plex Sans Arabic',
        fontWeight: FontWeight.bold,
        fontSize: 18,
        color: AppColors.primary,
      ),
      textAlign: TextAlign.right,
    );
  }

  Widget _buildSettingsCard({required List<Widget> children}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 2),
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        children: children,
      ),
    );
  }

  Widget _buildSettingsItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                color: AppColors.primary,
                size: 20,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontFamily: 'IBM Plex Sans Arabic',
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: AppColors.primary,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
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
            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: AppColors.homeSecondaryText,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: AppColors.primary,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'IBM Plex Sans Arabic',
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: AppColors.primary,
                  ),
                  textAlign: TextAlign.right,
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
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
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: AppColors.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageSelector() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.language,
              color: AppColors.primary,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  context.language,
                  style: const TextStyle(
                    fontFamily: 'IBM Plex Sans Arabic',
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: AppColors.primary,
                  ),
                  textAlign: TextAlign.right,
                ),
                const SizedBox(height: 4),
                const Text(
                  'اختر لغة التطبيق',
                  style: TextStyle(
                    fontFamily: 'IBM Plex Sans Arabic',
                    fontSize: 14,
                    color: AppColors.homeSecondaryText,
                  ),
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          ),
          Consumer(
            builder: (context, ref, child) {
              final languageNotifier = ref.watch(languageProvider.notifier);
              final currentLocale = ref.watch(languageProvider);

              return DropdownButton<String>(
                value: currentLocale.languageCode,
                onChanged: (value) {
                  if (value != null) {
                    languageNotifier.setLanguage(value);
                    _showLanguageChangeDialog(value);
                  }
                },
                items: const [
                  DropdownMenuItem(
                    value: 'ar',
                    child: Text('العربية'),
                  ),
                  DropdownMenuItem(
                    value: 'en',
                    child: Text('English'),
                  ),
                ],
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: AppColors.primary,
                ),
                underline: const SizedBox(),
              );
            },
          ),
        ],
      ),
    );
  }

  void _showFAQ() {
    // Navigate to FAQ screen
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('سيتم توجيهك إلى صفحة الأسئلة الشائعة')),
    );
  }

  void _showContactSupport() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'تواصل مع الدعم',
          style: TextStyle(
            fontFamily: 'IBM Plex Sans Arabic',
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.right,
        ),
        content: const Text(
          'هل تريد الاتصال بالدعم الفني أو إرسال رسالة؟',
          style: TextStyle(
            fontFamily: 'IBM Plex Sans Arabic',
          ),
          textAlign: TextAlign.right,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'إلغاء',
              style: TextStyle(
                fontFamily: 'IBM Plex Sans Arabic',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              // Open support chat or call
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
            ),
            child: const Text(
              'اتصال',
              style: TextStyle(
                fontFamily: 'IBM Plex Sans Arabic',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showReportIssue() {
    // Navigate to report issue screen
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('سيتم توجيهك إلى صفحة الإبلاغ عن مشكلة')),
    );
  }

  void _showPrivacyPolicy() {
    // Navigate to privacy policy screen
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('سيتم توجيهك إلى سياسة الخصوصية')),
    );
  }

  void _showTermsAndConditions() {
    // Navigate to terms and conditions screen
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('سيتم توجيهك إلى الشروط والأحكام')),
    );
  }

  void _showAbout() {
    showAboutDialog(
      context: context,
      applicationName: context.appName,
      applicationVersion: '1.0.0',
      applicationLegalese: '© 2024 NeuroCare. جميع الحقوق محفوظة.',
    );
  }

  void _showLanguageChangeDialog(String language) {
    final languageName = language == 'ar' ? context.arabic : context.english;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'تغيير اللغة',
          style: TextStyle(
            fontFamily: 'IBM Plex Sans Arabic',
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.right,
        ),
        content: Text(
          'هل تريد تغيير لغة التطبيق إلى $languageName؟',
          style: const TextStyle(
            fontFamily: 'IBM Plex Sans Arabic',
          ),
          textAlign: TextAlign.right,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              context.cancel,
              style: const TextStyle(
                fontFamily: 'IBM Plex Sans Arabic',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              // Restart app or navigate to reload language
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(
                        'تم تغيير اللغة إلى $languageName. أعد تشغيل التطبيق لرؤية التغييرات')),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
            ),
            child: Text(
              context.confirm,
              style: const TextStyle(
                fontFamily: 'IBM Plex Sans Arabic',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'تسجيل الخروج',
          style: TextStyle(
            fontFamily: 'IBM Plex Sans Arabic',
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.right,
        ),
        content: const Text(
          'هل أنت متأكد من أنك تريد تسجيل الخروج؟',
          style: TextStyle(
            fontFamily: 'IBM Plex Sans Arabic',
          ),
          textAlign: TextAlign.right,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'إلغاء',
              style: TextStyle(
                fontFamily: 'IBM Plex Sans Arabic',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              // Logout logic here
              context.go(RouteNames.login);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text(
              'تسجيل الخروج',
              style: TextStyle(
                fontFamily: 'IBM Plex Sans Arabic',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
