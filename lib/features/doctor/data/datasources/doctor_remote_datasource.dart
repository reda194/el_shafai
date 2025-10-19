import '../../../../core/network/api_client.dart';
import '../../domain/entities/price_range.dart';
import '../models/doctor_model.dart';

abstract class DoctorRemoteDataSource {
  /// Get all doctors with optional filtering
  Future<List<DoctorModel>> getDoctors({
    String? specialty,
    String? location,
    double? minRating,
    PriceRange? priceRange,
    String? sortBy,
  });

  /// Get doctor by ID
  Future<DoctorModel> getDoctorById(String doctorId);

  /// Search doctors by query
  Future<List<DoctorModel>> searchDoctors(String query);

  /// Get doctors by specialty
  Future<List<DoctorModel>> getDoctorsBySpecialty(String specialty);

  /// Get doctor availability for specific date
  Future<Map<String, List<String>>> getDoctorAvailability(
    String doctorId,
    DateTime date,
  );

  /// Get doctor reviews
  Future<List<Map<String, dynamic>>> getDoctorReviews(
    String doctorId, {
    int limit = 10,
    int offset = 0,
  });

  /// Submit doctor review
  Future<void> submitReview({
    required String doctorId,
    required double rating,
    required String comment,
  });
}

class DoctorRemoteDataSourceImpl implements DoctorRemoteDataSource {
  final ApiClient apiClient;

  DoctorRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<List<DoctorModel>> getDoctors({
    String? specialty,
    String? location,
    double? minRating,
    PriceRange? priceRange,
    String? sortBy,
  }) async {
    final queryParams = <String, dynamic>{};

    if (specialty != null) queryParams['specialty'] = specialty;
    if (location != null) queryParams['location'] = location;
    if (minRating != null) queryParams['min_rating'] = minRating;
    if (priceRange != null) {
      queryParams['min_price'] = priceRange.start;
      queryParams['max_price'] = priceRange.end;
    }
    if (sortBy != null) queryParams['sort_by'] = sortBy;

    final response =
        await apiClient.get('/doctors', queryParameters: queryParams);
    final List<dynamic> doctorsJson = response.data['doctors'];
    return doctorsJson.map((json) => DoctorModel.fromJson(json)).toList();
  }

  @override
  Future<DoctorModel> getDoctorById(String doctorId) async {
    final response = await apiClient.get('/doctors/$doctorId');
    return DoctorModel.fromJson(response.data);
  }

  @override
  Future<List<DoctorModel>> searchDoctors(String query) async {
    final response = await apiClient.get(
      '/doctors/search',
      queryParameters: {'q': query},
    );
    final List<dynamic> doctorsJson = response.data['doctors'];
    return doctorsJson.map((json) => DoctorModel.fromJson(json)).toList();
  }

  @override
  Future<List<DoctorModel>> getDoctorsBySpecialty(String specialty) async {
    final response = await apiClient.get(
      '/doctors/specialty/$specialty',
    );
    final List<dynamic> doctorsJson = response.data['doctors'];
    return doctorsJson.map((json) => DoctorModel.fromJson(json)).toList();
  }

  @override
  Future<Map<String, List<String>>> getDoctorAvailability(
    String doctorId,
    DateTime date,
  ) async {
    final response = await apiClient.get(
      '/doctors/$doctorId/availability',
      queryParameters: {'date': date.toIso8601String()},
    );

    return Map<String, List<String>>.from(
      response.data['availability'].map(
        (key, value) => MapEntry(key, List<String>.from(value)),
      ),
    );
  }

  @override
  Future<List<Map<String, dynamic>>> getDoctorReviews(
    String doctorId, {
    int limit = 10,
    int offset = 0,
  }) async {
    final response = await apiClient.get(
      '/doctors/$doctorId/reviews',
      queryParameters: {'limit': limit, 'offset': offset},
    );

    return List<Map<String, dynamic>>.from(response.data['reviews']);
  }

  @override
  Future<void> submitReview({
    required String doctorId,
    required double rating,
    required String comment,
  }) async {
    await apiClient.post(
      '/doctors/$doctorId/reviews',
      data: {
        'rating': rating,
        'comment': comment,
      },
    );
  }
}
