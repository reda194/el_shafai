import 'package:equatable/equatable.dart';

class Doctor extends Equatable {
  final String id;
  final String name;
  final String specialty;
  final String imageUrl;
  final double rating;
  final int reviewCount;
  final int experienceYears;
  final int patientCount;
  final String bio;
  final String location;
  final double price;
  final String priceUnit;
  final String priceDescription;
  final List<String> specializations;
  final List<String> languages;
  final Map<String, List<String>> availability;

  const Doctor({
    required this.id,
    required this.name,
    required this.specialty,
    required this.imageUrl,
    required this.rating,
    required this.reviewCount,
    required this.experienceYears,
    required this.patientCount,
    required this.bio,
    required this.location,
    required this.price,
    required this.priceUnit,
    required this.priceDescription,
    required this.specializations,
    required this.languages,
    required this.availability,
  });

  // Sample doctor data for testing
  factory Doctor.sample() {
    return const Doctor(
      id: '1',
      name: 'د. هيربارت',
      specialty: 'أخصائي قلب',
      imageUrl: 'assets/images/doctors/doctor_herbart.png',
      rating: 4.9,
      reviewCount: 120,
      experienceYears: 15,
      patientCount: 500,
      bio:
          'طبيب متخصص في أمراض القلب والأوعية الدموية مع خبرة تزيد عن 15 عامًا في تشخيص وعلاج أمراض القلب المختلفة.',
      location: 'ستانفورد، 300 باستور درايف',
      price: 100.00,
      priceUnit: 'ريال',
      priceDescription: 'لكل جلسة',
      specializations: ['أمراض القلب', 'الأوعية الدموية', 'الضغط الدموي'],
      languages: ['العربية', 'الإنجليزية'],
      availability: {
        'السبت': ['10:00', '14:00', '16:00'],
        'الأحد': ['09:00', '11:00', '15:00'],
        'الاثنين': ['08:00', '13:00', '17:00'],
      },
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        specialty,
        imageUrl,
        rating,
        reviewCount,
        experienceYears,
        patientCount,
        bio,
        location,
        price,
        priceUnit,
        priceDescription,
        specializations,
        languages,
        availability,
      ];
}
