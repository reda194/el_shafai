import '../../domain/entities/doctor.dart';

class DoctorModel extends Doctor {
  const DoctorModel({
    required super.id,
    required super.name,
    required super.specialty,
    required super.imageUrl,
    required super.rating,
    required super.reviewCount,
    required super.experienceYears,
    required super.patientCount,
    required super.bio,
    required super.location,
    required super.price,
    required super.priceUnit,
    required super.priceDescription,
    required super.specializations,
    required super.languages,
    required super.availability,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      id: json['id'] as String,
      name: json['name'] as String,
      specialty: json['specialty'] as String,
      imageUrl: json['image_url'] as String,
      rating: (json['rating'] as num).toDouble(),
      reviewCount: json['review_count'] as int,
      experienceYears: json['experience_years'] as int,
      patientCount: json['patient_count'] as int,
      bio: json['bio'] as String,
      location: json['location'] as String,
      price: (json['price'] as num).toDouble(),
      priceUnit: json['price_unit'] as String,
      priceDescription: json['price_description'] as String,
      specializations: List<String>.from(json['specializations'] as List),
      languages: List<String>.from(json['languages'] as List),
      availability: Map<String, List<String>>.from(
        json['availability'].map(
          (key, value) => MapEntry(key, List<String>.from(value)),
        ),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'specialty': specialty,
      'image_url': imageUrl,
      'rating': rating,
      'review_count': reviewCount,
      'experience_years': experienceYears,
      'patient_count': patientCount,
      'bio': bio,
      'location': location,
      'price': price,
      'price_unit': priceUnit,
      'price_description': priceDescription,
      'specializations': specializations,
      'languages': languages,
      'availability': availability,
    };
  }

  factory DoctorModel.fromEntity(Doctor entity) {
    return DoctorModel(
      id: entity.id,
      name: entity.name,
      specialty: entity.specialty,
      imageUrl: entity.imageUrl,
      rating: entity.rating,
      reviewCount: entity.reviewCount,
      experienceYears: entity.experienceYears,
      patientCount: entity.patientCount,
      bio: entity.bio,
      location: entity.location,
      price: entity.price,
      priceUnit: entity.priceUnit,
      priceDescription: entity.priceDescription,
      specializations: entity.specializations,
      languages: entity.languages,
      availability: entity.availability,
    );
  }
}
