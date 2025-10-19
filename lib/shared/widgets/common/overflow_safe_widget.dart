import 'package:flutter/material.dart';

/// A collection of reusable widgets and utilities to prevent RenderFlex overflow errors.
/// These widgets automatically adapt to different screen sizes and prevent layout overflows.

/// Responsive Container that adapts its width based on screen size
class ResponsiveContainer extends StatelessWidget {
  final Widget child;
  final double? maxWidth;
  final double? minWidth;
  final EdgeInsetsGeometry? padding;
  final BoxDecoration? decoration;

  const ResponsiveContainer({
    super.key,
    required this.child,
    this.maxWidth,
    this.minWidth,
    this.padding,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = MediaQuery.of(context).size.width;
        final containerWidth =
            screenWidth * 0.9; // 90% of screen width by default

        final effectiveWidth = maxWidth != null && containerWidth > maxWidth!
            ? maxWidth!
            : minWidth != null && containerWidth < minWidth!
                ? minWidth!
                : containerWidth;

        return Container(
          width: effectiveWidth,
          padding: padding,
          decoration: decoration,
          child: child,
        );
      },
    );
  }
}

/// Responsive Text that automatically adjusts font size based on screen width
class ResponsiveText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;
  final double minFontSize;
  final double maxFontSize;

  const ResponsiveText(
    this.text, {
    super.key,
    this.style,
    this.textAlign,
    this.overflow = TextOverflow.ellipsis,
    this.maxLines = 1,
    this.minFontSize = 12.0,
    this.maxFontSize = 32.0,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = MediaQuery.of(context).size.width;
        final scaleFactor =
            screenWidth / 375.0; // Base width: iPhone 6/7/8 width
        final scaledFontSize = (style?.fontSize ?? 14.0) * scaleFactor;

        final clampedFontSize = scaledFontSize.clamp(minFontSize, maxFontSize);

        return Text(
          text,
          style: style?.copyWith(fontSize: clampedFontSize),
          textAlign: textAlign,
          overflow: overflow,
          maxLines: maxLines,
        );
      },
    );
  }
}

/// Overflow-safe Row that wraps children when they don't fit
class OverflowSafeRow extends StatelessWidget {
  final List<Widget> children;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisSize mainAxisSize;
  final double spacing;

  const OverflowSafeRow({
    super.key,
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisSize = MainAxisSize.max,
    this.spacing = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.maxWidth;

        // Calculate total width needed
        double totalWidth = 0;
        final sizedChildren = <Widget>[];

        for (int i = 0; i < children.length; i++) {
          if (i > 0) totalWidth += spacing;

          // For now, assume each child takes some space
          // In a real implementation, you might want to measure children
          sizedChildren.add(children[i]);
          totalWidth += 50; // Estimate child width - adjust as needed
        }

        // If total width exceeds available width, use Wrap instead of Row
        if (totalWidth > availableWidth && children.length > 1) {
          return Wrap(
            spacing: spacing,
            runSpacing: spacing,
            alignment: WrapAlignment.start,
            children: children,
          );
        }

        return Row(
          mainAxisAlignment: mainAxisAlignment,
          crossAxisAlignment: crossAxisAlignment,
          mainAxisSize: mainAxisSize,
          children: children.map((child) {
            return Padding(
              padding: EdgeInsets.only(
                  left: children.indexOf(child) > 0 ? spacing : 0),
              child: child,
            );
          }).toList(),
        );
      },
    );
  }
}

/// Responsive Grid that automatically adjusts columns based on screen size
class ResponsiveGrid extends StatelessWidget {
  final List<Widget> children;
  final int minCrossAxisCount;
  final int maxCrossAxisCount;
  final double crossAxisSpacing;
  final double mainAxisSpacing;
  final double childAspectRatio;

  const ResponsiveGrid({
    super.key,
    required this.children,
    this.minCrossAxisCount = 2,
    this.maxCrossAxisCount = 4,
    this.crossAxisSpacing = 8.0,
    this.mainAxisSpacing = 8.0,
    this.childAspectRatio = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        // Calculate optimal cross axis count
        int crossAxisCount;
        if (width < 400) {
          crossAxisCount = minCrossAxisCount;
        } else if (width < 600) {
          crossAxisCount = minCrossAxisCount + 1;
        } else if (width < 800) {
          crossAxisCount = maxCrossAxisCount - 1;
        } else {
          crossAxisCount = maxCrossAxisCount;
        }

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: crossAxisSpacing,
            mainAxisSpacing: mainAxisSpacing,
            childAspectRatio: childAspectRatio,
          ),
          itemCount: children.length,
          itemBuilder: (context, index) => children[index],
        );
      },
    );
  }
}

/// Safe Card that prevents overflow with proper constraints
class SafeCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final double? maxWidth;
  final double? minWidth;
  final double borderRadius;
  final Color? color;

  const SafeCard({
    super.key,
    required this.child,
    this.margin,
    this.padding,
    this.maxWidth,
    this.minWidth,
    this.borderRadius = 12.0,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: maxWidth ?? MediaQuery.of(context).size.width * 0.9,
        minWidth: minWidth ?? 0,
      ),
      margin: margin,
      padding: padding ?? const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color ?? Colors.white,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }
}

/// Utility class for responsive measurements
class ResponsiveUtils {
  static double getResponsiveFontSize(
      BuildContext context, double baseFontSize) {
    final screenWidth = MediaQuery.of(context).size.width;
    final scaleFactor = screenWidth / 375.0; // Base width: iPhone 6/7/8
    return baseFontSize *
        scaleFactor.clamp(0.8, 1.5); // Clamp between 80% and 150%
  }

  static double getResponsivePadding(BuildContext context, double basePadding) {
    final screenWidth = MediaQuery.of(context).size.width;
    final scaleFactor = screenWidth / 375.0;
    return basePadding * scaleFactor.clamp(0.7, 1.3);
  }

  static EdgeInsets getResponsiveInsets(
    BuildContext context, {
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) {
    final scaleFactor = MediaQuery.of(context).size.width / 375.0;
    final clampedFactor = scaleFactor.clamp(0.7, 1.3);

    return EdgeInsets.only(
      left: left * clampedFactor,
      top: top * clampedFactor,
      right: right * clampedFactor,
      bottom: bottom * clampedFactor,
    );
  }

  static bool shouldUseWrap(
      BuildContext context, double totalWidth, int itemCount) {
    final screenWidth = MediaQuery.of(context).size.width;
    final availableWidth = screenWidth * 0.9; // 90% of screen width
    return totalWidth > availableWidth && itemCount > 1;
  }
}

/// Extension methods for easier responsive development
extension ResponsiveExtension on BuildContext {
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;

  double responsiveFontSize(double baseSize) =>
      ResponsiveUtils.getResponsiveFontSize(this, baseSize);

  double responsivePadding(double basePadding) =>
      ResponsiveUtils.getResponsivePadding(this, basePadding);

  EdgeInsets responsiveInsets({
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) =>
      ResponsiveUtils.getResponsiveInsets(
        this,
        left: left,
        top: top,
        right: right,
        bottom: bottom,
      );
}
