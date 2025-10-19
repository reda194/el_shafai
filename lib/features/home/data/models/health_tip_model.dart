import '../../domain/entities/health_tip.dart';

class HealthTipModel extends HealthTip {
  const HealthTipModel({
    required super.id,
    required super.title,
    required super.arabicTitle,
    required super.content,
    required super.arabicContent,
    required super.imageUrl,
    required super.category,
    required super.arabicCategory,
    required super.publishedAt,
    required super.readTimeMinutes,
    super.isBookmarked = false,
    required super.tags,
  });

  factory HealthTipModel.fromJson(Map<String, dynamic> json) {
    return HealthTipModel(
      id: json['id'] as String,
      title: json['title'] as String,
      arabicTitle: json['arabic_title'] as String,
      content: json['content'] as String,
      arabicContent: json['arabic_content'] as String,
      imageUrl: json['image_url'] as String,
      category: json['category'] as String,
      arabicCategory: json['arabic_category'] as String,
      publishedAt: DateTime.parse(json['published_at'] as String),
      readTimeMinutes: json['read_time_minutes'] as int,
      isBookmarked: json['is_bookmarked'] as bool? ?? false,
      tags: List<String>.from(json['tags'] as List),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'arabic_title': arabicTitle,
      'content': content,
      'arabic_content': arabicContent,
      'image_url': imageUrl,
      'category': category,
      'arabic_category': arabicCategory,
      'published_at': publishedAt.toIso8601String(),
      'read_time_minutes': readTimeMinutes,
      'is_bookmarked': isBookmarked,
      'tags': tags,
    };
  }

  factory HealthTipModel.fromEntity(HealthTip entity) {
    return HealthTipModel(
      id: entity.id,
      title: entity.title,
      arabicTitle: entity.arabicTitle,
      content: entity.content,
      arabicContent: entity.arabicContent,
      imageUrl: entity.imageUrl,
      category: entity.category,
      arabicCategory: entity.arabicCategory,
      publishedAt: entity.publishedAt,
      readTimeMinutes: entity.readTimeMinutes,
      isBookmarked: entity.isBookmarked,
      tags: entity.tags,
    );
  }
}
