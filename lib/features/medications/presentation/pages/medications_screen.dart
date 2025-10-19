import 'package:flutter/material.dart';
import '../../../../core/constants/app_dimensions.dart';

class MedicationsScreen extends StatelessWidget {
  const MedicationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Medications'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Navigate to add medication screen
              Navigator.of(context).pushNamed('/add-medication');
            },
          ),
        ],
      ),
      body: const MedicationsView(),
    );
  }
}

class MedicationsView extends StatelessWidget {
  const MedicationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDimensions.paddingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search bar
          TextField(
            decoration: InputDecoration(
              hintText: 'Search medications...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
              ),
            ),
            onChanged: (query) {
              // TODO: Implement search functionality
            },
          ),
          const SizedBox(height: AppDimensions.paddingMedium),

          // Filter chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                FilterChip(
                  label: const Text('All'),
                  selected: true,
                  onSelected: (selected) {
                    // TODO: Implement filter functionality
                  },
                ),
                const SizedBox(width: AppDimensions.paddingSmall),
                FilterChip(
                  label: const Text('Active'),
                  selected: false,
                  onSelected: (selected) {
                    // TODO: Implement filter functionality
                  },
                ),
                const SizedBox(width: AppDimensions.paddingSmall),
                FilterChip(
                  label: const Text('Completed'),
                  selected: false,
                  onSelected: (selected) {
                    // TODO: Implement filter functionality
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: AppDimensions.paddingMedium),

          // Medications list placeholder
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.medical_services_outlined,
                      size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  const Text(
                    'No medications found',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to add medication screen
                      Navigator.of(context).pushNamed('/add-medication');
                    },
                    child: const Text('Add Medication'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
