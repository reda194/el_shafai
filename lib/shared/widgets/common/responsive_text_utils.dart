import 'package:flutter/material.dart';

/// Utility class for responsive text scaling and overflow prevention
class ResponsiveTextUtils {
  /// Get responsive font size based on screen width
  static double getResponsiveFontSize(BuildContext context, double baseFontSize,
      {double minScale = 0.8, double maxScale = 1.5}) {
    final screenWidth = MediaQuery.of(context).size.width;
    final scaleFactor = screenWidth / 375.0; // Base width: iPhone 6/7/8 width
    final scaledSize = baseFontSize * scaleFactor;
    return scaledSize.clamp(baseFontSize * minScale, baseFontSize * maxScale);
  }

  /// Create responsive text style
  static TextStyle getResponsiveTextStyle(
    BuildContext context,
    TextStyle baseStyle, {
    double minScale = 0.8,
    double maxScale = 1.5,
  }) {
    final responsiveFontSize = getResponsiveFontSize(
      context,
      baseStyle.fontSize ?? 14.0,
      minScale: minScale,
      maxScale: maxScale,
    );

    return baseStyle.copyWith(fontSize: responsiveFontSize);
  }

  /// Responsive text widget with overflow handling
  static Widget buildResponsiveText(
    String text, {
    required BuildContext context,
    TextStyle? style,
    TextAlign? textAlign,
    int maxLines = 1,
    TextOverflow overflow = TextOverflow.ellipsis,
    double minFontSize = 10.0,
    double maxFontSize = 48.0,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.maxWidth;
        final baseFontSize = style?.fontSize ?? 14.0;

        // Calculate optimal font size based on text length and available width
        final textPainter = TextPainter(
          text: TextSpan(text: text, style: style),
          textDirection: TextDirection.rtl, // Assuming Arabic RTL
          maxLines: maxLines,
        );

        // Binary search for optimal font size
        double low = minFontSize;
        double high = maxFontSize;
        double optimalSize = baseFontSize;

        for (int i = 0; i < 10; i++) {
          final mid = (low + high) / 2;
          textPainter.text = TextSpan(
            text: text,
            style: style?.copyWith(fontSize: mid),
          );
          textPainter.layout(maxWidth: availableWidth);

          if (textPainter.didExceedMaxLines) {
            high = mid;
          } else {
            low = mid;
            optimalSize = mid;
          }
        }

        return Text(
          text,
          style: style?.copyWith(fontSize: optimalSize),
          textAlign: textAlign,
          maxLines: maxLines,
          overflow: overflow,
        );
      },
    );
  }
}

/// Predefined responsive text styles for common use cases
class AppResponsiveTextStyles {
  static TextStyle titleLarge(BuildContext context) {
    return ResponsiveTextUtils.getResponsiveTextStyle(
      context,
      const TextStyle(
        fontFamily: 'IBM Plex Sans Arabic',
        fontSize: 32,
        fontWeight: FontWeight.bold,
        height: 1.2,
      ),
    );
  }

  static TextStyle titleMedium(BuildContext context) {
    return ResponsiveTextUtils.getResponsiveTextStyle(
      context,
      const TextStyle(
        fontFamily: 'IBM Plex Sans Arabic',
        fontSize: 24,
        fontWeight: FontWeight.bold,
        height: 1.3,
      ),
    );
  }

  static TextStyle titleSmall(BuildContext context) {
    return ResponsiveTextUtils.getResponsiveTextStyle(
      context,
      const TextStyle(
        fontFamily: 'IBM Plex Sans Arabic',
        fontSize: 20,
        fontWeight: FontWeight.bold,
        height: 1.4,
      ),
    );
  }

  static TextStyle bodyLarge(BuildContext context) {
    return ResponsiveTextUtils.getResponsiveTextStyle(
      context,
      const TextStyle(
        fontFamily: 'IBM Plex Sans Arabic',
        fontSize: 18,
        fontWeight: FontWeight.normal,
        height: 1.5,
      ),
    );
  }

