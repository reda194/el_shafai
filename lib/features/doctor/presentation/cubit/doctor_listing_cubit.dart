import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:neurocare_app/features/doctor/domain/entities/doctor.dart';

part 'doctor_listing_state.dart';

class DoctorListingCubit extends Cubit<DoctorListingState> {
  DoctorListingCubit() : super(const DoctorListingInitial());

  List<Doctor> _allDoctors = [];
  List<Doctor> _filteredDoctors = [];

  void loadDoctors() {
    emit(const DoctorListingLoading());

    // Simulate API call
    Future.delayed(const Duration(seconds: 1), () {
      _allDoctors = [
        Doctor.sample(),
        const Doctor(
          id: '2',
          name: 'د. سارة أحمد',
          specialty: 'أخصائي أعصاب',
          imageUrl: 'assets/images/doctors/doctor_sara.png',
          rating: 4.7,
          reviewCount: 95,
          experienceYears: 12,
          patientCount: 400,
          bio:
              'أخصائية أعصاب متخصصة في علاج الصداع النصفي والصرع والأمراض العصبية المختلفة.',
          location: 'الرياض، حي العليا',
          price: 120.00,
          priceUnit: 'ريال',
          priceDescription: 'لكل جلسة',
          specializations: ['الأعصاب', 'الصداع النصفي', 'الصرع'],
          languages: ['العربية', 'الإنجليزية'],
          availability: {
            'السبت': ['11:00', '15:00'],
            'الأحد': ['10:00', '14:00'],
            'الاثنين': ['09:00', '16:00'],
          },
        ),
        const Doctor(
          id: '3',
          name: 'د. محمد علي',
          specialty: 'أخصائي أسنان',
          imageUrl: 'assets/images/doctors/doctor_mohamed.png',
          rating: 4.8,
          reviewCount: 150,
          experienceYears: 18,
          patientCount: 800,
          bio: 'أخصائي أسنان معتمد مع خبرة واسعة في جميع مجالات طب الأسنان.',
          location: 'جدة، حي الصفا',
          price: 80.00,
          priceUnit: 'ريال',
          priceDescription: 'لكل جلسة',
          specializations: ['طب الأسنان', 'زراعة الأسنان', 'تقويم الأسنان'],
          languages: ['العربية', 'الإنجليزية', 'الفرنسية'],
          availability: {
            'السبت': ['09:00', '13:00', '17:00'],
            'الأحد': ['10:00', '14:00'],
            'الاثنين': ['08:00', '12:00', '16:00'],
          },
        ),
        const Doctor(
          id: '4',
          name: 'د. فاطمة حسن',
          specialty: 'أخصائي نساء وتوليد',
          imageUrl: 'assets/images/doctors/doctor_fatma.png',
          rating: 4.6,
          reviewCount: 85,
          experienceYears: 14,
          patientCount: 600,
          bio:
              'أخصائية نساء وتوليد متخصصة في الرعاية قبل الولادة والولادة والرعاية بعد الولادة.',
          location: 'الدمام، حي الراكة',
          price: 110.00,
          priceUnit: 'ريال',
          priceDescription: 'لكل جلسة',
          specializations: ['النساء والتوليد', 'الحمل', 'الولادة'],
          languages: ['العربية', 'الإنجليزية'],
          availability: {
            'السبت': ['10:00', '14:00'],
            'الأحد': ['11:00', '15:00'],
            'الاثنين': ['09:00', '13:00', '17:00'],
          },
        ),
      ];

      _filteredDoctors = _allDoctors;
      emit(DoctorListingLoaded(_filteredDoctors));
    });
  }

  void searchDoctors(String query) {
    if (query.isEmpty) {
      _filteredDoctors = _allDoctors;
    } else {
      _filteredDoctors = _allDoctors.where((doctor) {
        return doctor.name.toLowerCase().contains(query.toLowerCase()) ||
            doctor.specialty.toLowerCase().contains(query.toLowerCase()) ||
            doctor.location.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }

    if (state is DoctorListingLoaded) {
      emit(DoctorListingLoaded(_filteredDoctors));
    }
  }

  void filterBySpecialty(String specialty) {
    if (specialty == 'الكل' || specialty == 'All') {
      _filteredDoctors = _allDoctors;
    } else {
      _filteredDoctors = _allDoctors.where((doctor) {
        return doctor.specialty.contains(specialty) ||
            doctor.specializations.contains(specialty);
      }).toList();
    }

    if (state is DoctorListingLoaded) {
      emit(DoctorListingLoaded(_filteredDoctors));
    }
  }

  void sortDoctors(String sortBy) {
    switch (sortBy) {
      case 'rating':
        _filteredDoctors.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case 'experience':
        _filteredDoctors
            .sort((a, b) => b.experienceYears.compareTo(a.experienceYears));
        break;
      case 'price_low':
        _filteredDoctors.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'price_high':
        _filteredDoctors.sort((a, b) => b.price.compareTo(a.price));
        break;
      default:
        // Keep current order
        break;
    }

    if (state is DoctorListingLoaded) {
      emit(DoctorListingLoaded(_filteredDoctors));
    }
  }
}
