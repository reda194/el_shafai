import 'package:flutter/material.dart';
import 'package:neurocare_app/core/constants/app_colors.dart';

class OutlineButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isDisabled;
  final double? width;
  final double? height;
  final IconData? icon;
  final bool iconRight;
  final Color? borderColor;
  final Color? textColor;

  const OutlineButtonWidget({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.isDisabled = false,
    this.width,
    this.height = 50,
    this.icon,
    this.iconRight = false,
    this.borderColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveBorderColor = borderColor ?? AppColors.primary;
    final effectiveTextColor = textColor ?? AppColors.primary;

    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: OutlinedButton(
        onPressed: (isLoading || isDisabled) ? null : onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(
            color: isDisabled ? Colors.grey.shade300 : effectiveBorderColor,
            width: 1.5,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          backgroundColor: Colors.transparent,
        ),
        child: isLoading
            ? SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    isDisabled ? Colors.grey : effectiveTextColor,
                  ),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null && !iconRight) ...[
                    Icon(
                      icon,
                      size: 20,
                      color: isDisabled ? Colors.grey : effectiveTextColor,
                    ),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    text,
                    style: TextStyle(
                      fontFamily: 'IBM Plex Sans Arabic',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: isDisabled ? Colors.grey : effectiveTextColor,
                    ),
                  ),
                  if (icon != null && iconRight) ...[
                    const SizedBox(width: 8),
                    Icon(
                      icon,
                      size: 20,
                      color: isDisabled ? Colors.grey : effectiveTextColor,
                    ),
                  ],
                ],
              ),
      ),
    );
  }
}
