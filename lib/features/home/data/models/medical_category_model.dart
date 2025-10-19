import '../../domain/entities/medical_category.dart';

class MedicalCategoryModel extends MedicalCategory {
  const MedicalCategoryModel({
    required super.id,
    required super.name,
    required super.arabicName,
    required super.iconUrl,
    required super.description,
    required super.doctorCount,
    super.isActive = true,
  });

  factory MedicalCategoryModel.fromJson(Map<String, dynamic> json) {
    return MedicalCategoryModel(
      id: json['id'] as String,
      name: json['name'] as String,
      arabicName: json['arabic_name'] as String,
      iconUrl: json['icon_url'] as String,
      description: json['description'] as String,
      doctorCount: json['doctor_count'] as int,
      isActive: json['is_active'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'arabic_name': arabicName,
      'icon_url': iconUrl,
      'description': description,
      'doctor_count': doctorCount,
      'is_active': isActive,
    };
  }

  factory MedicalCategoryModel.fromEntity(MedicalCategory entity) {
    return MedicalCategoryModel(
      id: entity.id,
      name: entity.name,
      arabicName: entity.arabicName,
      iconUrl: entity.iconUrl,
      description: entity.description,
      doctorCount: entity.doctorCount,
      isActive: entity.isActive,
    );
  }
}
