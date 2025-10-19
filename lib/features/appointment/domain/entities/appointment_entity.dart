import 'package:equatable/equatable.dart';

enum AppointmentStatus { pending, confirmed, completed, cancelled, rescheduled }

enum AppointmentType { consultation, followUp, emergency, telemedicine }

class AppointmentEntity extends Equatable {
  final String id;
  final String patientId;
  final String doctorId;
  final String doctorName;
  final String doctorSpecialty;
  final String doctorImage;
  final DateTime appointmentDate;
  final String timeSlot;
  final AppointmentStatus status;
  final AppointmentType type;
  final String? notes;
  final String? symptoms;
  final String? diagnosis;
  final String? prescription;
  final double? price;
  final String? currency;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? location;
  final bool isVirtual;

  const AppointmentEntity({
    required this.id,
    required this.patientId,
    required this.doctorId,
    required this.doctorName,
    required this.doctorSpecialty,
    required this.doctorImage,
    required this.appointmentDate,
    required this.timeSlot,
    required this.status,
    required this.type,
    this.notes,
    this.symptoms,
    this.diagnosis,
    this.prescription,
    this.price,
    this.currency,
    required this.createdAt,
    required this.updatedAt,
    this.location,
    this.isVirtual = false,
  });

  AppointmentEntity copyWith({
    String? id,
    String? patientId,
    String? doctorId,
    String? doctorName,
    String? doctorSpecialty,
    String? doctorImage,
    DateTime? appointmentDate,
    String? timeSlot,
    AppointmentStatus? status,
    AppointmentType? type,
    String? notes,
    String? symptoms,
    String? diagnosis,
    String? prescription,
    double? price,
    String? currency,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? location,
    bool? isVirtual,
  }) {
    return AppointmentEntity(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      doctorId: doctorId ?? this.doctorId,
      doctorName: doctorName ?? this.doctorName,
      doctorSpecialty: doctorSpecialty ?? this.doctorSpecialty,
      doctorImage: doctorImage ?? this.doctorImage,
      appointmentDate: appointmentDate ?? this.appointmentDate,
      timeSlot: timeSlot ?? this.timeSlot,
      status: status ?? this.status,
      type: type ?? this.type,
      notes: notes ?? this.notes,
      symptoms: symptoms ?? this.symptoms,
      diagnosis: diagnosis ?? this.diagnosis,
      prescription: prescription ?? this.prescription,
      price: price ?? this.price,
      currency: currency ?? this.currency,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      location: location ?? this.location,
      isVirtual: isVirtual ?? this.isVirtual,
    );
  }

  bool get isUpcoming => appointmentDate.isAfter(DateTime.now());
  bool get isToday =>
      appointmentDate.year == DateTime.now().year &&
      appointmentDate.month == DateTime.now().month &&
      appointmentDate.day == DateTime.now().day;

  @override
  List<Object?> get props => [
        id,
        patientId,
        doctorId,
        doctorName,
        doctorSpecialty,
        doctorImage,
        appointmentDate,
        timeSlot,
        status,
        type,
        notes,
        symptoms,
        diagnosis,
        prescription,
        price,
        currency,
        createdAt,
        updatedAt,
        location,
        isVirtual,
      ];
}
