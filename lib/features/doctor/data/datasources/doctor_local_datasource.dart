import 'package:shared_preferences/shared_preferences.dart';
import '../models/doctor_model.dart';

abstract class DoctorLocalDataSource {
  /// Get favorite doctors IDs
  Future<List<String>> getFavoriteDoctorIds();

  /// Add doctor to favorites
  Future<void> addToFavorites(String doctorId);

  /// Remove doctor from favorites
  Future<void> removeFromFavorites(String doctorId);

  /// Check if doctor is favorite
  Future<bool> isDoctorFavorite(String doctorId);

  /// Clear all favorites
  Future<void> clearFavorites();

  /// Cache doctors list
  Future<void> cacheDoctors(List<DoctorModel> doctors);

  /// Get cached doctors
  Future<List<DoctorModel>?> getCachedDoctors();

  /// Cache doctor details
  Future<void> cacheDoctorDetails(DoctorModel doctor);

  /// Get cached doctor details
  Future<DoctorModel?> getCachedDoctorDetails(String doctorId);

  /// Clear cache
  Future<void> clearCache();
}

class DoctorLocalDataSourceImpl implements DoctorLocalDataSource {
  final SharedPreferences sharedPreferences;
  static const String _favoritesKey = 'favorite_doctors';
  static const String _doctorsCacheKey = 'doctors_cache';
  static const String _doctorDetailsPrefix = 'doctor_details_';

  DoctorLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<String>> getFavoriteDoctorIds() async {
    final favoritesString = sharedPreferences.getString(_favoritesKey);
    if (favoritesString != null) {
      return List<String>.from(favoritesString.split(','));
    }
    return [];
  }

  @override
  Future<void> addToFavorites(String doctorId) async {
    final favorites = await getFavoriteDoctorIds();
    if (!favorites.contains(doctorId)) {
      favorites.add(doctorId);
      await sharedPreferences.setString(_favoritesKey, favorites.join(','));
    }
  }

  @override
  Future<void> removeFromFavorites(String doctorId) async {
    final favorites = await getFavoriteDoctorIds();
    favorites.remove(doctorId);
    await sharedPreferences.setString(_favoritesKey, favorites.join(','));
  }

  @override
  Future<bool> isDoctorFavorite(String doctorId) async {
    final favorites = await getFavoriteDoctorIds();
    return favorites.contains(doctorId);
  }

  @override
  Future<void> clearFavorites() async {
    await sharedPreferences.remove(_favoritesKey);
  }

  @override
  Future<void> cacheDoctors(List<DoctorModel> doctors) async {
    final doctorsJson = doctors.map((doctor) => doctor.toJson()).toList();
    await sharedPreferences.setString(_doctorsCacheKey, doctorsJson.toString());
  }

  @override
  Future<List<DoctorModel>?> getCachedDoctors() async {
    final doctorsString = sharedPreferences.getString(_doctorsCacheKey);
    if (doctorsString != null) {
      // Note: In a real app, you'd use json.decode here
      // For now, returning null as we can't parse string directly to List<DoctorModel>
      return null;
    }
    return null;
  }

  @override
  Future<void> cacheDoctorDetails(DoctorModel doctor) async {
    final doctorJson = doctor.toJson();
    await sharedPreferences.setString(
      '$_doctorDetailsPrefix${doctor.id}',
      doctorJson.toString(),
    );
  }

  @override
  Future<DoctorModel?> getCachedDoctorDetails(String doctorId) async {
    final doctorString =
        sharedPreferences.getString('$_doctorDetailsPrefix$doctorId');
    if (doctorString != null) {
      // Note: In a real app, you'd use json.decode here
      return null;
    }
    return null;
  }

  @override
  Future<void> clearCache() async {
    final keys = sharedPreferences.getKeys();
    for (final key in keys) {
      if (key.startsWith(_doctorDetailsPrefix) || key == _doctorsCacheKey) {
        await sharedPreferences.remove(key);
      }
    }
  }
}
