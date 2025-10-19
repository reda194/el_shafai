import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:neurocare_app/core/constants/storage_keys.dart';
import 'package:neurocare_app/core/routes/route_names.dart';
import 'package:neurocare_app/core/services/storage_service.dart';
import 'package:neurocare_app/features/splash/presentation/pages/splash_screen.dart';
import 'package:neurocare_app/features/onboarding/presentation/pages/onboarding_screen.dart';
import 'package:neurocare_app/features/authentication/presentation/pages/welcome_screen.dart';
import 'package:neurocare_app/features/authentication/presentation/pages/sign_in_screen.dart';
import 'package:neurocare_app/features/authentication/presentation/pages/sign_up_screen.dart';
import 'package:neurocare_app/features/authentication/presentation/pages/forgot_password_screen.dart';
import 'package:neurocare_app/features/authentication/presentation/pages/check_email_screen.dart';
import 'package:neurocare_app/features/authentication/presentation/pages/reset_password_screen.dart';
import 'package:neurocare_app/features/authentication/presentation/pages/create_new_password_screen.dart';
import 'package:neurocare_app/features/authentication/presentation/pages/welcome_screen_3.dart';
import 'package:neurocare_app/features/authentication/presentation/pages/welcome_screen_4.dart';
import 'package:neurocare_app/features/authentication/presentation/pages/login_form_screen.dart';
import 'package:neurocare_app/features/home/presentation/pages/home_screen.dart';
import 'package:neurocare_app/features/appointment/presentation/pages/appointments_list_screen.dart';
import 'package:neurocare_app/features/appointment/presentation/pages/appointment_details_screen.dart';
import 'package:neurocare_app/features/appointment/presentation/pages/book_appointment_screen.dart';
import 'package:neurocare_app/features/chat/presentation/pages/chat_list_screen.dart';
import 'package:neurocare_app/features/chat/presentation/pages/chat_detail_screen.dart';
import 'package:neurocare_app/features/doctor/presentation/pages/doctor_listing_screen.dart';
import 'package:neurocare_app/features/doctor/presentation/pages/doctor_profile_details_screen.dart';
import 'package:neurocare_app/features/doctor/presentation/pages/filter_screen.dart';
import 'package:neurocare_app/features/profile/presentation/pages/profile_screen.dart';
import 'package:neurocare_app/features/profile/presentation/pages/edit_profile_screen.dart';
import 'package:neurocare_app/features/health_records/presentation/pages/health_records_screen.dart';
import 'package:neurocare_app/features/medications/presentation/pages/medications_screen.dart';
import 'package:neurocare_app/features/notifications/presentation/pages/notifications_screen.dart';
import 'package:neurocare_app/features/settings/presentation/pages/settings_screen.dart';
import 'package:neurocare_app/features/payment/presentation/pages/payment_methods_screen.dart';
import 'package:neurocare_app/features/payment/presentation/pages/payment_method_variants_screen.dart';
import 'package:neurocare_app/features/payment/presentation/pages/card_details_screen.dart';
import 'package:neurocare_app/features/payment/presentation/pages/my_card_screen.dart';
import 'package:neurocare_app/features/call/presentation/pages/video_call_screen.dart';
import 'package:neurocare_app/features/call/presentation/pages/audio_call_screen.dart';
import 'package:neurocare_app/features/location/presentation/pages/enter_location_screen.dart';
import 'package:neurocare_app/features/location/presentation/pages/nearby_map_screen.dart';
import 'package:neurocare_app/features/location/presentation/pages/get_location_screen.dart';
import 'package:neurocare_app/features/review/domain/entities/review_entity.dart';
import 'package:neurocare_app/features/review/presentation/pages/review_screen.dart';
import 'package:neurocare_app/features/tracking/presentation/pages/tracking_screen.dart';
import 'package:neurocare_app/features/congratulations/presentation/pages/congratulations_screen.dart';

/// App Router Configuration using GoRouter
class AppRouter {
  static final _storageService = StorageService();

