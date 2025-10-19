import 'package:flutter/material.dart';
import 'package:neurocare_app/core/constants/app_colors.dart';
import 'package:neurocare_app/shared/widgets/buttons/primary_button.dart';

class ErrorWidget extends StatelessWidget {
  final String title;
  final String message;
  final String? buttonText;
  final VoidCallback? onRetry;
  final IconData icon;
  final Color? iconColor;

  const ErrorWidget({
    super.key,
    this.title = 'حدث خطأ',
    this.message = 'يرجى المحاولة مرة أخرى',
    this.buttonText,
    this.onRetry,
    this.icon = Icons.error_outline,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Error Icon
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: (iconColor ?? Colors.red).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 40,
                color: iconColor ?? Colors.red,
              ),
            ),

            const SizedBox(height: 24),

            // Title
            Text(
              title,
              style: const TextStyle(
                fontFamily: 'IBM Plex Sans Arabic',
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 12),

            // Message
            Text(
              message,
              style: const TextStyle(
                fontFamily: 'IBM Plex Sans Arabic',
                fontSize: 16,
                color: AppColors.homeSecondaryText,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 32),

            // Retry Button
            if (onRetry != null)
              PrimaryButton(
                text: buttonText ?? 'إعادة المحاولة',
                onPressed: onRetry,
                width: 200,
              ),
          ],
        ),
      ),
    );
  }
}
