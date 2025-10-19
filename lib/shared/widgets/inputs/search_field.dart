import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:neurocare_app/core/constants/app_assets.dart';
import 'package:neurocare_app/core/constants/app_colors.dart';

class SearchField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final VoidCallback? onClear;
  final bool showClearButton;
  final double borderRadius;
  final EdgeInsetsGeometry? contentPadding;

  const SearchField({
    super.key,
    this.controller,
    this.hintText,
    this.onChanged,
    this.onSubmitted,
    this.onClear,
    this.showClearButton = true,
    this.borderRadius = 12,
    this.contentPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 2),
            blurRadius: 8,
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.right,
        style: const TextStyle(
          fontFamily: 'IBM Plex Sans Arabic',
          fontSize: 16,
          color: AppColors.primary,
        ),
        decoration: InputDecoration(
          hintText: hintText ?? 'البحث عن طبيب...',
          hintStyle: const TextStyle(
            fontFamily: 'IBM Plex Sans Arabic',
            fontSize: 14,
            color: Color(0xFF888888),
          ),
          contentPadding: contentPadding ??
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          border: InputBorder.none,
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 16, right: 12),
            child: SvgPicture.asset(
              AppAssets.searchIcon,
              width: 20,
              height: 20,
              colorFilter: const ColorFilter.mode(
                AppColors.homeSecondaryText,
                BlendMode.srcIn,
              ),
            ),
          ),
          suffixIcon: showClearButton && controller?.text.isNotEmpty == true
              ? IconButton(
                  icon: const Icon(
                    Icons.clear,
                    color: AppColors.homeSecondaryText,
                    size: 20,
                  ),
                  onPressed: () {
                    controller?.clear();
                    onClear?.call();
                    onChanged?.call('');
                  },
                )
              : null,
        ),
      ),
    );
  }
}
