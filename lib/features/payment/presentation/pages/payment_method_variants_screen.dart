import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:neurocare_app/core/constants/app_assets.dart';
import 'package:neurocare_app/core/constants/app_colors.dart';
import 'package:neurocare_app/core/routes/route_names.dart';
import 'package:neurocare_app/shared/widgets/buttons/primary_button.dart';

class PaymentMethodVariantsScreen extends StatefulWidget {
  const PaymentMethodVariantsScreen({super.key});

  @override
  State<PaymentMethodVariantsScreen> createState() =>
      _PaymentMethodVariantsScreenState();
}

class _PaymentMethodVariantsScreenState
    extends State<PaymentMethodVariantsScreen> {
  String _selectedPaymentMethod = 'credit_card';

  final List<Map<String, dynamic>> _paymentMethods = [
    {
      'id': 'credit_card',
      'title': 'بطاقة ائتمانية أو خصم',
      'subtitle': 'فيزا، ماستركارد، أمريكان إكسبريس',
      'icon': Icons.credit_card,
      'available': true,
    },
    {
      'id': 'apple_pay',
      'title': 'Apple Pay',
      'subtitle': 'الدفع السريع والآمن',
      'iconPath': AppAssets.appleIcon,
      'available': false, // Not available on Android
    },
    {
      'id': 'google_pay',
      'title': 'Google Pay',
      'subtitle': 'الدفع السريع والآمن',
      'iconPath': AppAssets.googleIcon,
      'available': true,
    },
    {
      'id': 'paypal',
      'title': 'PayPal',
      'subtitle': 'الدفع عبر حساب PayPal',
      'icon': Icons.account_balance_wallet,
      'available': true,
    },
    {
      'id': 'bank_transfer',
      'title': 'تحويل بنكي',
      'subtitle': 'الدفع المباشر من حسابك البنكي',
      'icon': Icons.account_balance,
      'available': true,
    },
    {
      'id': 'cash_on_delivery',
      'title': 'الدفع عند الاستلام',
      'subtitle': 'ادفع نقدًا عند استلام الخدمة',
      'icon': Icons.money,
      'available': true,
    },
  ];

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
          'اختيار طريقة الدفع',
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
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Header
            const Text(
              'اختر طريقة الدفع المناسبة لك',
              style: TextStyle(
                fontFamily: 'IBM Plex Sans Arabic',
                fontSize: 16,
                color: AppColors.homeSecondaryText,
                height: 1.5,
              ),
              textAlign: TextAlign.right,
            ),

            const SizedBox(height: 32),

            // Payment Methods List
            ..._paymentMethods.map((method) => _buildPaymentMethodItem(method)),

            const SizedBox(height: 32),

            // Security Notice
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.green.withOpacity(0.3),
                ),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.security,
                    color: Colors.green,
                    size: 24,
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'جميع المعاملات محمية بتشفير SSL 256-bit ومعايير أمان PCI DSS',
                      style: TextStyle(
                        fontFamily: 'IBM Plex Sans Arabic',
                        fontSize: 14,
                        color: Colors.green,
                        height: 1.4,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Continue Button
            PrimaryButton(
              text: 'متابعة',
              onPressed:
                  _selectedPaymentMethod.isNotEmpty ? _handleContinue : null,
            ),

            const SizedBox(height: 100), // Space for bottom navigation
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethodItem(Map<String, dynamic> method) {
    final isSelected = _selectedPaymentMethod == method['id'];
    final isAvailable = method['available'] as bool;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Opacity(
        opacity: isAvailable ? 1.0 : 0.5,
        child: InkWell(
          onTap: isAvailable ? () => _selectPaymentMethod(method['id']) : null,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.primary.withOpacity(0.1)
                  : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected ? AppColors.primary : Colors.grey.shade200,
                width: isSelected ? 2 : 1,
              ),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.2),
                        offset: const Offset(0, 2),
                        blurRadius: 8,
                      ),
                    ]
                  : null,
            ),
            child: Row(
              children: [
                // Selection Indicator
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color:
                          isSelected ? AppColors.primary : Colors.grey.shade400,
                      width: 2,
                    ),
                  ),
                  child: isSelected
                      ? Container(
                          margin: const EdgeInsets.all(3),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primary,
                          ),
                        )
                      : null,
                ),

                const SizedBox(width: 16),

                // Icon
                _buildPaymentIcon(method),

                const SizedBox(width: 16),

                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        method['title'],
                        style: TextStyle(
                          fontFamily: 'IBM Plex Sans Arabic',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: isAvailable ? AppColors.primary : Colors.grey,
                        ),
                        textAlign: TextAlign.right,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        method['subtitle'],
                        style: TextStyle(
                          fontFamily: 'IBM Plex Sans Arabic',
                          fontSize: 14,
                          color: isAvailable
                              ? AppColors.homeSecondaryText
                              : Colors.grey.shade500,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ],
                  ),
                ),

                // Availability Indicator
                if (!isAvailable)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'غير متوفر',
                      style: TextStyle(
                        fontFamily: 'IBM Plex Sans Arabic',
                        fontSize: 10,
                        color: Colors.orange,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentIcon(Map<String, dynamic> method) {
    if (method.containsKey('iconPath')) {
      return SvgPicture.asset(
        method['iconPath'],
        width: 32,
        height: 32,
        colorFilter: const ColorFilter.mode(
          AppColors.primary,
          BlendMode.srcIn,
        ),
      );
    } else {
      return Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          method['icon'],
          color: AppColors.primary,
          size: 20,
        ),
      );
    }
  }

  void _selectPaymentMethod(String methodId) {
    setState(() {
      _selectedPaymentMethod = methodId;
    });
  }

  void _handleContinue() {
    final selectedMethod = _paymentMethods.firstWhere(
      (method) => method['id'] == _selectedPaymentMethod,
    );

    switch (_selectedPaymentMethod) {
      case 'credit_card':
        context.push(RouteNames.cardDetails);
        break;
      case 'apple_pay':
        _processApplePay();
        break;
      case 'google_pay':
        _processGooglePay();
        break;
      case 'paypal':
        _processPayPal();
        break;
      case 'bank_transfer':
        _processBankTransfer();
        break;
      case 'cash_on_delivery':
        _processCashOnDelivery();
        break;
      default:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('تم اختيار: ${selectedMethod['title']}')),
        );
    }
  }

  void _processApplePay() {
    // TODO: Implement Apple Pay integration
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('معالجة الدفع عبر Apple Pay...')),
    );
  }

  void _processGooglePay() {
    // TODO: Implement Google Pay integration
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('معالجة الدفع عبر Google Pay...')),
    );
  }

  void _processPayPal() {
    // TODO: Implement PayPal integration
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('معالجة الدفع عبر PayPal...')),
    );
  }

  void _processBankTransfer() {
    // TODO: Implement bank transfer flow
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('معالجة التحويل البنكي...')),
    );
  }

  void _processCashOnDelivery() {
    // TODO: Implement cash on delivery flow
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تم اختيار الدفع عند الاستلام')),
    );
  }
}