  /// Protected routes that require authentication
  static final List<String> _protectedRoutes = [
    RouteNames.home,
    RouteNames.appointments,
    RouteNames.bookAppointment,
    RouteNames.appointmentDetails,
    RouteNames.chat,
    RouteNames.chatDetail,
    RouteNames.profile,
    RouteNames.editProfile,
    RouteNames.settings,
    RouteNames.healthRecords,
    RouteNames.medications,
    RouteNames.paymentMethods,
    RouteNames.paymentMethodVariants,
    RouteNames.cardDetails,
    RouteNames.myCard,
    RouteNames.videoCall,
    RouteNames.audioCall,
    RouteNames.tracking,
  ];

  /// Authentication routes (redirect to home if already logged in)
  static final List<String> _authRoutes = [
    RouteNames.welcome,
    RouteNames.login,
    RouteNames.register,
    RouteNames.loginForm,
    RouteNames.forgotPassword,
  ];

  /// Public routes (accessible without authentication)
  static final List<String> _publicRoutes = [
    RouteNames.splash,
    RouteNames.onboarding,
    RouteNames.checkEmail,
    RouteNames.resetPassword,
    RouteNames.createNewPassword,
    RouteNames.congratulations,
  ];

  static final router = GoRouter(
    initialLocation: RouteNames.splash,
    redirect: (BuildContext context, GoRouterState state) {
      // Get current location
      final location = state.uri.path;

      // Check authentication status
      final isLoggedIn = _storageService.isAuthenticated();
      final hasCompletedOnboarding = _storageService.getPreference<bool>(
            StorageKeys.hasCompletedOnboarding,
          ) ??
          false;

      // Allow splash screen always
      if (location == RouteNames.splash) {
        return null; // No redirect
      }

      // Allow public routes
      if (_publicRoutes.contains(location)) {
        return null; // No redirect
      }

      // If trying to access protected route without authentication
      if (_protectedRoutes.contains(location) && !isLoggedIn) {
        // Redirect to welcome if onboarding completed, else to onboarding
        return hasCompletedOnboarding
            ? RouteNames.welcome
            : RouteNames.onboarding;
      }

      // If trying to access auth routes while already logged in
      if (_authRoutes.contains(location) && isLoggedIn) {
        return RouteNames.home; // Redirect to home
      }

      return null; // No redirect needed
    },
    routes: [
      // Splash Screen
      GoRoute(
        path: RouteNames.splash,
        builder: (context, state) => const SplashScreen(),
      ),

      // Onboarding Screen
      GoRoute(
        path: RouteNames.onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),

      // Welcome Screen
      GoRoute(
        path: RouteNames.welcome,
        builder: (context, state) => const WelcomeScreen(),
      ),

      // Authentication Routes
      GoRoute(
        path: RouteNames.login,
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: RouteNames.register,
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: RouteNames.loginForm,
        builder: (context, state) => const LoginFormScreen(),
      ),
      GoRoute(
        path: RouteNames.forgotPassword,
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: RouteNames.checkEmail,
        builder: (context, state) => const CheckEmailScreen(),
      ),
      GoRoute(
        path: RouteNames.resetPassword,
        builder: (context, state) => const ResetPasswordScreen(),
      ),
      GoRoute(
        path: RouteNames.createNewPassword,
        builder: (context, state) => const CreateNewPasswordScreen(),
      ),
      GoRoute(
        path: RouteNames.welcome3,
        builder: (context, state) => const WelcomeScreen3(),
      ),
      GoRoute(
        path: RouteNames.welcome4,
        builder: (context, state) => const WelcomeScreen4(),
      ),

      // Main App Routes
      GoRoute(
        path: RouteNames.home,
        builder: (context, state) => const HomeScreen(),
      ),

      // Appointment Routes
      GoRoute(
        path: RouteNames.appointments,
        builder: (context, state) => const AppointmentsListScreen(),
      ),
      GoRoute(
        path: RouteNames.appointmentDetails,
        builder: (context, state) {
          final appointment = state.extra as dynamic;
          return AppointmentDetailsScreen(appointment: appointment);
        },
      ),
      GoRoute(
        path: RouteNames.bookAppointment,
        builder: (context, state) => const BookAppointmentScreen(),
      ),

      // Chat Routes
      GoRoute(
        path: RouteNames.chat,
        builder: (context, state) => const ChatListScreen(),
      ),
      GoRoute(
        path: RouteNames.chatDetail,
        builder: (context, state) {
          final chatRoom = state.extra as dynamic;
          return ChatDetailScreen(chatRoom: chatRoom);
        },
      ),

      // Doctor Routes
      GoRoute(
        path: RouteNames.doctors,
        builder: (context, state) => const DoctorListingScreen(),
      ),
      GoRoute(
        path: RouteNames.doctorDetails,
        builder: (context, state) => const DoctorProfileDetailsScreen(),
      ),
      GoRoute(
        path: RouteNames.filter,
        builder: (context, state) => const FilterScreen(),
      ),

      // Profile Routes
      GoRoute(
        path: RouteNames.profile,
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: RouteNames.editProfile,
        builder: (context, state) {
          final profile = state.extra as dynamic;
          return EditProfileScreen(profile: profile);
        },
      ),
      GoRoute(
        path: RouteNames.settings,
        builder: (context, state) => const SettingsScreen(),
      ),

      // Health Records Routes
      GoRoute(
        path: RouteNames.healthRecords,
        builder: (context, state) => const HealthRecordsScreen(),
      ),

      // Medications Routes
      GoRoute(
        path: RouteNames.medications,
        builder: (context, state) => const MedicationsScreen(),
      ),

      // Notification Routes
      GoRoute(
        path: RouteNames.notifications,
        builder: (context, state) => const NotificationsScreen(),
      ),

      // Payment Routes
      GoRoute(
        path: RouteNames.paymentMethods,
        builder: (context, state) => const PaymentMethodsScreen(),
      ),
      GoRoute(
        path: RouteNames.paymentMethodVariants,
        builder: (context, state) => const PaymentMethodVariantsScreen(),
      ),
      GoRoute(
        path: RouteNames.cardDetails,
        builder: (context, state) => const CardDetailsScreen(),
      ),
      GoRoute(
        path: RouteNames.myCard,
        builder: (context, state) => const MyCardScreen(),
      ),

      // Call Routes
      GoRoute(
        path: RouteNames.videoCall,
        builder: (context, state) => const VideoCallScreen(),
      ),
      GoRoute(
        path: RouteNames.audioCall,
        builder: (context, state) => const AudioCallScreen(),
      ),

      // Location Routes
      GoRoute(
        path: RouteNames.enterLocation,
        builder: (context, state) => const EnterLocationScreen(),
      ),
      GoRoute(
        path: RouteNames.nearbyMap,
        builder: (context, state) => const NearbyMapScreen(),
      ),
      GoRoute(
        path: RouteNames.getLocation,
        builder: (context, state) => const GetLocationScreen(),
      ),

      // Review Routes
      GoRoute(
        path: RouteNames.review,
        builder: (context, state) {
          final targetId = state.uri.queryParameters['targetId'];
          final reviewType = state.uri.queryParameters['reviewType'];
          final targetName = state.uri.queryParameters['targetName'];

          return ReviewScreen(
            targetId: targetId,
            reviewType: reviewType != null
                ? ReviewType.values.firstWhere(
                    (type) => type.toString() == reviewType,
                    orElse: () => ReviewType.doctor,
                  )
                : ReviewType.doctor,
            targetName: targetName,
          );
        },
      ),

      // Tracking Routes
      GoRoute(
        path: RouteNames.tracking,
        builder: (context, state) => const TrackingScreen(),
      ),

      // Congratulations Routes
      GoRoute(
        path: RouteNames.congratulations,
        builder: (context, state) => const CongratulationsScreen(),
      ),

      // TODO: Add remaining routes for other features
      // - Health Records
      // - Medications
      // - Notifications
      // - Doctors
      // - Payment
      // - Settings
    ],
    errorBuilder: (context, state) => const Scaffold(
      body: Center(
        child: Text('Page not found'),
      ),
    ),
  );
}
