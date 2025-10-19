import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Navigation helper utilities for consistent navigation across the app
class NavigationHelper {
  /// Navigate to a new route
  static void navigateTo(BuildContext context, String routeName,
      {Object? extra}) {
    context.go(routeName, extra: extra);
  }

  /// Navigate to a new route and remove previous routes
  static void navigateToAndRemoveUntil(BuildContext context, String routeName,
      {Object? extra}) {
    context.go(routeName, extra: extra);
    // Note: GoRouter doesn't have a direct equivalent to pushAndRemoveUntil
    // This is a simplified version. For more complex scenarios,
    // consider using state management or custom router logic
  }

  /// Navigate back to previous route
  static void goBack(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    }
  }

  /// Navigate back with result
  static void goBackWithResult<T>(BuildContext context, T result) {
    context.pop(result);
  }

  /// Push a new route on top of current route
  static void push(BuildContext context, String routeName, {Object? extra}) {
    context.push(routeName, extra: extra);
  }

  /// Replace current route with new route
  static void replace(BuildContext context, String routeName, {Object? extra}) {
    context.replace(routeName, extra: extra);
  }

  /// Check if can navigate back
  static bool canGoBack(BuildContext context) {
    return context.canPop();
  }

  /// Get current route name
  static String? getCurrentRoute(BuildContext context) {
    try {
      final router = GoRouter.of(context);
      return router.routeInformationProvider.value.uri.toString();
    } catch (e) {
      return null;
    }
  }

  /// Navigate to home screen
  static void goToHome(BuildContext context) {
    navigateTo(context, '/home');
  }

  /// Navigate to login screen
  static void goToLogin(BuildContext context) {
    navigateToAndRemoveUntil(context, '/login');
  }

  /// Navigate to profile screen
  static void goToProfile(BuildContext context) {
    navigateTo(context, '/profile');
  }

  /// Navigate to appointments screen
  static void goToAppointments(BuildContext context) {
    navigateTo(context, '/appointments');
  }

  /// Navigate to chat screen
  static void goToChat(BuildContext context) {
    navigateTo(context, '/chat');
  }

  /// Show a dialog
  static Future<T?> showDialog<T>(
    BuildContext context, {
    required WidgetBuilder builder,
    bool barrierDismissible = true,
    String? barrierLabel,
    Color barrierColor = Colors.black54,
  }) {
    return showGeneralDialog<T>(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) => builder(context),
      barrierDismissible: barrierDismissible,
      barrierLabel: barrierLabel ?? 'Dialog',
      barrierColor: barrierColor,
      transitionDuration: const Duration(milliseconds: 200),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          scale: CurvedAnimation(
            parent: animation,
            curve: Curves.easeOut,
          ),
          child: child,
        );
      },
    );
  }

  /// Show a bottom sheet
  static Future<T?> showBottomSheet<T>(
    BuildContext context, {
    required WidgetBuilder builder,
    Color? backgroundColor,
    double? elevation,
    ShapeBorder? shape,
    bool isScrollControlled = false,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      builder: builder,
      backgroundColor: backgroundColor,
      elevation: elevation,
      shape: shape,
      isScrollControlled: isScrollControlled,
    );
  }

  /// Show a snackbar
  static void showSnackBar(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 3),
    Color? backgroundColor,
    Color? textColor,
    SnackBarAction? action,
  }) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: textColor != null ? TextStyle(color: textColor) : null,
      ),
      backgroundColor: backgroundColor,
      duration: duration,
      action: action,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  /// Show success snackbar
  static void showSuccessSnackBar(BuildContext context, String message) {
    showSnackBar(
      context,
      message: message,
      backgroundColor: Colors.green,
      textColor: Colors.white,
    );
  }

  /// Show error snackbar
  static void showErrorSnackBar(BuildContext context, String message) {
    showSnackBar(
      context,
      message: message,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
  }

  /// Show info snackbar
  static void showInfoSnackBar(BuildContext context, String message) {
    showSnackBar(
      context,
      message: message,
      backgroundColor: Colors.blue,
      textColor: Colors.white,
    );
  }
}

// Removed extension to avoid conflicts with go_router package
