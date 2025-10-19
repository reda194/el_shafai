import 'package:flutter/material.dart';
import 'package:neurocare_app/core/constants/app_colors.dart';

class DropdownField<T> extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final T? value;
  final List<DropdownMenuItem<T>>? items;
  final Function(T?)? onChanged;
  final String? errorText;
  final bool enabled;
  final double borderRadius;
  final EdgeInsetsGeometry? contentPadding;

  const DropdownField({
    super.key,
    this.labelText,
    this.hintText,
    this.value,
    this.items,
    this.onChanged,
    this.errorText,
    this.enabled = true,
    this.borderRadius = 12,
    this.contentPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (labelText != null) ...[
          Text(
            labelText!,
            style: const TextStyle(
              fontFamily: 'IBM Plex Sans Arabic',
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.primary,
            ),
            textAlign: TextAlign.right,
          ),
          const SizedBox(height: 8),
        ],
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: errorText != null ? Colors.red : const Color(0xFFE0E0E0),
              width: 1,
            ),
          ),
          child: DropdownButtonFormField<T>(
            initialValue: value,
            items: items,
            onChanged: enabled ? onChanged : null,
            hint: hintText != null
                ? Text(
                    hintText!,
                    style: const TextStyle(
                      fontFamily: 'IBM Plex Sans Arabic',
                      fontSize: 14,
                      color: Color(0xFF888888),
                    ),
                    textAlign: TextAlign.right,
                  )
                : null,
            style: const TextStyle(
              fontFamily: 'IBM Plex Sans Arabic',
              fontSize: 16,
              color: AppColors.primary,
            ),
            decoration: InputDecoration(
              contentPadding: contentPadding ??
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              border: InputBorder.none,
              errorText: errorText,
              errorStyle: const TextStyle(
                fontFamily: 'IBM Plex Sans Arabic',
                fontSize: 12,
                color: Colors.red,
              ),
            ),
            dropdownColor: Colors.white,
            icon: const Icon(
              Icons.keyboard_arrow_down,
              color: AppColors.homeSecondaryText,
            ),
            isExpanded: true,
            alignment: AlignmentDirectional.centerEnd,
          ),
        ),
      ],
    );
  }
}
