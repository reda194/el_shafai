import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:neurocare_app/core/constants/app_colors.dart';
import 'package:neurocare_app/core/constants/app_strings.dart';
import 'package:neurocare_app/core/constants/app_assets.dart';
import 'package:neurocare_app/core/constants/storage_keys.dart';
import 'package:neurocare_app/core/routes/route_names.dart';
import 'package:neurocare_app/core/services/storage_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  final _storageService = StorageService();

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    ));

    _animationController.forward();

    // Navigate to next screen after animation
    _initializeAndNavigate();
  }

  /// Initialize app and determine navigation destination
  Future<void> _initializeAndNavigate() async {
    try {
      // Wait for animation to complete (minimum 2 seconds)
      await Future.delayed(const Duration(seconds: 2));

      if (!mounted) return;

      // Check onboarding completion status
      final hasCompletedOnboarding = _storageService.getPreference<bool>(
            StorageKeys.hasCompletedOnboarding,
          ) ??
          false;

      // Check authentication status
      final isLoggedIn = _storageService.isAuthenticated();
      final authToken = _storageService.getAuthToken();

      // Increment app launch count
      final launchCount = _storageService.getPreference<int>(
            StorageKeys.appLaunchCount,
          ) ??
          0;
      await _storageService.savePreference(
        StorageKeys.appLaunchCount,
        launchCount + 1,
      );

      // Save app install timestamp on first launch
      if (launchCount == 0) {
        await _storageService.savePreference(
          StorageKeys.appInstallTimestamp,
          DateTime.now().millisecondsSinceEpoch,
        );
      }

      // Determine navigation destination based on user state
      if (!hasCompletedOnboarding) {
        // First-time user → Show onboarding
        _navigateTo(RouteNames.onboarding);
      } else if (!isLoggedIn || authToken == null) {
        // Returning user, not logged in → Show welcome/login
        _navigateTo(RouteNames.welcome);
      } else {
        // Logged in user → Validate token and go to home
        await _validateTokenAndNavigate();
      }
    } catch (e) {
      // Error occurred, navigate to onboarding as fallback
      debugPrint('Error in splash navigation: $e');
      if (mounted) {
        _navigateTo(RouteNames.onboarding);
      }
    }
  }

  /// Validate authentication token and navigate accordingly
  Future<void> _validateTokenAndNavigate() async {
    try {
      final token = _storageService.getAuthToken();
      final tokenExpiration = _storageService.getPreference<int>(
        StorageKeys.tokenExpiration,
      );

      // Check if token has expired
      if (tokenExpiration != null) {
        final expirationDate =
            DateTime.fromMillisecondsSinceEpoch(tokenExpiration);
        final now = DateTime.now();

        if (now.isAfter(expirationDate)) {
          // Token expired → Clear and go to welcome
          await _clearAuthAndNavigateToWelcome();
          return;
        }
      }

      // Token valid (or no expiration set) → Go to home
      // Optionally: Add backend token validation here
      // final isValid = await apiClient.validateToken(token);
      // if (!isValid) { await _clearAuthAndNavigateToWelcome(); return; }

      _navigateTo(RouteNames.home);
    } catch (e) {
      // Token validation failed → Clear and go to welcome
      debugPrint('Token validation error: $e');
      await _clearAuthAndNavigateToWelcome();
    }
  }

  /// Clear authentication data and navigate to welcome screen
  Future<void> _clearAuthAndNavigateToWelcome() async {
    await _storageService.removeAuthToken();
    await _storageService.savePreference(StorageKeys.isLoggedIn, false);
    _navigateTo(RouteNames.welcome);
  }

  /// Navigate to the specified route
  void _navigateTo(String route) {
    if (mounted) {
      context.go(route);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Center(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo Section
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        // App Logo
                        SizedBox(
                          width: 56.405,
                          height: 65.147,
                          child: SvgPicture.asset(
                            AppAssets.logo,
                            fit: BoxFit.contain,
                            colorFilter: const ColorFilter.mode(
                              Colors.white,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // App Name
                        const Text(
                          AppStrings.appName,
                          style: TextStyle(
                            fontSize: 40.047,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            fontFamily: 'IBMPlexSansArabic',
                            height: 1.2,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  // Tagline
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Text(
                      'رعاية صحية شاملة\nفي متناول يدك',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontFamily: 'IBMPlexSansArabic',
                        height: 1.4,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Loading Indicator
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      strokeWidth: 2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
