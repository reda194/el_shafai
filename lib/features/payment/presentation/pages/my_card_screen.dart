import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:neurocare_app/core/constants/app_colors.dart';
import 'package:neurocare_app/core/routes/route_names.dart';
import 'package:neurocare_app/shared/widgets/buttons/primary_button.dart';
import 'package:neurocare_app/shared/widgets/common/empty_state.dart';

class MyCardScreen extends StatefulWidget {
  const MyCardScreen({super.key});

  @override
  State<MyCardScreen> createState() => _MyCardScreenState();
}

class _MyCardScreenState extends State<MyCardScreen> {
  // Mock data for demonstration
  final List<Map<String, dynamic>> _savedCards = [
    {
      'id': '1',
      'type': 'visa',
      'lastFourDigits': '4242',
      'cardHolderName': 'أحمد محمد',
      'expiryDate': '12/26',
      'isDefault': true,
    },
    {
      'id': '2',
      'type': 'mastercard',
      'lastFourDigits': '8888',
      'cardHolderName': 'سارة أحمد',
      'expiryDate': '08/25',
      'isDefault': false,
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
          'بطاقاتي المحفوظة',
          style: TextStyle(
            fontFamily: 'IBM Plex Sans Arabic',
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: AppColors.primary,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.add,
              color: AppColors.primary,
            ),
            onPressed: () => context.push(RouteNames.addPaymentMethod),
          ),
        ],
      ),
      body: _savedCards.isEmpty ? _buildEmptyState() : _buildCardsList(),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        child: PrimaryButton(
          text: 'إضافة بطاقة جديدة',
          onPressed: () => context.push(RouteNames.addPaymentMethod),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return EmptyState(
      title: 'لا توجد بطاقات محفوظة',
      message:
          'لم تقم بإضافة أي بطاقات دفع بعد. أضف بطاقتك الأولى لتسهيل عملية الدفع.',
      buttonText: 'إضافة بطاقة',
      onButtonPressed: () => context.push(RouteNames.addPaymentMethod),
      icon: Icons.credit_card,
      iconColor: AppColors.primary,
    );
  }

  Widget _buildCardsList() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Text(
            'البطاقات المحفوظة',
            style: TextStyle(
              fontFamily: 'IBM Plex Sans Arabic',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
            textAlign: TextAlign.right,
          ),

          const SizedBox(height: 16),

          ..._savedCards.map((card) => _buildCardItem(card)),

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
                    'جميع البطاقات محمية بتشفير 256-bit SSL ولا نحتفظ بأرقام البطاقات الكاملة',
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

          const SizedBox(height: 100), // Space for bottom button
        ],
      ),
    );
  }

  Widget _buildCardItem(Map<String, dynamic> card) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: GestureDetector(
        onTap: () => _showCardOptions(card),
        child: Container(
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: _getCardGradient(card['type']),
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
                  size: 28,
                ),
              ),

              // Card Type Logo
              Positioned(
                top: 20,
                left: 20,
                child: _getCardTypeIcon(card['type']),
              ),

              // Default Badge
              if (card['isDefault'])
                Positioned(
                  top: 12,
                  right: 60,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'افتراضي',
                      style: TextStyle(
                        fontFamily: 'IBM Plex Sans Arabic',
                        fontSize: 10,
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

              // Card Number
              Positioned(
                bottom: 60,
                right: 20,
                left: 20,
                child: Text(
                  '•••• •••• •••• ${card['lastFourDigits']}',
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
                bottom: 25,
                right: 20,
                child: Text(
                  card['cardHolderName'],
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
                bottom: 25,
                left: 20,
                child: Text(
                  card['expiryDate'],
                  style: const TextStyle(
                    fontFamily: 'IBM Plex Sans Arabic',
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                  textDirection: TextDirection.ltr,
                ),
              ),

              // Menu Button
              Positioned(
                bottom: 12,
                left: 12,
                child: IconButton(
                  icon: const Icon(
                    Icons.more_vert,
                    color: Colors.white,
                    size: 20,
                  ),
                  onPressed: () => _showCardOptions(card),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getCardTypeIcon(String type) {
    switch (type) {
      case 'visa':
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(6),
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
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(6),
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
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(6),
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
            borderRadius: BorderRadius.circular(6),
          ),
          child: const Icon(
            Icons.credit_card,
            color: Colors.white,
            size: 16,
          ),
        );
    }
  }

  List<Color> _getCardGradient(String type) {
    switch (type) {
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

  void _showCardOptions(Map<String, dynamic> card) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            const SizedBox(height: 20),

            // Options
            _buildOptionItem(
              icon: Icons.visibility,
              title: 'عرض التفاصيل',
              onTap: () {
                Navigator.pop(context);
                // TODO: Navigate to card details
              },
            ),

            if (!card['isDefault'])
              _buildOptionItem(
                icon: Icons.star_border,
                title: 'تعيين كافتراضي',
                onTap: () {
                  Navigator.pop(context);
                  _setAsDefault(card);
                },
              ),

            _buildOptionItem(
              icon: Icons.edit,
              title: 'تعديل البطاقة',
              onTap: () {
                Navigator.pop(context);
                // TODO: Navigate to edit card
              },
            ),

            const Divider(),

            _buildOptionItem(
              icon: Icons.delete,
              title: 'حذف البطاقة',
              textColor: Colors.red,
              onTap: () {
                Navigator.pop(context);
                _showDeleteConfirmation(card);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionItem({
    required IconData icon,
    required String title,
    Color? textColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          children: [
            Icon(
              icon,
              color: textColor ?? AppColors.primary,
              size: 24,
            ),
            const SizedBox(width: 16),
            Text(
              title,
              style: TextStyle(
                fontFamily: 'IBM Plex Sans Arabic',
                fontSize: 16,
                color: textColor ?? AppColors.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              color: textColor ?? AppColors.homeSecondaryText,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  void _setAsDefault(Map<String, dynamic> card) {
    setState(() {
      for (var savedCard in _savedCards) {
        savedCard['isDefault'] = savedCard['id'] == card['id'];
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تم تعيين البطاقة كافتراضية')),
    );
  }

  void _showDeleteConfirmation(Map<String, dynamic> card) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'حذف البطاقة',
          style: TextStyle(
            fontFamily: 'IBM Plex Sans Arabic',
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.right,
        ),
        content: Text(
          'هل أنت متأكد من حذف بطاقة ${card['type']} المنتهية بـ ${card['lastFourDigits']}؟',
          style: const TextStyle(
            fontFamily: 'IBM Plex Sans Arabic',
          ),
          textAlign: TextAlign.right,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'إلغاء',
              style: TextStyle(
                fontFamily: 'IBM Plex Sans Arabic',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _deleteCard(card);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text(
              'حذف',
              style: TextStyle(
                fontFamily: 'IBM Plex Sans Arabic',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _deleteCard(Map<String, dynamic> card) {
    setState(() {
      _savedCards.removeWhere((savedCard) => savedCard['id'] == card['id']);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تم حذف البطاقة')),
    );
  }
}
