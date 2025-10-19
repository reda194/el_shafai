import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:neurocare_app/core/constants/app_colors.dart';
import 'package:neurocare_app/core/routes/route_names.dart';
import 'package:neurocare_app/shared/widgets/inputs/custom_text_field.dart';
import 'package:neurocare_app/shared/widgets/common/bottom_nav_bar.dart';

class EnterLocationScreen extends StatefulWidget {
  const EnterLocationScreen({super.key});

  @override
  State<EnterLocationScreen> createState() => _EnterLocationScreenState();
}

class _EnterLocationScreenState extends State<EnterLocationScreen> {
  final TextEditingController _locationController = TextEditingController();
  final List<String> _recentLocations = [
    'القاهرة، مصر',
    'الجيزة، مصر',
    'الإسكندرية، مصر',
    'أسيوط، مصر',
    'المنصورة، مصر',
  ];

  final List<Map<String, dynamic>> _suggestedLocations = [
    {
      'name': 'الموقع الحالي',
      'address': 'تحديد الموقع تلقائياً',
      'icon': Icons.my_location,
      'type': 'current',
    },
    {
      'name': 'القاهرة',
      'address': 'القاهرة، مصر',
      'icon': Icons.location_city,
      'type': 'city',
    },
    {
      'name': 'مستشفى القاهرة التخصصي',
      'address': 'شارع التحرير، القاهرة',
      'icon': Icons.local_hospital,
      'type': 'hospital',
    },
    {
      'name': 'عيادة د. أحمد محمد',
      'address': 'شارع الهرم، الجيزة',
      'icon': Icons.medical_services,
      'type': 'clinic',
    },
  ];

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
          'إدخال الموقع',
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
            // Search Field
            CustomTextField(
              controller: _locationController,
              labelText: 'البحث عن موقع',
              hintText: 'أدخل اسم المدينة أو العنوان',
              prefixIcon: IconButton(
                icon: const Icon(
                  Icons.search,
                  color: AppColors.primary,
                ),
                onPressed: _searchLocation,
              ),
              suffixIcon: _locationController.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(
                        Icons.clear,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _locationController.clear();
                        });
                      },
                    )
                  : null,
            ),

            const SizedBox(height: 32),

            // Current Location Button
            _buildCurrentLocationButton(),

            const SizedBox(height: 32),

            // Suggested Locations
            _buildSuggestedLocations(),

            const SizedBox(height: 32),

            // Recent Locations
            if (_recentLocations.isNotEmpty) _buildRecentLocations(),

            const SizedBox(height: 100), // Space for bottom navigation
          ],
        ),
      ),
      bottomNavigationBar:
          const BottomNavBar(currentIndex: -1), // Not in main nav
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(RouteNames.nearbyMap),
        backgroundColor: AppColors.primary,
        child: const Icon(
          Icons.map,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildCurrentLocationButton() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: _getCurrentLocation,
        borderRadius: BorderRadius.circular(16),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(25),
              ),
              child: const Icon(
                Icons.my_location,
                color: AppColors.primary,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'استخدام الموقع الحالي',
                    style: TextStyle(
                      fontFamily: 'IBM Plex Sans Arabic',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  SizedBox(height: 4),
                  Text(
                    'تحديد موقعك تلقائياً',
                    style: TextStyle(
                      fontFamily: 'IBM Plex Sans Arabic',
                      fontSize: 14,
                      color: AppColors.homeSecondaryText,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: AppColors.homeSecondaryText,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuggestedLocations() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Text(
          'اقتراحات',
          style: TextStyle(
            fontFamily: 'IBM Plex Sans Arabic',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
          textAlign: TextAlign.right,
        ),
        const SizedBox(height: 16),
        ..._suggestedLocations.map((location) => _buildLocationItem(location)),
      ],
    );
  }

  Widget _buildRecentLocations() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: _clearRecentLocations,
              child: const Text(
                'مسح الكل',
                style: TextStyle(
                  fontFamily: 'IBM Plex Sans Arabic',
                  fontSize: 14,
                  color: AppColors.primary,
                ),
              ),
            ),
            const Text(
              'المواقع الأخيرة',
              style: TextStyle(
                fontFamily: 'IBM Plex Sans Arabic',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ..._recentLocations
            .map((location) => _buildRecentLocationItem(location)),
      ],
    );
  }

  Widget _buildLocationItem(Map<String, dynamic> location) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: () => _selectLocation(location),
        borderRadius: BorderRadius.circular(12),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: _getLocationColor(location['type']),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                location['icon'],
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    location['name'],
                    style: const TextStyle(
                      fontFamily: 'IBM Plex Sans Arabic',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    location['address'],
                    style: const TextStyle(
                      fontFamily: 'IBM Plex Sans Arabic',
                      fontSize: 14,
                      color: AppColors.homeSecondaryText,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentLocationItem(String location) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: const Icon(
          Icons.history,
          color: AppColors.homeSecondaryText,
        ),
        title: Text(
          location,
          style: const TextStyle(
            fontFamily: 'IBM Plex Sans Arabic',
            fontSize: 16,
            color: AppColors.primary,
          ),
          textAlign: TextAlign.right,
        ),
        trailing: IconButton(
          icon: const Icon(
            Icons.close,
            color: Colors.grey,
            size: 20,
          ),
          onPressed: () => _removeRecentLocation(location),
        ),
        onTap: () => _selectRecentLocation(location),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        tileColor: Colors.white,
      ),
    );
  }

  Color _getLocationColor(String type) {
    switch (type) {
      case 'current':
        return Colors.blue;
      case 'city':
        return Colors.green;
      case 'hospital':
        return Colors.red;
      case 'clinic':
        return Colors.orange;
      default:
        return AppColors.primary;
    }
  }

  void _searchLocation() {
    final query = _locationController.text.trim();
    if (query.isNotEmpty) {
      // TODO: Implement search functionality
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('البحث عن: $query')),
      );
    }
  }

  void _getCurrentLocation() {
    // TODO: Implement get current location
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('جاري تحديد الموقع الحالي...')),
    );
  }

  void _selectLocation(Map<String, dynamic> location) {
    // TODO: Navigate back with selected location
    context.pop(location);
  }

  void _selectRecentLocation(String location) {
    // TODO: Navigate back with selected location
    context.pop({'name': location, 'address': location});
  }

  void _clearRecentLocations() {
    setState(() {
      _recentLocations.clear();
    });
  }

  void _removeRecentLocation(String location) {
    setState(() {
      _recentLocations.remove(location);
    });
  }
}
