import 'package:flutter/material.dart';

/// Responsive size utilities for different screen sizes
class ResponsiveSize {
  static const double _designWidth = 375.0; // iPhone 6/7/8 width
  static const double _designHeight = 812.0; // iPhone X height

  static double _screenWidth = 0;
  static double _screenHeight = 0;

  static void init(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    _screenWidth = mediaQuery.size.width;
    _screenHeight = mediaQuery.size.height;
  }

  /// Get responsive width based on design width
  static double width(double width) {
    return (_screenWidth / _designWidth) * width;
  }

  /// Get responsive height based on design height
  static double height(double height) {
    return (_screenHeight / _designHeight) * height;
  }

  /// Get responsive font size
  static double fontSize(double fontSize) {
    return (_screenWidth / _designWidth) * fontSize;
  }

  /// Get responsive radius
  static double radius(double radius) {
    return (_screenWidth / _designWidth) * radius;
  }

  /// Get responsive padding/margin
  static double padding(double padding) {
    return (_screenWidth / _designWidth) * padding;
  }

  /// Check if device is tablet
  static bool isTablet(BuildContext context) {
    return MediaQuery.of(context).size.shortestSide >= 600;
  }

  /// Check if device is mobile
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.shortestSide < 600;
  }
}

/// Extension methods for responsive sizes
extension ResponsiveExtension on num {
  /// Convert to responsive width
  double get w => ResponsiveSize.width(toDouble());

  /// Convert to responsive height
  double get h => ResponsiveSize.height(toDouble());

  /// Convert to responsive font size
  double get sp => ResponsiveSize.fontSize(toDouble());

  /// Convert to responsive radius
  double get r => ResponsiveSize.radius(toDouble());

  /// Convert to responsive padding
  double get p => ResponsiveSize.padding(toDouble());
}
