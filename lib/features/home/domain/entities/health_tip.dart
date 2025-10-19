import 'package:equatable/equatable.dart';

class HealthTip extends Equatable {
  final String id;
  final String title;
  final String arabicTitle;
  final String content;
  final String arabicContent;
  final String imageUrl;
  final String category;
  final String arabicCategory;
  final DateTime publishedAt;
  final int readTimeMinutes;
  final bool isBookmarked;
  final List<String> tags;

  const HealthTip({
    required this.id,
    required this.title,
    required this.arabicTitle,
    required this.content,
    required this.arabicContent,
    required this.imageUrl,
    required this.category,
    required this.arabicCategory,
    required this.publishedAt,
    required this.readTimeMinutes,
    this.isBookmarked = false,
    required this.tags,
  });

  // Sample health tip for testing
  factory HealthTip.sample() {
    return HealthTip(
      id: '1',
      title: 'Daily Exercise Benefits',
      arabicTitle: 'فوائد التمارين اليومية',
      content: 'Regular exercise provides numerous health benefits...',
      arabicContent: 'التمارين المنتظمة توفر العديد من الفوائد الصحية...',
      imageUrl: 'assets/images/tips/exercise.jpg',
      category: 'fitness',
      arabicCategory: 'اللياقة البدنية',
      publishedAt: DateTime.now().subtract(const Duration(days: 1)),
      readTimeMinutes: 3,
      isBookmarked: false,
      tags: const ['exercise', 'health', 'fitness'],
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        arabicTitle,
        content,
        arabicContent,
        imageUrl,
        category,
        arabicCategory,
        publishedAt,
        readTimeMinutes,
        isBookmarked,
        tags,
      ];
}
