import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:neurocare_app/core/constants/app_colors.dart';
import 'package:neurocare_app/core/routes/route_names.dart';
import 'package:neurocare_app/shared/widgets/common/bottom_nav_bar.dart';

class NearbyMapScreen extends StatefulWidget {
  const NearbyMapScreen({super.key});

  @override
  State<NearbyMapScreen> createState() => _NearbyMapScreenState();
}

class _NearbyMapScreenState extends State<NearbyMapScreen> {
  String _selectedFilter = 'all';
  final List<String> _filters = ['all', 'hospitals', 'clinics', 'pharmacies'];

  // Mock data for nearby places
  final List<Map<String, dynamic>> _nearbyPlaces = [
    {
      'id': '1',
      'name': 'مستشفى القاهرة التخصصي',
      'type': 'hospital',
      'address': 'شارع التحرير، القاهرة',
      'distance': '2.3 كم',
      'rating': 4.8,
      'reviews': 125,
      'latitude': 30.0444,
      'longitude': 31.2357,
      'isOpen': true,
    },
    {
      'id': '2',
      'name': 'عيادة د. أحمد محمد',
      'type': 'clinic',
      'address': 'شارع الهرم، الجيزة',
      'distance': '1.8 كم',
      'rating': 4.9,
      'reviews': 89,
      'latitude': 30.0131,
      'longitude': 31.2089,
      'isOpen': true,
    },
    {
      'id': '3',
      'name': 'صيدلية الرحمة',
      'type': 'pharmacy',
      'address': 'شارع السودان، الجيزة',
      'distance': '0.9 كم',
      'rating': 4.6,
      'reviews': 45,
      'latitude': 30.0567,
      'longitude': 31.1978,
      'isOpen': true,
    },
    {
      'id': '4',
      'name': 'مركز الأشعة التشخيصية',
      'type': 'clinic',
      'address': 'شارع الهرم، الجيزة',
      'distance': '3.1 كم',
      'rating': 4.7,
      'reviews': 67,
      'latitude': 30.0123,
      'longitude': 31.2012,
      'isOpen': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.onboardingBackground,
      body: Stack(
        children: [
          // Map Background (Placeholder)
          _buildMapPlaceholder(),

          // Header
          _buildHeader(),

          // Filter Chips
          _buildFilterChips(),

          // Places List
          _buildPlacesList(),

          // Current Location Button
          _buildCurrentLocationButton(),

          // Search Button
          _buildSearchButton(),
        ],
      ),
      bottomNavigationBar:
          const BottomNavBar(currentIndex: -1), // Not in main nav
    );
  }

