import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:neurocare_app/core/constants/app_colors.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final String? errorText;
  final bool obscureText;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLines;
  final int? maxLength;
  final bool enabled;
  final bool readOnly;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? prefixText;
  final String? suffixText;
  final VoidCallback? onTap;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final Function()? onEditingComplete;
  final String? Function(String?)? validator;
  final AutovalidateMode? autovalidateMode;
  final TextDirection? textDirection;
  final TextAlign textAlign;
  final EdgeInsetsGeometry? contentPadding;
  final double borderRadius;
  final bool showCounter;

  const CustomTextField({
    super.key,
    this.controller,
    this.labelText,
    this.hintText,
    this.errorText,
    this.obscureText = false,
    this.keyboardType,
    this.inputFormatters,
    this.maxLines = 1,
    this.maxLength,
    this.enabled = true,
    this.readOnly = false,
    this.prefixIcon,
    this.suffixIcon,
    this.prefixText,
    this.suffixText,
    this.onTap,
    this.onChanged,
    this.onSubmitted,
    this.onEditingComplete,
    this.validator,
    this.autovalidateMode,
    this.textDirection,
    this.textAlign = TextAlign.right,
    this.contentPadding,
    this.borderRadius = 12,
    this.showCounter = false,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (widget.labelText != null) ...[
          Text(
            widget.labelText!,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.primary,
            ),
            textAlign: TextAlign.right,
          ),
          const SizedBox(height: 8),
        ],
        TextFormField(
          controller: widget.controller,
          obscureText: _obscureText,
          keyboardType: widget.keyboardType,
          inputFormatters: widget.inputFormatters,
          maxLines: widget.maxLines,
          maxLength: widget.maxLength,
          enabled: widget.enabled,
          readOnly: widget.readOnly,
          onTap: widget.onTap,
          onChanged: widget.onChanged,
          onFieldSubmitted: widget.onSubmitted,
          onEditingComplete: widget.onEditingComplete,
          validator: widget.validator,
          autovalidateMode:
              widget.autovalidateMode ?? AutovalidateMode.onUserInteraction,
          textDirection: widget.textDirection ?? TextDirection.rtl,
          textAlign: widget.textAlign,
          style: const TextStyle(
            fontSize: 16,
            color: AppColors.primary,
          ),
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: const TextStyle(
              fontSize: 14,
              color: AppColors.homeSecondaryText,
            ),
            errorText: widget.errorText,
            errorStyle: const TextStyle(
              fontSize: 12,
              color: Colors.red,
            ),
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.obscureText
                ? Semantics(
                    label: _obscureText
                        ? 'إظهار كلمة المرور'
                        : 'إخفاء كلمة المرور',
                    button: true,
                    child: IconButton(
                      iconSize: 24,
                      padding: const EdgeInsets.all(12),
                      constraints: const BoxConstraints(
                        minWidth: 48,
                        minHeight: 48,
                      ),
                      icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                        color: AppColors.homeSecondaryText,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                  )
                : widget.suffixIcon,
            prefixText: widget.prefixText,
            suffixText: widget.suffixText,
            prefixStyle: const TextStyle(
              fontSize: 16,
              color: AppColors.primary,
            ),
            suffixStyle: const TextStyle(
              fontSize: 16,
              color: AppColors.primary,
            ),
            contentPadding: widget.contentPadding ??
                const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: const BorderSide(
                color: AppColors.border,
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: const BorderSide(
                color: AppColors.border,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: const BorderSide(
                color: AppColors.primary,
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: const BorderSide(
                color: Colors.red,
                width: 1,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: const BorderSide(
                color: Colors.red,
                width: 2,
              ),
            ),
            counterText: widget.showCounter ? null : '',
          ),
        ),
      ],
    );
  }
}
