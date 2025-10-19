import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:neurocare_app/core/constants/app_colors.dart';
import 'package:neurocare_app/shared/widgets/loading/loading_indicator.dart';

class NetworkImageWidget extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final Widget? placeholder;
  final Widget? errorWidget;
  final Color? backgroundColor;

  const NetworkImageWidget({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.placeholder,
    this.errorWidget,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: borderRadius,
      ),
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.zero,
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          width: width,
          height: height,
          fit: fit,
          placeholder: (context, url) =>
              placeholder ??
              const Center(
                child: LoadingIndicator(size: 24),
              ),
          errorWidget: (context, url, error) =>
              errorWidget ??
              Container(
                color: AppColors.homeSecondaryText.withOpacity(0.1),
                child: const Icon(
                  Icons.broken_image,
                  color: AppColors.homeSecondaryText,
                ),
              ),
        ),
      ),
    );
  }
}

class CircleNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double radius;
  final Color? backgroundColor;
  final Widget? placeholder;
  final Widget? errorWidget;

  const CircleNetworkImage({
    super.key,
    required this.imageUrl,
    this.radius = 40,
    this.backgroundColor,
    this.placeholder,
    this.errorWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius * 2,
      height: radius * 2,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor,
      ),
      child: ClipOval(
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          width: radius * 2,
          height: radius * 2,
          fit: BoxFit.cover,
          placeholder: (context, url) =>
              placeholder ??
              Container(
                color: AppColors.homeSecondaryText.withOpacity(0.1),
                child: const LoadingIndicator(size: 20),
              ),
          errorWidget: (context, url, error) =>
              errorWidget ??
              Container(
                color: AppColors.homeSecondaryText.withOpacity(0.1),
                child: Icon(
                  Icons.person,
                  color: AppColors.homeSecondaryText,
                  size: radius,
                ),
              ),
        ),
      ),
    );
  }
}