  static TextStyle bodyMedium(BuildContext context) {
    return ResponsiveTextUtils.getResponsiveTextStyle(
      context,
      const TextStyle(
        fontFamily: 'IBM Plex Sans Arabic',
        fontSize: 16,
        fontWeight: FontWeight.normal,
        height: 1.5,
      ),
    );
  }

  static TextStyle bodySmall(BuildContext context) {
    return ResponsiveTextUtils.getResponsiveTextStyle(
      context,
      const TextStyle(
        fontFamily: 'IBM Plex Sans Arabic',
        fontSize: 14,
        fontWeight: FontWeight.normal,
        height: 1.5,
      ),
    );
  }

  static TextStyle labelLarge(BuildContext context) {
    return ResponsiveTextUtils.getResponsiveTextStyle(
      context,
      const TextStyle(
        fontFamily: 'IBM Plex Sans Arabic',
        fontSize: 16,
        fontWeight: FontWeight.w500,
        height: 1.4,
      ),
    );
  }

  static TextStyle labelMedium(BuildContext context) {
    return ResponsiveTextUtils.getResponsiveTextStyle(
      context,
      const TextStyle(
        fontFamily: 'IBM Plex Sans Arabic',
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 1.4,
      ),
    );
  }

  static TextStyle labelSmall(BuildContext context) {
    return ResponsiveTextUtils.getResponsiveTextStyle(
      context,
      const TextStyle(
        fontFamily: 'IBM Plex Sans Arabic',
        fontSize: 12,
        fontWeight: FontWeight.w500,
        height: 1.4,
      ),
    );
  }
}

/// Responsive text widget for common use cases
class ResponsiveHeadline extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final Color? color;
  final int? maxLines;
  final TextOverflow? overflow;

  const ResponsiveHeadline(
    this.text, {
    super.key,
    this.textAlign,
    this.color,
    this.maxLines,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppResponsiveTextStyles.titleLarge(context).copyWith(color: color),
      textAlign: textAlign ?? TextAlign.right,
      maxLines: maxLines,
      overflow: overflow ?? TextOverflow.ellipsis,
    );
  }
}

class ResponsiveTitle extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final Color? color;
  final int? maxLines;
  final TextOverflow? overflow;

  const ResponsiveTitle(
    this.text, {
    super.key,
    this.textAlign,
    this.color,
    this.maxLines,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style:
          AppResponsiveTextStyles.titleMedium(context).copyWith(color: color),
      textAlign: textAlign ?? TextAlign.right,
      maxLines: maxLines,
      overflow: overflow ?? TextOverflow.ellipsis,
    );
  }
}

class ResponsiveSubtitle extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final Color? color;
  final int? maxLines;
  final TextOverflow? overflow;

  const ResponsiveSubtitle(
    this.text, {
    super.key,
    this.textAlign,
    this.color,
    this.maxLines,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppResponsiveTextStyles.titleSmall(context).copyWith(color: color),
      textAlign: textAlign ?? TextAlign.right,
      maxLines: maxLines,
      overflow: overflow ?? TextOverflow.ellipsis,
    );
  }
}

class ResponsiveBody extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final Color? color;
  final int? maxLines;
  final TextOverflow? overflow;

  const ResponsiveBody(
    this.text, {
    super.key,
    this.textAlign,
    this.color,
    this.maxLines,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppResponsiveTextStyles.bodyMedium(context).copyWith(color: color),
      textAlign: textAlign ?? TextAlign.right,
      maxLines: maxLines,
      overflow: overflow ?? TextOverflow.ellipsis,
    );
  }
}

class ResponsiveCaption extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final Color? color;
  final int? maxLines;
  final TextOverflow? overflow;

  const ResponsiveCaption(
    this.text, {
    super.key,
    this.textAlign,
    this.color,
    this.maxLines,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppResponsiveTextStyles.bodySmall(context).copyWith(color: color),
      textAlign: textAlign ?? TextAlign.right,
      maxLines: maxLines,
      overflow: overflow ?? TextOverflow.ellipsis,
    );
  }
}
