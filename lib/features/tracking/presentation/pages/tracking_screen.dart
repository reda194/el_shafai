import 'package:flutter/material.dart';
import 'package:neurocare_app/core/constants/app_colors.dart';
import 'package:neurocare_app/features/tracking/domain/entities/health_metric_entity.dart';
import 'package:neurocare_app/shared/widgets/common/bottom_nav_bar.dart';

class TrackingScreen extends StatefulWidget {
  const TrackingScreen({super.key});

  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _timeRanges = ['أسبوع', 'شهر', '3 أشهر', 'سنة'];
  String _selectedTimeRange = 'أسبوع';

  // Mock data for demonstration
  final List<Map<String, dynamic>> _healthMetrics = [
    {
      'type': MetricType.weight,
      'name': 'الوزن',
      'value': 75.5,
      'unit': 'كجم',
      'change': -2.1,
      'changePercent': -2.7,
      'icon': Icons.monitor_weight,
      'color': Colors.blue,
      'data': [72.0, 73.5, 74.2, 75.1, 74.8, 75.5, 75.5],
    },
    {
      'type': MetricType.bloodPressure,
      'name': 'ضغط الدم',
      'value': '120/80',
      'unit': 'mmHg',
      'change': 5.0,
      'changePercent': 4.2,
      'icon': Icons.favorite,
      'color': Colors.red,
      'data': ['115/75', '118/78', '119/79', '120/80', '120/80'],
    },
    {
      'type': MetricType.heartRate,
      'name': 'معدل ضربات القلب',
      'value': 72,
      'unit': 'ض/د',
      'change': -3.0,
      'changePercent': -4.0,
      'icon': Icons.monitor_heart,
      'color': Colors.pink,
      'data': [68, 70, 75, 72, 72],
    },
    {
      'type': MetricType.bloodSugar,
      'name': 'سكر الدم',
      'value': 95,
      'unit': 'mg/dL',
      'change': -5.0,
      'changePercent': -5.0,
      'icon': Icons.science,
      'color': Colors.orange,
      'data': [90, 92, 98, 95, 95],
    },
    {
      'type': MetricType.sleep,
      'name': 'النوم',
      'value': 7.5,
      'unit': 'ساعة',
      'change': 0.5,
      'changePercent': 7.1,
      'icon': Icons.bedtime,
      'color': Colors.purple,
      'data': [6.5, 7.0, 7.2, 7.5, 7.5],
    },
    {
      'type': MetricType.steps,
      'name': 'الخطوات',
      'value': 8432,
      'unit': 'خطوة',
      'change': 1234,
      'changePercent': 17.1,
      'icon': Icons.directions_walk,
      'color': Colors.green,
      'data': [7200, 8500, 7800, 9200, 8432],
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _healthMetrics.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.onboardingBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'تتبع الصحة',
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
            onPressed: _showAddMetricDialog,
          ),
        ],
      ),
      body: Column(
        children: [
          // Time Range Selector
          _buildTimeRangeSelector(),

          // Metrics Tabs
          _buildMetricsTabs(),

          // Metric Details
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: _healthMetrics
                  .map((metric) => _buildMetricDetail(metric))
                  .toList(),
            ),
          ),

          const SizedBox(height: 100), // Space for bottom navigation
        ],
      ),
      bottomNavigationBar:
          const BottomNavBar(currentIndex: -1), // Not in main nav
      floatingActionButton: FloatingActionButton(
        onPressed: _showQuickAddDialog,
        backgroundColor: AppColors.primary,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildTimeRangeSelector() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _timeRanges.map((range) {
          final isSelected = _selectedTimeRange == range;
          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _selectedTimeRange = range),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  range,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'IBM Plex Sans Arabic',
                    fontSize: 14,
                    fontWeight:
                        isSelected ? FontWeight.w600 : FontWeight.normal,
                    color: isSelected ? Colors.white : AppColors.primary,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildMetricsTabs() {
    return Container(
      height: 60,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: TabBar(
        controller: _tabController,
        isScrollable: true,
        indicator: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(12),
        ),
        labelColor: Colors.white,
        unselectedLabelColor: AppColors.primary,
        tabs: _healthMetrics.map((metric) {
          return Tab(
            child: Row(
              children: [
                Icon(
                  metric['icon'],
                  size: 20,
                  color: _tabController.index == _healthMetrics.indexOf(metric)
                      ? Colors.white
                      : metric['color'],
                ),
                const SizedBox(width: 8),
                Text(
                  metric['name'],
                  style: const TextStyle(
                    fontFamily: 'IBM Plex Sans Arabic',
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildMetricDetail(Map<String, dynamic> metric) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Metric Header
          _buildMetricHeader(metric),

          const SizedBox(height: 24),

          // Chart Placeholder
          _buildChartPlaceholder(metric),

          const SizedBox(height: 24),

          // Statistics
          _buildStatistics(metric),

          const SizedBox(height: 24),

          // Recent Records
          _buildRecentRecords(metric),

          const SizedBox(height: 24),

          // Health Tips
          _buildHealthTips(metric),
        ],
      ),
    );
  }

  Widget _buildMetricHeader(Map<String, dynamic> metric) {
    final change = metric['change'] as double;
    final changePercent = metric['changePercent'] as double;
    final isPositive = change >= 0;

    return Container(
      padding: const EdgeInsets.all(20),
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
      child: Row(
        children: [
          // Icon
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: metric['color'].withOpacity(0.1),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Icon(
              metric['icon'],
              color: metric['color'],
              size: 30,
            ),
          ),

          const SizedBox(width: 16),

          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  metric['name'],
                  style: const TextStyle(
                    fontFamily: 'IBM Plex Sans Arabic',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                  textAlign: TextAlign.right,
                ),

                const SizedBox(height: 4),

                // Value and Change
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '${metric['value']} ${metric['unit']}',
                      style: const TextStyle(
                        fontFamily: 'IBM Plex Sans Arabic',
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: isPositive
                            ? Colors.green.withOpacity(0.1)
                            : Colors.red.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            isPositive
                                ? Icons.trending_up
                                : Icons.trending_down,
                            color: isPositive ? Colors.green : Colors.red,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${change.abs().toStringAsFixed(1)} (${changePercent.abs().toStringAsFixed(1)}%)',
                            style: TextStyle(
                              fontFamily: 'IBM Plex Sans Arabic',
                              fontSize: 12,
                              color: isPositive ? Colors.green : Colors.red,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChartPlaceholder(Map<String, dynamic> metric) {
    return Container(
      height: 200,
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
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.show_chart,
              size: 48,
              color: metric['color'].withOpacity(0.5),
            ),
            const SizedBox(height: 8),
            Text(
              'رسم بياني لل${metric['name']}',
              style: const TextStyle(
                fontFamily: 'IBM Plex Sans Arabic',
                fontSize: 16,
                color: AppColors.homeSecondaryText,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'سيتم عرض الرسم البياني هنا',
              style: TextStyle(
                fontFamily: 'IBM Plex Sans Arabic',
                fontSize: 12,
                color: AppColors.homeSecondaryText.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatistics(Map<String, dynamic> metric) {
    return Container(
      padding: const EdgeInsets.all(20),
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
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Text(
            'الإحصائيات',
            style: TextStyle(
              fontFamily: 'IBM Plex Sans Arabic',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
            textAlign: TextAlign.right,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildStatItem('المتوسط', '74.2 كجم', Icons.analytics),
              _buildStatItem('الأعلى', '75.5 كجم', Icons.arrow_upward),
              _buildStatItem('الأدنى', '72.0 كجم', Icons.arrow_downward),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.onboardingBackground,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: AppColors.primary,
              size: 20,
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                fontFamily: 'IBM Plex Sans Arabic',
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: const TextStyle(
                fontFamily: 'IBM Plex Sans Arabic',
                fontSize: 10,
                color: AppColors.homeSecondaryText,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentRecords(Map<String, dynamic> metric) {
    return Container(
      padding: const EdgeInsets.all(20),
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
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  // Navigate to full history
                },
                child: const Text(
                  'عرض الكل',
                  style: TextStyle(
                    fontFamily: 'IBM Plex Sans Arabic',
                    fontSize: 14,
                    color: AppColors.primary,
                  ),
                ),
              ),
              const Text(
                'السجلات الأخيرة',
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

          // Mock recent records
          _buildRecordItem(
              'اليوم', '${metric['value']} ${metric['unit']}', 'منذ ساعتين'),
          _buildRecordItem('أمس', '74.8 كجم', 'أمس'),
          _buildRecordItem('الأسبوع الماضي', '75.1 كجم', 'منذ 6 أيام'),
        ],
      ),
    );
  }

  Widget _buildRecordItem(String date, String value, String time) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.onboardingBackground,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            time,
            style: const TextStyle(
              fontFamily: 'IBM Plex Sans Arabic',
              fontSize: 12,
              color: AppColors.homeSecondaryText,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontFamily: 'IBM Plex Sans Arabic',
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
          Text(
            date,
            style: const TextStyle(
              fontFamily: 'IBM Plex Sans Arabic',
              fontSize: 14,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHealthTips(Map<String, dynamic> metric) {
    return Container(
      padding: const EdgeInsets.all(20),
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
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Text(
            'نصائح صحية',
            style: TextStyle(
              fontFamily: 'IBM Plex Sans Arabic',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
            textAlign: TextAlign.right,
          ),
          const SizedBox(height: 16),
          _buildTipItem(
            'حافظ على نظام غذائي متوازن',
            'تناول مجموعة متنوعة من الفواكه والخضروات والحبوب الكاملة',
          ),
          _buildTipItem(
            'مارس الرياضة بانتظام',
            'حاول المشي 30 دقيقة يومياً على الأقل',
          ),
          _buildTipItem(
            'تابع قياساتك الصحية',
            'سجل قياساتك بانتظام لمراقبة تحسن صحتك',
          ),
        ],
      ),
    );
  }

  Widget _buildTipItem(String title, String description) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.onboardingBackground,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.green.withOpacity(0.2),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.lightbulb,
              color: Colors.green,
              size: 16,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'IBM Plex Sans Arabic',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                  textAlign: TextAlign.right,
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    fontFamily: 'IBM Plex Sans Arabic',
                    fontSize: 12,
                    color: AppColors.homeSecondaryText,
                    height: 1.4,
                  ),
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showAddMetricDialog() {
    // TODO: Implement add metric dialog
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('إضافة مقياس صحي جديد')),
    );
  }

  void _showQuickAddDialog() {
    // TODO: Implement quick add dialog
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('إضافة قياس سريع')),
    );
  }
}
