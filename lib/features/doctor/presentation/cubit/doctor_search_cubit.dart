import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neurocare_app/features/doctor/domain/entities/doctor.dart';
import 'doctor_search_state.dart';

class DoctorSearchCubit extends Cubit<DoctorSearchState> {
  DoctorSearchCubit() : super(const DoctorSearchInitial());

  Future<void> searchDoctors({
    String? query,
    String? specialty,
    String? sortBy,
    bool? availableNow,
    RangeValues? priceRange,
  }) async {
    emit(const DoctorSearchLoading());

    try {
      await Future.delayed(
          const Duration(milliseconds: 500)); // Simulate API call

      // For now, return sample doctors
      final doctors = _generateSampleDoctors();
      final filteredDoctors = _filterDoctors(
        doctors,
        query: query,
        specialty: specialty,
        sortBy: sortBy,
        availableNow: availableNow,
        priceRange: priceRange,
      );

      emit(DoctorSearchSuccess(filteredDoctors));
    } catch (e) {
      emit(DoctorSearchError(e.toString()));
    }
  }

  void clearFilters() {
    emit(const DoctorSearchInitial());
  }

  List<Doctor> _generateSampleDoctors() {
    return [
      const Doctor(
        id: '1',
        name: 'د. أحمد محمد',
        specialty: 'أخصائي قلب',
        imageUrl: 'assets/images/doctors/doctor_herbart.png',
        rating: 4.9,
        reviewCount: 125,
        experienceYears: 10,
        patientCount: 500,
        bio:
            'طبيب متخصص في أمراض القلب والأوعية الدموية مع خبرة تزيد عن 10 سنوات.',
        location: 'الرياض، شارع الملك فهد',
        price: 150,
        priceUnit: 'ريال',
        priceDescription: 'لكل جلسة',
        specializations: ['أمراض القلب', 'الأوعية الدموية', 'الضغط الدموي'],
        languages: ['العربية', 'الإنجليزية'],
        availability: {
          'السبت': ['10:00', '14:00', '16:00'],
          'الأحد': ['09:00', '11:00', '15:00'],
        },
      ),
      const Doctor(
        id: '2',
        name: 'د. سارة أحمد',
        specialty: 'أخصائية نساء وتوليد',
        imageUrl: 'assets/images/doctors/doctor_herbart.png',
        rating: 4.8,
        reviewCount: 98,
        experienceYears: 8,
        patientCount: 350,
        bio:
            'طبيبة متخصصة في النساء والتوليد مع خبرة في الرعاية قبل الولادة وبعدها.',
        location: 'جدة، حي النخيل',
        price: 140,
        priceUnit: 'ريال',
        priceDescription: 'لكل جلسة',
        specializations: ['النساء والتوليد', 'الحمل', 'حديثي الولادة'],
        languages: ['العربية', 'الإنجليزية', 'الفرنسية'],
        availability: {
          'الأحد': ['08:00', '12:00', '16:00'],
          'الإثنين': ['09:00', '13:00', '17:00'],
        },
      ),
      const Doctor(
        id: '3',
        name: 'د. محمد علي',
        specialty: 'أخصائي أعصاب',
        imageUrl: 'assets/images/doctors/doctor_herbart.png',
        rating: 4.7,
        reviewCount: 87,
        experienceYears: 12,
        patientCount: 420,
        bio:
            'طبيب متخصص في جراحة المخ والأعصاب مع خبرة واسعة في علاج الأمراض العصبية.',
        location: 'الدمام، الشاطئ',
        price: 200,
        priceUnit: 'ريال',
        priceDescription: 'لكل جلسة',
        specializations: [
          'جراحة المخ والأعصاب',
          'الأمراض العصبية',
          'الصداع النصفي'
        ],
        languages: ['العربية', 'الإنجليزية'],
        availability: {
          'الثلاثاء': ['10:00', '14:00', '18:00'],
          'الأربعاء': ['09:00', '13:00', '17:00'],
        },
      ),
      const Doctor(
        id: '4',
        name: 'د. فاطمة حسن',
        specialty: 'أخصائية جلدية',
        imageUrl: 'assets/images/doctors/doctor_herbart.png',
        rating: 4.9,
        reviewCount: 156,
        experienceYears: 7,
        patientCount: 600,
        bio:
            'طبيبة متخصصة في الأمراض الجلدية والتجميل مع استخدام أحدث التقنيات.',
        location: 'مكة المكرمة، العزيزية',
        price: 120,
        priceUnit: 'ريال',
        priceDescription: 'لكل جلسة',
        specializations: [
          'الأمراض الجلدية',
          'الجراحة التجميلية',
          'تجميل البشرة'
        ],
        languages: ['العربية', 'الإنجليزية'],
        availability: {
          'الخميس': ['10:00', '14:00', '16:00'],
          'الجمعة': ['09:00', '11:00', '15:00'],
        },
      ),
      const Doctor(
        id: '5',
        name: 'د. عمر خالد',
        specialty: 'أخصائي أطفال',
        imageUrl: 'assets/images/doctors/doctor_herbart.png',
        rating: 4.8,
        reviewCount: 112,
        experienceYears: 9,
        patientCount: 480,
        bio:
            'طبيب متخصص في طب الأطفال مع خبرة في علاج الأمراض الشائعة لدى الأطفال.',
        location: 'الطائف، حي الروضة',
        price: 100,
        priceUnit: 'ريال',
        priceDescription: 'لكل جلسة',
        specializations: ['طب الأطفال', 'التطعيمات', 'أمراض الطفولة'],
        languages: ['العربية', 'الإنجليزية'],
        availability: {
          'السبت': ['08:00', '12:00', '16:00'],
          'الإثنين': ['09:00', '13:00', '17:00'],
        },
      ),
    ];
  }

  List<Doctor> _filterDoctors(
    List<Doctor> doctors, {
    String? query,
    String? specialty,
    String? sortBy,
    bool? availableNow,
    RangeValues? priceRange,
  }) {
    var filteredDoctors = List<Doctor>.from(doctors);

    // Filter by query
    if (query != null && query.isNotEmpty) {
      filteredDoctors = filteredDoctors.where((doctor) {
        return doctor.name.toLowerCase().contains(query.toLowerCase()) ||
            doctor.specialty.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }

    // Filter by specialty
    if (specialty != null && specialty != 'الكل') {
      filteredDoctors = filteredDoctors.where((doctor) {
        return doctor.specialty.contains(specialty) ||
            doctor.specializations.any((spec) => spec.contains(specialty));
      }).toList();
    }

    // Filter by availability
    if (availableNow == true) {
      // For demo purposes, assume doctors are available if they have any availability
      filteredDoctors = filteredDoctors.where((doctor) {
        return doctor.availability.isNotEmpty;
      }).toList();
    }

    // Filter by price range
    if (priceRange != null) {
      filteredDoctors = filteredDoctors.where((doctor) {
        return doctor.price >= priceRange.start &&
            doctor.price <= priceRange.end;
      }).toList();
    }

    // Sort results
    switch (sortBy) {
      case 'التقييم':
        filteredDoctors.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case 'الخبرة':
        filteredDoctors
            .sort((a, b) => b.experienceYears.compareTo(a.experienceYears));
        break;
      case 'السعر':
        filteredDoctors.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'المسافة':
        // For demo purposes, sort by name (would normally sort by actual distance)
        filteredDoctors.sort((a, b) => a.name.compareTo(b.name));
        break;
      default:
        filteredDoctors.sort((a, b) => b.rating.compareTo(a.rating));
    }

    return filteredDoctors;
  }
}
