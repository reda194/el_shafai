import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:neurocare_app/core/constants/app_colors.dart';
import 'package:neurocare_app/shared/widgets/buttons/primary_button.dart';
import 'package:neurocare_app/shared/widgets/buttons/secondary_button.dart';
import 'package:neurocare_app/shared/widgets/inputs/custom_text_field.dart';

class CardDetailsScreen extends StatefulWidget {
  const CardDetailsScreen({super.key});

  @override
  State<CardDetailsScreen> createState() => _CardDetailsScreenState();
}

class _CardDetailsScreenState extends State<CardDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _cardNumberController = TextEditingController();
  final _cardHolderController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvvController = TextEditingController();

  bool _isLoading = false;
  String _cardType = 'visa'; // visa, mastercard, amex

  @override
  void dispose() {
    _cardNumberController.dispose();
    _cardHolderController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.onboardingBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.primary,
          ),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'تفاصيل البطاقة',
          style: TextStyle(
            fontFamily: 'IBM Plex Sans Arabic',
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: AppColors.primary,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Card Preview
              _buildCardPreview(),

              const SizedBox(height: 32),

              // Card Number Field
              CustomTextField(
                controller: _cardNumberController,
                labelText: 'رقم البطاقة',
                hintText: '1234 5678 9012 3456',
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(19),
                  _CardNumberFormatter(),
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'رقم البطاقة مطلوب';
                  }
                  final cleanNumber = value.replaceAll(' ', '');
                  if (cleanNumber.length < 13 || cleanNumber.length > 19) {
                    return 'رقم البطاقة غير صحيح';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _cardType = _getCardType(value.replaceAll(' ', ''));
                  });
                },
              ),

              const SizedBox(height: 24),

              // Card Holder Name Field
              CustomTextField(
                controller: _cardHolderController,
                labelText: 'اسم صاحب البطاقة',
                hintText: 'أدخل الاسم كما هو مكتوب على البطاقة',
                textDirection: TextDirection.ltr,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'اسم صاحب البطاقة مطلوب';
                  }
                  if (value.length < 2) {
                    return 'الاسم يجب أن يكون حرفين على الأقل';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 24),

              // Expiry Date & CVV Row
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller: _expiryController,
                      labelText: 'تاريخ الانتهاء',
                      hintText: 'MM/YY',
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(4),
                        _ExpiryDateFormatter(),
                      ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'تاريخ الانتهاء مطلوب';
                        }
                        if (value.length != 5) {
                          return 'تاريخ غير صحيح';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: CustomTextField(
                      controller: _cvvController,
                      labelText: 'CVV',
                      hintText: '123',
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(4),
                      ],
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'CVV مطلوب';
                        }
                        if (value.length < 3 || value.length > 4) {
                          return 'CVV غير صحيح';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Security Info
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.blue.withOpacity(0.3),
                  ),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.security,
                      color: Colors.blue,
                      size: 24,
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'جميع المعلومات محمية ومشفرة بأعلى مستويات الأمان',
                        style: TextStyle(
                          fontFamily: 'IBM Plex Sans Arabic',
                          fontSize: 14,
                          color: AppColors.primary,
                          height: 1.4,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Save Card Checkbox
              Row(
                children: [
                  Checkbox(
                    value: true,
                    onChanged: (value) {
                      // TODO: Implement save card toggle
                    },
                    activeColor: AppColors.primary,
                  ),
                  const Expanded(
                    child: Text(
                      'حفظ البطاقة للدفعات المستقبلية',
                      style: TextStyle(
                        fontFamily: 'IBM Plex Sans Arabic',
                        fontSize: 14,
                        color: AppColors.homeSecondaryText,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // Action Buttons
              PrimaryButton(
                text: 'إضافة البطاقة',
                onPressed: _handleAddCard,
                isLoading: _isLoading,
              ),

              const SizedBox(height: 16),

              SecondaryButton(
                text: 'إلغاء',
                onPressed: () => context.pop(),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardPreview() {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: _getCardGradient(),
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: const Offset(0, 4),
            blurRadius: 12,
          ),
        ],
      ),
      child: Stack(
        children: [
          // Card Chip
          Positioned(
            top: 20,
            right: 20,
            child: Icon(
              Icons.credit_card,
              color: Colors.white.withOpacity(0.8),
              size: 32,
            ),
          ),

          // Card Type Logo
          Positioned(
            top: 20,
            left: 20,
            child: _getCardTypeIcon(),
          ),

          // Card Number
          Positioned(
            bottom: 70,
            right: 20,
            left: 20,
            child: Text(
              _formatCardNumber(_cardNumberController.text),
              style: const TextStyle(
                fontFamily: 'IBM Plex Sans Arabic',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 2,
              ),
              textDirection: TextDirection.ltr,
            ),
          ),

          // Card Holder Name
          Positioned(
            bottom: 30,
            right: 20,
            child: Text(
              _cardHolderController.text.isEmpty
                  ? 'اسم صاحب البطاقة'
                  : _cardHolderController.text,
              style: const TextStyle(
                fontFamily: 'IBM Plex Sans Arabic',
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
              textDirection: TextDirection.ltr,
            ),
          ),

          // Expiry Date
          Positioned(
            bottom: 30,
            left: 20,
            child: Text(
              _expiryController.text.isEmpty ? 'MM/YY' : _expiryController.text,
              style: const TextStyle(
                fontFamily: 'IBM Plex Sans Arabic',
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
              textDirection: TextDirection.ltr,
            ),
          ),
        ],
      ),
    );
  }

  Widget _getCardTypeIcon() {
    switch (_cardType) {
      case 'visa':
        return Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(4),
          ),
          child: const Text(
            'VISA',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        );
      case 'mastercard':
        return Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(4),
          ),
          child: const Text(
            'MC',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        );
      case 'amex':
        return Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(4),
          ),
          child: const Text(
            'AMEX',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 10,
            ),
          ),
        );
      default:
        return Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(4),
          ),
          child: const Icon(
            Icons.credit_card,
            color: Colors.white,
            size: 16,
          ),
        );
    }
  }

  List<Color> _getCardGradient() {
    switch (_cardType) {
      case 'visa':
        return [const Color(0xFF1A1F71), const Color(0xFF0F3460)];
      case 'mastercard':
        return [const Color(0xFFEB001B), const Color(0xFFF79E1B)];
      case 'amex':
        return [const Color(0xFF006FCF), const Color(0xFF003B73)];
      default:
        return [AppColors.primary, AppColors.primary.withOpacity(0.7)];
    }
  }

  String _getCardType(String number) {
    if (number.startsWith('4')) return 'visa';
    if (number.startsWith('5') || number.startsWith('2')) return 'mastercard';
    if (number.startsWith('3')) return 'amex';
    return 'unknown';
  }

  String _formatCardNumber(String value) {
    final cleanNumber = value.replaceAll(' ', '');
    if (cleanNumber.isEmpty) return '•••• •••• •••• ••••';

    final formatted = cleanNumber
        .replaceAllMapped(
          RegExp(r'.{4}'),
          (match) => '${match.group(0)} ',
        )
        .trim();

    final masked = formatted.split(' ').map((group) {
      if (group.length == 4 &&
          cleanNumber.indexOf(group) < cleanNumber.length - 4) {
        return '••••';
      }
      return group;
    }).join(' ');

    return masked;
  }

  void _handleAddCard() {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _isLoading = true);

      // TODO: Implement add card logic
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() => _isLoading = false);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('تم إضافة البطاقة بنجاح')),
          );
          context.pop();
        }
      });
    }
  }
}

// Custom input formatters
class _CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text.replaceAll(' ', '');
    final buffer = StringBuffer();

    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      if ((i + 1) % 4 == 0 && i + 1 != text.length) {
        buffer.write(' ');
      }
    }

    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(
        offset: buffer.length,
      ),
    );
  }
}

class _ExpiryDateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text.replaceAll('/', '');
    final buffer = StringBuffer();

    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      if (i == 1 && i + 1 != text.length) {
        buffer.write('/');
      }
    }

    return TextEditingValue(
      text: buffer.length <= 5 ? buffer.toString() : oldValue.text,
      selection: TextSelection.collapsed(
        offset: buffer.length <= 5 ? buffer.length : oldValue.selection.end,
      ),
    );
  }
}
