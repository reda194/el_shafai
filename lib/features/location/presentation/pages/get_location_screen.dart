import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:neurocare_app/core/constants/app_colors.dart';
import 'package:neurocare_app/core/routes/route_names.dart';
import 'package:neurocare_app/shared/widgets/buttons/primary_button.dart';
import 'package:neurocare_app/shared/widgets/buttons/secondary_button.dart';
import 'package:neurocare_app/shared/widgets/common/bottom_nav_bar.dart';

class GetLocationScreen extends StatefulWidget {
  const GetLocationScreen({super.key});

  @override
  State<GetLocationScreen> createState() => _GetLocationScreenState();
}

class _GetLocationScreenState extends State<GetLocationScreen>
    with TickerProviderStateMixin {
  late AnimationController _locationController;
  late Animation<double> _locationAnimation;

  bool _isGettingLocation = false;
  bool _locationObtained = false;
  String _currentAddress = '';
  Map<String, double>? _currentCoordinates;

  @override
  void initState() {
    super.initState();

    _locationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    _locationAnimation = Tween<double>(
      begin: 1.0,
      end: 1.3,
    ).animate(CurvedAnimation(
      parent: _locationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _locationController.dispose();
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
          'تحديد الموقع',
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
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
        child: Column(
          children: [
            // Location Icon Animation
            _buildLocationIcon(),

            const SizedBox(height: 40),

            // Title
            Text(
              _getTitleText(),
              style: const TextStyle(
                fontFamily: 'IBM Plex Sans Arabic',
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
                height: 1.2,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 16),

            // Subtitle
            Text(
              _getSubtitleText(),
              style: const TextStyle(
                fontFamily: 'IBM Plex Sans Arabic',
                fontSize: 16,
                color: AppColors.homeSecondaryText,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 40),

            // Location Display (when obtained)
            if (_locationObtained) _buildLocationDisplay(),

            // Progress Indicator (when getting location)
            if (_isGettingLocation) _buildProgressIndicator(),

            const SizedBox(height: 40),

            // Action Buttons
            _buildActionButtons(),

            const SizedBox(height: 40),

            // Manual Entry Option
            _buildManualEntryOption(),

            const SizedBox(height: 100), // Space for bottom navigation
          ],
        ),
      ),
      bottomNavigationBar:
          const BottomNavBar(currentIndex: -1), // Not in main nav
    );
  }

  Widget _buildLocationIcon() {
    return AnimatedBuilder(
      animation: _locationAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _isGettingLocation ? _locationAnimation.value : 1.0,
          child: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: _getIconBackgroundColor(),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: _getIconBackgroundColor().withOpacity(0.3),
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Icon(
              _getIconData(),
              color: Colors.white,
              size: 60,
            ),
          ),
        );
      },
    );
  }

  Widget _buildLocationDisplay() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Location Icon
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(25),
            ),
            child: const Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 30,
            ),
          ),

          const SizedBox(height: 16),

          // Address
          Text(
            _currentAddress.isNotEmpty ? _currentAddress : 'العنوان غير محدد',
            style: const TextStyle(
              fontFamily: 'IBM Plex Sans Arabic',
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 8),

          // Coordinates (if available)
          if (_currentCoordinates != null)
            Text(
              '${_currentCoordinates!['lat']?.toStringAsFixed(4)}, ${_currentCoordinates!['lng']?.toStringAsFixed(4)}',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
                fontFamily: 'monospace',
              ),
              textDirection: TextDirection.ltr,
            ),

          const SizedBox(height: 16),

          // Success Message
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'تم تحديد الموقع بنجاح',
              style: TextStyle(
                fontFamily: 'IBM Plex Sans Arabic',
                fontSize: 14,
                color: Colors.green,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: const Column(
        children: [
          SizedBox(
            width: 40,
            height: 40,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          ),
          SizedBox(height: 16),
          Text(
            'جاري تحديد موقعك...',
            style: TextStyle(
              fontFamily: 'IBM Plex Sans Arabic',
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.primary,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'يرجى التأكد من تشغيل خدمة الموقع على جهازك',
            style: TextStyle(
              fontFamily: 'IBM Plex Sans Arabic',
              fontSize: 14,
              color: AppColors.homeSecondaryText,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    if (_locationObtained) {
      return Column(
        children: [
          PrimaryButton(
            text: 'تأكيد الموقع',
            onPressed: _confirmLocation,
          ),
          const SizedBox(height: 16),
          SecondaryButton(
            text: 'تحديد موقع آخر',
            onPressed: _resetLocation,
          ),
        ],
      );
    } else {
      return PrimaryButton(
        text: _isGettingLocation ? 'جاري التحديد...' : 'تحديد الموقع الحالي',
        onPressed: _isGettingLocation ? null : _getCurrentLocation,
        isLoading: _isGettingLocation,
      );
    }
  }

  Widget _buildManualEntryOption() {
    return InkWell(
      onTap: () => context.push(RouteNames.enterLocation),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.grey.shade200,
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.edit_location,
              color: AppColors.primary,
              size: 20,
            ),
            SizedBox(width: 8),
            Text(
              'إدخال الموقع يدوياً',
              style: TextStyle(
                fontFamily: 'IBM Plex Sans Arabic',
                fontSize: 16,
                color: AppColors.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getTitleText() {
    if (_locationObtained) {
      return 'تم تحديد موقعك!';
    } else if (_isGettingLocation) {
      return 'جاري تحديد موقعك';
    } else {
      return 'حدد موقعك';
    }
  }

  String _getSubtitleText() {
    if (_locationObtained) {
      return 'تم تحديد موقعك بنجاح. يمكنك المتابعة أو اختيار موقع آخر.';
    } else if (_isGettingLocation) {
      return 'نحتاج إذن الوصول لموقعك لنتمكن من مساعدتك في العثور على أقرب الأطباء والمستشفيات.';
    } else {
      return 'اسمح لنا بالوصول لموقعك لنعرض لك أقرب الأطباء والمستشفيات والصيدليات.';
    }
  }

  IconData _getIconData() {
    if (_locationObtained) {
      return Icons.check_circle;
    } else if (_isGettingLocation) {
      return Icons.my_location;
    } else {
      return Icons.location_searching;
    }
  }

  Color _getIconBackgroundColor() {
    if (_locationObtained) {
      return Colors.green;
    } else if (_isGettingLocation) {
      return Colors.blue;
    } else {
      return AppColors.primary;
    }
  }

  void _getCurrentLocation() async {
    setState(() {
      _isGettingLocation = true;
    });

    // Simulate location fetching
    await Future.delayed(const Duration(seconds: 3));

    if (mounted) {
      setState(() {
        _isGettingLocation = false;
        _locationObtained = true;
        _currentAddress = 'شارع التحرير، القاهرة، مصر';
        _currentCoordinates = {
          'lat': 30.0444,
          'lng': 31.2357,
        };
      });
    }
  }

  void _confirmLocation() {
    // TODO: Save location and navigate back
    final locationData = {
      'address': _currentAddress,
      'coordinates': _currentCoordinates,
    };

    context.pop(locationData);
  }

  void _resetLocation() {
    setState(() {
      _locationObtained = false;
      _currentAddress = '';
      _currentCoordinates = null;
    });
  }
}
