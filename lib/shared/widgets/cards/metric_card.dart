import 'package:flutter/material.dart';
import 'package:neurocare_app/core/constants/app_colors.dart';

class MetricCard extends StatelessWidget {
  final String title;
  final String value;
  final String? unit;
  final IconData? icon;
  final Color? iconColor;
  final Color? backgroundColor;
  final Color? valueColor;
  final double? progress;
  final Color? progressColor;
  final VoidCallback? onTap;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;

  const MetricCard({
    super.key,
    required this.title,
    required this.value,
    this.unit,
    this.icon,
    this.iconColor,
    this.backgroundColor,
    this.valueColor,
    this.progress,
    this.progressColor,
    this.onTap,
    this.borderRadius = 16,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding ?? const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.white,
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: const Offset(0, 2),
              blurRadius: 8,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Icon and Title Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (icon != null)
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: (iconColor ?? AppColors.primary).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      icon,
                      color: iconColor ?? AppColors.primary,
                      size: 20,
                    ),
                  ),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontFamily: 'IBM Plex Sans Arabic',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.homeSecondaryText,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Value Display
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                if (unit != null)
                  Text(
                    unit!,
                    style: TextStyle(
                      fontFamily: 'IBM Plex Sans Arabic',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: valueColor ?? AppColors.primary,
                    ),
                  ),
                const SizedBox(width: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontFamily: 'IBM Plex Sans Arabic',
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: valueColor ?? AppColors.primary,
                  ),
                ),
              ],
            ),

            // Progress Bar (optional)
            if (progress != null) ...[
              const SizedBox(height: 12),
              LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.grey.shade200,
                valueColor: AlwaysStoppedAnimation<Color>(
                  progressColor ?? AppColors.primary,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
