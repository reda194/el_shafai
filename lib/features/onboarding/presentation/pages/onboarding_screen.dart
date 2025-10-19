import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:neurocare_app/core/constants/app_assets.dart';
import 'package:neurocare_app/core/constants/app_colors.dart';
import 'package:neurocare_app/core/constants/storage_keys.dart';
import 'package:neurocare_app/core/routes/route_names.dart';
import 'package:neurocare_app/core/services/storage_service.dart';
import 'package:neurocare_app/features/onboarding/presentation/widgets/onboarding_page.dart';
import 'package:neurocare_app/features/onboarding/presentation/widgets/page_indicator.dart';
import 'package:neurocare_app/shared/widgets/buttons/primary_button.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  final _storageService = StorageService();
  int _currentPage = 0;

  final List<Map<String, String>> _onboardingData = [
    {
      'title': 'مرحباً بك في شفائي',
      'subtitle': 'تطبيق الرعاية الصحية الشامل',
      'description':
          'احصل على رعاية طبية متميزة من أفضل الأطباء في مصر من خلال منصة واحدة',
      'image': AppAssets.onboarding1,
    },
    {
      'title': 'استشارات طبية فورية',
      'subtitle': 'تواصل مع الأطباء في أي وقت',
      'description':
          'احجز مواعيدك الطبية عبر مكالمات الفيديو أو الصوت أو زيارة العيادة',
      'image': AppAssets.onboarding2,
    },
    {
      'title': 'تتبع صحتك',
      'subtitle': 'مراقبة مؤشراتك الصحية',
      'description':
          'تابع تطور حالتك الصحية من خلال السجلات الطبية والتقارير الشاملة',
      'image': AppAssets.onboarding3,
    },
    {
      'title': 'رعاية شاملة',
      'subtitle': 'خدمات طبية متكاملة',
      'description':
          'من التشخيص إلى العلاج، نحن نوفر لك كل ما تحتاجه للحفاظ على صحتك',
      'image': AppAssets.onboarding4,
    },
    {
      'title': 'ابدأ رحلتك الصحية',
      'subtitle': 'مع شفائي',
      'description': 'انضم إلينا اليوم واستمتع برعاية طبية متميزة وآمنة',
      'image': AppAssets.onboarding5,
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  void _nextPage() {
    if (_currentPage < _onboardingData.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _completeOnboarding();
    }
  }

  void _skipOnboarding() async {
    await _saveOnboardingCompletion();
    if (mounted) {
      context.go(RouteNames.welcome);
    }
  }

  void _completeOnboarding() async {
    await _saveOnboardingCompletion();
    if (mounted) {
      context.go(RouteNames.welcome);
    }
  }

  /// Save that user has completed onboarding
  Future<void> _saveOnboardingCompletion() async {
    try {
      await _storageService.savePreference(
        StorageKeys.hasCompletedOnboarding,
        true,
      );
      // Optionally save onboarding version for future updates
      await _storageService.savePreference(
        StorageKeys.onboardingVersion,
        '1.0.0',
      );
    } catch (e) {
      debugPrint('Error saving onboarding completion: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.onboardingBackground,
      body: SafeArea(
        child: Column(
          children: [
            // Skip button
            Align(
              alignment: AlignmentDirectional.topStart,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Semantics(
                  label: 'تخطي الشرح التعريفي',
                  button: true,
                  hint: 'اضغط للانتقال مباشرة إلى شاشة الترحيب',
                  child: TextButton(
                    onPressed: _skipOnboarding,
                    style: TextButton.styleFrom(
                      minimumSize: const Size(48, 48),
                      padding: const EdgeInsets.all(8),
                    ),
                    child: Text(
                      'تخطي',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: AppColors.homeSecondaryText,
                                fontWeight: FontWeight.w500,
                              ) ??
                          const TextStyle(
                            fontSize: 16,
                            color: AppColors.homeSecondaryText,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                ),
              ),
            ),

            // Page content
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: _onPageChanged,
                itemCount: _onboardingData.length,
                itemBuilder: (context, index) {
                  final data = _onboardingData[index];
                  return OnboardingPage(
                    title: data['title']!,
                    subtitle: data['subtitle']!,
                    description: data['description']!,
                    image: data['image']!,
                  );
                },
              ),
            ),

            // Page indicators
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: PageIndicator(
                currentPage: _currentPage,
                pageCount: _onboardingData.length,
              ),
            ),

            // Bottom actions
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  if (_currentPage > 0)
                    Expanded(
                      child: Semantics(
                        label: 'السابق',
                        button: true,
                        hint: 'الرجوع إلى الصفحة السابقة',
                        child: TextButton(
                          onPressed: () {
                            _pageController.previousPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          },
                          style: TextButton.styleFrom(
                            minimumSize: const Size(48, 48),
                            padding: const EdgeInsets.all(8),
                          ),
                          child: Text(
                            'السابق',
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                          color: AppColors.homeSecondaryText,
                                        ) ??
                                    const TextStyle(
                                      fontSize: 16,
                                      color: AppColors.homeSecondaryText,
                                    ),
                          ),
                        ),
                      ),
                    ),
                  if (_currentPage > 0) const SizedBox(width: 16),
                  Expanded(
                    flex: _currentPage > 0 ? 2 : 1,
                    child: Semantics(
                      label: _currentPage == _onboardingData.length - 1
                          ? 'ابدأ الآن'
                          : 'التالي',
                      button: true,
                      hint: _currentPage == _onboardingData.length - 1
                          ? 'اضغط للبدء في استخدام التطبيق'
                          : 'الانتقال إلى الصفحة التالية',
                      child: PrimaryButton(
                        text: _currentPage == _onboardingData.length - 1
                            ? 'ابدأ الآن'
                            : 'التالي',
                        onPressed: _nextPage,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