  Widget _buildMapPlaceholder() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.grey[200],
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.map,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'خريطة الموقع',
              style: TextStyle(
                fontFamily: 'IBM Plex Sans Arabic',
                fontSize: 18,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'سيتم عرض الخريطة هنا',
              style: TextStyle(
                fontFamily: 'IBM Plex Sans Arabic',
                fontSize: 14,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Positioned(
      top: 50,
      left: 20,
      right: 20,
      child: Row(
        children: [
          IconButton(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: const Icon(
                Icons.arrow_back,
                color: AppColors.primary,
              ),
            ),
            onPressed: () => context.pop(),
          ),
          const Spacer(),
          const Text(
            'المواقع القريبة',
            style: TextStyle(
              fontFamily: 'IBM Plex Sans Arabic',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const Spacer(),
          IconButton(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: const Icon(
                Icons.tune,
                color: AppColors.primary,
              ),
            ),
            onPressed: _showFilterDialog,
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChips() {
    return Positioned(
      top: 120,
      left: 20,
      right: 20,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: _filters.map((filter) => _buildFilterChip(filter)).toList(),
        ),
      ),
    );
  }

  Widget _buildFilterChip(String filter) {
    final isSelected = _selectedFilter == filter;
    final filterData = _getFilterData(filter);

    return Container(
      margin: const EdgeInsets.only(left: 8),
      child: FilterChip(
        label: Text(
          filterData['name'] ?? 'الكل',
          style: TextStyle(
            fontFamily: 'IBM Plex Sans Arabic',
            fontSize: 14,
            color: isSelected ? Colors.white : AppColors.primary,
            fontWeight: FontWeight.w500,
          ),
        ),
        selected: isSelected,
        onSelected: (selected) {
          setState(() {
            _selectedFilter = filter;
          });
        },
        backgroundColor: Colors.white,
        selectedColor: AppColors.primary,
        checkmarkColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: isSelected ? AppColors.primary : Colors.grey.shade300,
          ),
        ),
      ),
    );
  }

  Widget _buildPlacesList() {
    final filteredPlaces = _getFilteredPlaces();

    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 300,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Column(
          children: [
            // Handle
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            // List Header
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${filteredPlaces.length} نتيجة',
                    style: const TextStyle(
                      fontFamily: 'IBM Plex Sans Arabic',
                      fontSize: 14,
                      color: AppColors.homeSecondaryText,
                    ),
                  ),
                  const Text(
                    'الأماكن القريبة',
                    style: TextStyle(
                      fontFamily: 'IBM Plex Sans Arabic',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),

            // Places List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: filteredPlaces.length,
                itemBuilder: (context, index) {
                  return _buildPlaceCard(filteredPlaces[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceCard(Map<String, dynamic> place) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: () => _onPlaceTap(place),
        borderRadius: BorderRadius.circular(12),
        child: Row(
          children: [
            // Place Icon
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: _getPlaceColor(place['type']).withOpacity(0.1),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Icon(
                _getPlaceIcon(place['type']),
                color: _getPlaceColor(place['type']),
                size: 24,
              ),
            ),

            const SizedBox(width: 12),

            // Place Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Status Badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: place['isOpen']
                              ? Colors.green.withOpacity(0.1)
                              : Colors.red.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          place['isOpen'] ? 'مفتوح' : 'مغلق',
                          style: TextStyle(
                            fontFamily: 'IBM Plex Sans Arabic',
                            fontSize: 10,
                            color: place['isOpen'] ? Colors.green : Colors.red,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                      // Place Name
                      Expanded(
                        child: Text(
                          place['name'],
                          style: const TextStyle(
                            fontFamily: 'IBM Plex Sans Arabic',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary,
                          ),
                          textAlign: TextAlign.right,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 4),

                  // Address
                  Text(
                    place['address'],
                    style: const TextStyle(
                      fontFamily: 'IBM Plex Sans Arabic',
                      fontSize: 14,
                      color: AppColors.homeSecondaryText,
                    ),
                    textAlign: TextAlign.right,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 8),

                  // Rating and Distance
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Distance
                      Text(
                        place['distance'],
                        style: const TextStyle(
                          fontFamily: 'IBM Plex Sans Arabic',
                          fontSize: 12,
                          color: AppColors.homeSecondaryText,
                        ),
                      ),

                      // Rating
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 14,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${place['rating']} (${place['reviews']})',
                            style: const TextStyle(
                              fontFamily: 'IBM Plex Sans Arabic',
                              fontSize: 12,
                              color: AppColors.homeSecondaryText,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentLocationButton() {
    return Positioned(
      bottom: 320,
      right: 20,
      child: FloatingActionButton(
        onPressed: _centerOnCurrentLocation,
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.my_location,
          color: AppColors.primary,
        ),
      ),
    );
  }

  Widget _buildSearchButton() {
    return Positioned(
      bottom: 320,
      left: 20,
      child: FloatingActionButton(
        onPressed: () => context.push(RouteNames.enterLocation),
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.search,
          color: AppColors.primary,
        ),
      ),
    );
  }

  Map<String, String> _getFilterData(String filter) {
    switch (filter) {
      case 'all':
        return {'name': 'الكل', 'icon': '🏥'};
      case 'hospitals':
        return {'name': 'المستشفيات', 'icon': '🏥'};
      case 'clinics':
        return {'name': 'العيادات', 'icon': '🏥'};
      case 'pharmacies':
        return {'name': 'الصيدليات', 'icon': '💊'};
      default:
        return {'name': 'الكل', 'icon': '🏥'};
    }
  }

  List<Map<String, dynamic>> _getFilteredPlaces() {
    if (_selectedFilter == 'all') {
      return _nearbyPlaces;
    }
    return _nearbyPlaces
        .where((place) => place['type'] == _selectedFilter)
        .toList();
  }

  IconData _getPlaceIcon(String type) {
    switch (type) {
      case 'hospital':
        return Icons.local_hospital;
      case 'clinic':
        return Icons.medical_services;
      case 'pharmacy':
        return Icons.local_pharmacy;
      default:
        return Icons.place;
    }
  }

  Color _getPlaceColor(String type) {
    switch (type) {
      case 'hospital':
        return Colors.red;
      case 'clinic':
        return Colors.blue;
      case 'pharmacy':
        return Colors.green;
      default:
        return AppColors.primary;
    }
  }

  void _showFilterDialog() {
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
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text(
              'تصفية النتائج',
              style: TextStyle(
                fontFamily: 'IBM Plex Sans Arabic',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
              textAlign: TextAlign.right,
            ),
            const SizedBox(height: 20),
            ..._filters.map((filter) => _buildFilterOption(filter)),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterOption(String filter) {
    final filterData = _getFilterData(filter);
    final isSelected = _selectedFilter == filter;

    return InkWell(
      onTap: () {
        setState(() {
          _selectedFilter = filter;
        });
        Navigator.pop(context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Text(
              filterData['icon']!,
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(width: 12),
            Text(
              filterData['name'] ?? 'الكل',
              style: TextStyle(
                fontFamily: 'IBM Plex Sans Arabic',
                fontSize: 16,
                color: isSelected
                    ? AppColors.primary
                    : AppColors.homeSecondaryText,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
            const Spacer(),
            if (isSelected)
              const Icon(
                Icons.check,
                color: AppColors.primary,
              ),
          ],
        ),
      ),
    );
  }

  void _centerOnCurrentLocation() {
    // TODO: Implement center on current location
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تم التوجه للموقع الحالي')),
    );
  }

  void _onPlaceTap(Map<String, dynamic> place) {
    // TODO: Navigate to place details
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('تم اختيار: ${place['name']}')),
    );
  }
}
