import 'package:neurocare_app/features/appointment/domain/entities/appointment_entity.dart';

class AppointmentModel extends AppointmentEntity {
  const AppointmentModel({
    required super.id,
    required super.patientId,
    required super.doctorId,
    required super.doctorName,
    required super.doctorSpecialty,
    required super.doctorImage,
    required super.appointmentDate,
    required super.timeSlot,
    required super.status,
    required super.type,
    super.notes,
    super.symptoms,
    super.diagnosis,
    super.prescription,
    super.price,
    super.currency,
    required super.createdAt,
    required super.updatedAt,
    super.location,
    super.isVirtual,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      id: json['id'] as String,
      patientId: json['patientId'] as String,
      doctorId: json['doctorId'] as String,
      doctorName: json['doctorName'] as String,
      doctorSpecialty: json['doctorSpecialty'] as String,
      doctorImage: json['doctorImage'] as String,
      appointmentDate: DateTime.parse(json['appointmentDate'] as String),
      timeSlot: json['timeSlot'] as String,
      status: _parseAppointmentStatus(json['status'] as String),
      type: _parseAppointmentType(json['type'] as String),
      notes: json['notes'] as String?,
      symptoms: json['symptoms'] as String?,
      diagnosis: json['diagnosis'] as String?,
      prescription: json['prescription'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      currency: json['currency'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      location: json['location'] as String?,
      isVirtual: json['isVirtual'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'patientId': patientId,
      'doctorId': doctorId,
      'doctorName': doctorName,
      'doctorSpecialty': doctorSpecialty,
      'doctorImage': doctorImage,
      'appointmentDate': appointmentDate.toIso8601String(),
      'timeSlot': timeSlot,
      'status': status.toString().split('.').last,
      'type': type.toString().split('.').last,
      'notes': notes,
      'symptoms': symptoms,
      'diagnosis': diagnosis,
      'prescription': prescription,
      'price': price,
      'currency': currency,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'location': location,
      'isVirtual': isVirtual,
    };
  }

  static AppointmentStatus _parseAppointmentStatus(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return AppointmentStatus.pending;
      case 'confirmed':
        return AppointmentStatus.confirmed;
      case 'completed':
        return AppointmentStatus.completed;
      case 'cancelled':
        return AppointmentStatus.cancelled;
      case 'rescheduled':
        return AppointmentStatus.rescheduled;
      default:
        return AppointmentStatus.pending;
    }
  }

  static AppointmentType _parseAppointmentType(String type) {
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

  // Factory for creating sample data
  factory AppointmentModel.sample() {
    return AppointmentModel(
      id: '1',
      patientId: 'patient_123',
      doctorId: 'doctor_123',
      doctorName: 'د. سارة أحمد',
      doctorSpecialty: 'أخصائي أعصاب',
      doctorImage: 'assets/images/doctors/doctor_sara.png',
      appointmentDate: DateTime.now().add(const Duration(days: 2)),
      timeSlot: '10:00 - 10:30',
      status: AppointmentStatus.confirmed,
      type: AppointmentType.consultation,
      notes: 'متابعة للعلاج السابق',
      price: 120.0,
      currency: 'ريال',
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      updatedAt: DateTime.now(),
      location: 'العيادة الرئيسية',
      isVirtual: false,
    );
  }

  factory AppointmentModel.sampleUpcoming() {
    return AppointmentModel(
      id: '2',
      patientId: 'patient_123',
      doctorId: 'doctor_456',
      doctorName: 'د. محمد علي',
      doctorSpecialty: 'أخصائي أسنان',
      doctorImage: 'assets/images/doctors/doctor_mohamed.png',
      appointmentDate: DateTime.now().add(const Duration(days: 5)),
      timeSlot: '14:00 - 14:30',
      status: AppointmentStatus.confirmed,
      type: AppointmentType.followUp,
      notes: 'فحص الأسنان الدوري',
      price: 80.0,
      currency: 'ريال',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      location: 'عيادة الأسنان',
      isVirtual: false,
    );
  }

  factory AppointmentModel.samplePast() {
    return AppointmentModel(
      id: '3',
      patientId: 'patient_123',
      doctorId: 'doctor_789',
      doctorName: 'د. فاطمة حسن',
      doctorSpecialty: 'أخصائي نساء وتوليد',
      doctorImage: 'assets/images/doctors/doctor_fatma.png',
      appointmentDate: DateTime.now().subtract(const Duration(days: 10)),
      timeSlot: '09:00 - 09:30',
      status: AppointmentStatus.completed,
      type: AppointmentType.consultation,
      notes: 'استشارة قبل الزواج',
      diagnosis: 'حمل صحي',
      prescription: 'فيتامينات ما قبل الولادة',
      price: 110.0,
      currency: 'ريال',
      createdAt: DateTime.now().subtract(const Duration(days: 15)),
      updatedAt: DateTime.now().subtract(const Duration(days: 10)),
      location: 'عيادة النساء والتوليد',
      isVirtual: false,
    );
  }
}
