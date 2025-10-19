import 'package:dio/dio.dart';
import 'package:neurocare_app/core/errors/exceptions.dart';
import 'package:neurocare_app/features/appointment/data/models/appointment_model.dart';

import 'package:neurocare_app/features/appointment/domain/entities/appointment_entity.dart';

abstract class AppointmentRemoteDataSource {
  Future<List<AppointmentModel>> getAppointments();
  Future<List<AppointmentModel>> getUpcomingAppointments();
  Future<List<AppointmentModel>> getPastAppointments();
  Future<AppointmentModel> getAppointmentById(String appointmentId);
  Future<AppointmentModel> bookAppointment({
    required String doctorId,
    required DateTime appointmentDate,
    required String timeSlot,
    required String type,
    String? notes,
    bool? isVirtual,
  });
  Future<void> cancelAppointment(String appointmentId);
  Future<AppointmentModel> rescheduleAppointment({
    required String appointmentId,
    required DateTime newDate,
    required String newTimeSlot,
  });
  Future<AppointmentModel> updateAppointmentNotes({
    required String appointmentId,
    required String notes,
  });
  Future<List<String>> getAvailableTimeSlots({
    required String doctorId,
    required DateTime date,
  });
  Future<bool> isTimeSlotAvailable({
    required String doctorId,
    required DateTime date,
    required String timeSlot,
  });
}

class AppointmentRemoteDataSourceImpl implements AppointmentRemoteDataSource {
  final Dio dio;

  AppointmentRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<AppointmentModel>> getAppointments() async {
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      // Return sample data for now
      return [
        AppointmentModel.sample(),
        AppointmentModel.sampleUpcoming(),
        AppointmentModel.samplePast(),
      ];
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Server error occurred');
    } catch (e) {
      throw ServerException('Unexpected error occurred');
    }
  }

  @override
  Future<List<AppointmentModel>> getUpcomingAppointments() async {
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      return [
        AppointmentModel.sample(),
        AppointmentModel.sampleUpcoming(),
      ];
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Server error occurred');
    } catch (e) {
      throw ServerException('Unexpected error occurred');
    }
  }

  @override
  Future<List<AppointmentModel>> getPastAppointments() async {
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      return [
        AppointmentModel.samplePast(),
      ];
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Server error occurred');
    } catch (e) {
      throw ServerException('Unexpected error occurred');
    }
  }

  @override
  Future<AppointmentModel> getAppointmentById(String appointmentId) async {
    try {
      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 500));

      // Return sample appointment based on ID
      if (appointmentId == '1') {
        return AppointmentModel.sample();
      } else if (appointmentId == '2') {
        return AppointmentModel.sampleUpcoming();
      } else if (appointmentId == '3') {
        return AppointmentModel.samplePast();
      } else {
        throw NotFoundException('Appointment not found');
      }
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Server error occurred');
    } catch (e) {
      throw ServerException('Unexpected error occurred');
    }
  }

  @override
  Future<AppointmentModel> bookAppointment({
    required String doctorId,
    required DateTime appointmentDate,
    required String timeSlot,
    required String type,
    String? notes,
    bool? isVirtual,
  }) async {
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      // Create new appointment
      final newAppointment = AppointmentModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        patientId: 'patient_123', // Would come from auth
        doctorId: doctorId,
        doctorName: 'د. ${doctorId == 'doctor_123' ? 'سارة أحمد' : 'محمد علي'}',
        doctorSpecialty:
            doctorId == 'doctor_123' ? 'أخصائي أعصاب' : 'أخصائي أسنان',
        doctorImage:
            'assets/images/doctors/doctor_${doctorId == 'doctor_123' ? 'sara' : 'mohamed'}.png',
        appointmentDate: appointmentDate,
        timeSlot: timeSlot,
        status: AppointmentStatus.pending,
        type: _parseAppointmentType(type),
        notes: notes,
        price: doctorId == 'doctor_123' ? 120.0 : 80.0,
        currency: 'ريال',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        location: isVirtual == true ? null : 'العيادة الرئيسية',
        isVirtual: isVirtual ?? false,
      );

      return newAppointment;
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Server error occurred');
    } catch (e) {
      throw ServerException('Unexpected error occurred');
    }
  }

  @override
  Future<void> cancelAppointment(String appointmentId) async {
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      // In a real implementation, this would make an API call
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Server error occurred');
    } catch (e) {
      throw ServerException('Unexpected error occurred');
    }
  }

  @override
  Future<AppointmentModel> rescheduleAppointment({
    required String appointmentId,
    required DateTime newDate,
    required String newTimeSlot,
  }) async {
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      // Get current appointment and update it
      final currentAppointment = await getAppointmentById(appointmentId);

      return AppointmentModel(
        id: currentAppointment.id,
        patientId: currentAppointment.patientId,
        doctorId: currentAppointment.doctorId,
        doctorName: currentAppointment.doctorName,
        doctorSpecialty: currentAppointment.doctorSpecialty,
        doctorImage: currentAppointment.doctorImage,
        appointmentDate: newDate,
        timeSlot: newTimeSlot,
        status: AppointmentStatus.rescheduled,
        type: currentAppointment.type,
        notes: currentAppointment.notes,
        price: currentAppointment.price,
        currency: currentAppointment.currency,
        createdAt: currentAppointment.createdAt,
        updatedAt: DateTime.now(),
        location: currentAppointment.location,
        isVirtual: currentAppointment.isVirtual,
      );
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Server error occurred');
    } catch (e) {
      throw ServerException('Unexpected error occurred');
    }
  }

  @override
  Future<AppointmentModel> updateAppointmentNotes({
    required String appointmentId,
    required String notes,
  }) async {
    try {
      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 500));

      final currentAppointment = await getAppointmentById(appointmentId);

      return AppointmentModel(
        id: currentAppointment.id,
        patientId: currentAppointment.patientId,
        doctorId: currentAppointment.doctorId,
        doctorName: currentAppointment.doctorName,
        doctorSpecialty: currentAppointment.doctorSpecialty,
        doctorImage: currentAppointment.doctorImage,
        appointmentDate: currentAppointment.appointmentDate,
        timeSlot: currentAppointment.timeSlot,
        status: currentAppointment.status,
        type: currentAppointment.type,
        notes: notes,
        symptoms: currentAppointment.symptoms,
        diagnosis: currentAppointment.diagnosis,
        prescription: currentAppointment.prescription,
        price: currentAppointment.price,
        currency: currentAppointment.currency,
        createdAt: currentAppointment.createdAt,
        updatedAt: DateTime.now(),
        location: currentAppointment.location,
        isVirtual: currentAppointment.isVirtual,
      );
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Server error occurred');
    } catch (e) {
      throw ServerException('Unexpected error occurred');
    }
  }

  @override
  Future<List<String>> getAvailableTimeSlots({
    required String doctorId,
    required DateTime date,
  }) async {
    try {
      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 500));

      // Return sample available time slots
      return [
        '09:00 - 09:30',
        '10:00 - 10:30',
        '11:00 - 11:30',
        '14:00 - 14:30',
        '15:00 - 15:30',
        '16:00 - 16:30',
      ];
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Server error occurred');
    } catch (e) {
      throw ServerException('Unexpected error occurred');
    }
  }

  @override
  Future<bool> isTimeSlotAvailable({
    required String doctorId,
    required DateTime date,
    required String timeSlot,
  }) async {
    try {
      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 300));

      // For demo purposes, assume all slots are available except one
      return timeSlot != '11:00 - 11:30';
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Server error occurred');
    } catch (e) {
      throw ServerException('Unexpected error occurred');
    }
  }

  AppointmentType _parseAppointmentType(String type) {
    switch (type.toLowerCase()) {
      case 'consultation':
        return AppointmentType.consultation;
      case 'followup':
        return AppointmentType.followUp;
      case 'emergency':
        return AppointmentType.emergency;
      case 'telemedicine':
        return AppointmentType.telemedicine;
      default:
        return AppointmentType.consultation;
    }
  }
}
