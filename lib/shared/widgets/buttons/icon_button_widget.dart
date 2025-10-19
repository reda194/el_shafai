import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:neurocare_app/core/constants/app_colors.dart';

class IconButtonWidget extends StatelessWidget {
  final String? iconPath; // For SVG assets
  final IconData? icon; // For Material Icons
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isDisabled;
  final double size;
  final Color? iconColor;
  final Color? backgroundColor;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;

  const IconButtonWidget({
    super.key,
    this.iconPath,
    this.icon,
    required this.onPressed,
    this.isLoading = false,
    this.isDisabled = false,
    this.size = 48,
    this.iconColor,
    this.backgroundColor,
    this.borderRadius,
    this.padding,
  }) : assert(iconPath != null || icon != null,
            'Either iconPath or icon must be provided');

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (isLoading || isDisabled) ? null : onPressed,
      child: Container(
        width: size,
        height: size,
        padding: padding ?? const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isDisabled
              ? Colors.grey.shade200
              : backgroundColor ?? AppColors.authButtonTransparent,
          borderRadius: BorderRadius.circular(borderRadius ?? size / 2),
        ),
        child: isLoading
            ? SizedBox(
                height: 16,
                width: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    isDisabled ? Colors.grey : (iconColor ?? AppColors.primary),
                  ),
                ),
              )
            : (iconPath != null
                ? SvgPicture.asset(
                    iconPath!,
                    width: size * 0.5,
                    height: size * 0.5,
                    colorFilter: ColorFilter.mode(
                      isDisabled
                          ? Colors.grey
                          : (iconColor ?? AppColors.primary),
                      BlendMode.srcIn,
                    ),
                  )
                : Icon(
                    icon!,
                    size: size * 0.5,
                    color: isDisabled
                        ? Colors.grey
                        : (iconColor ?? AppColors.primary),
                  )),
      ),
    );
  }
}
