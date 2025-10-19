import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/health_tip.dart';
import '../entities/medical_category.dart';
import '../entities/quick_action.dart';

abstract class HomeRepository {
  /// Get all medical categories
  Future<Either<Failure, List<MedicalCategory>>> getMedicalCategories();

  /// Get featured doctors (top rated, nearby, etc.)
  Future<Either<Failure, List<dynamic>>> getFeaturedDoctors();

  /// Get health tips
  Future<Either<Failure, List<HealthTip>>> getHealthTips({
    int limit = 10,
    int offset = 0,
  });

  /// Get quick actions
  Future<Either<Failure, List<QuickAction>>> getQuickActions();

  /// Search health tips
  Future<Either<Failure, List<HealthTip>>> searchHealthTips(String query);

  /// Bookmark/unbookmark health tip
  Future<Either<Failure, void>> toggleHealthTipBookmark(String tipId);

  /// Get bookmarked health tips
  Future<Either<Failure, List<HealthTip>>> getBookmarkedHealthTips();

  /// Get user dashboard stats
  Future<Either<Failure, Map<String, dynamic>>> getDashboardStats();

  /// Get personalized recommendations
  Future<Either<Failure, List<dynamic>>> getPersonalizedRecommendations();
}
