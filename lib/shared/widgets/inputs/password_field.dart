import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:neurocare_app/core/constants/app_colors.dart';
import 'package:neurocare_app/shared/widgets/inputs/custom_text_field.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final String? errorText;
  final bool enabled;
  final bool readOnly;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final String? Function(String?)? validator;
  final AutovalidateMode? autovalidateMode;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final EdgeInsetsGeometry? contentPadding;

  const PasswordField({
    super.key,
    this.controller,
    this.labelText,
    this.hintText,
    this.errorText,
    this.enabled = true,
    this.readOnly = false,
    this.onChanged,
    this.onSubmitted,
    this.validator,
    this.autovalidateMode,
    this.inputFormatters,
    this.maxLength,
    this.contentPadding,
  });

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = true;
  }

  String? _defaultValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'كلمة المرور مطلوبة';
    }
    if (value.length < 8) {
      return 'كلمة المرور يجب أن تكون 8 أحرف على الأقل';
    }
    // Check for at least one uppercase letter
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'كلمة المرور يجب أن تحتوي على حرف كبير واحد على الأقل';
    }
    // Check for at least one lowercase letter
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'كلمة المرور يجب أن تحتوي على حرف صغير واحد على الأقل';
    }
    // Check for at least one digit
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'كلمة المرور يجب أن تحتوي على رقم واحد على الأقل';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: widget.controller,
      labelText: widget.labelText ?? 'كلمة المرور',
      hintText: widget.hintText ?? 'أدخل كلمة المرور',
      errorText: widget.errorText,
      obscureText: _obscureText,
      enabled: widget.enabled,
      readOnly: widget.readOnly,
      onChanged: widget.onChanged,
      onSubmitted: widget.onSubmitted,
      validator: widget.validator ?? _defaultValidator,
      autovalidateMode: widget.autovalidateMode,
      inputFormatters: widget.inputFormatters,
      maxLength: widget.maxLength,
      contentPadding: widget.contentPadding,
      suffixIcon: IconButton(
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
    );
  }
}
