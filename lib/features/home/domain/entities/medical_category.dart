import 'package:equatable/equatable.dart';

class MedicalCategory extends Equatable {
  final String id;
  final String name;
  final String arabicName;
  final String iconUrl;
  final String description;
  final int doctorCount;
  final bool isActive;

  const MedicalCategory({
    required this.id,
    required this.name,
    required this.arabicName,
    required this.iconUrl,
    required this.description,
    required this.doctorCount,
    this.isActive = true,
  });

  // Sample categories for testing
  factory MedicalCategory.sample() {
    return const MedicalCategory(
      id: '1',
      name: 'cardiology',
      arabicName: 'أمراض القلب',
      iconUrl: 'assets/icons/heart.png',
      description: 'تشخيص وعلاج أمراض القلب والأوعية الدموية',
      doctorCount: 25,
      isActive: true,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        arabicName,
        iconUrl,
        description,
        doctorCount,
        isActive,
      ];
}
