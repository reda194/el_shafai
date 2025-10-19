import 'package:equatable/equatable.dart';

/// Health record entity representing a medical document or record
class HealthRecordEntity extends Equatable {
  final String id;
  final String userId;
  final String title;
  final String description;
  final HealthRecordType type;
  final String fileUrl;
  final String fileName;
  final String fileType;
  final int fileSize; // in bytes
  final DateTime uploadedAt;
  final DateTime? recordedAt; // when the medical event occurred
  final String? doctorName;
  final String? hospitalName;
  final List<String>? tags;
  final bool isFavorite;
  final HealthRecordStatus status;

  const HealthRecordEntity({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.type,
    required this.fileUrl,
    required this.fileName,
    required this.fileType,
    required this.fileSize,
    required this.uploadedAt,
    this.recordedAt,
    this.doctorName,
    this.hospitalName,
    this.tags,
    this.isFavorite = false,
    this.status = HealthRecordStatus.active,
  });

  /// Create a copy of this entity with modified fields
  HealthRecordEntity copyWith({
    String? id,
    String? userId,
    String? title,
    String? description,
    HealthRecordType? type,
    String? fileUrl,
    String? fileName,
    String? fileType,
    int? fileSize,
    DateTime? uploadedAt,
    DateTime? recordedAt,
    String? doctorName,
    String? hospitalName,
    List<String>? tags,
    bool? isFavorite,
    HealthRecordStatus? status,
  }) {
    return HealthRecordEntity(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      description: description ?? this.description,
      type: type ?? this.type,
      fileUrl: fileUrl ?? this.fileUrl,
      fileName: fileName ?? this.fileName,
      fileType: fileType ?? this.fileType,
      fileSize: fileSize ?? this.fileSize,
      uploadedAt: uploadedAt ?? this.uploadedAt,
      recordedAt: recordedAt ?? this.recordedAt,
      doctorName: doctorName ?? this.doctorName,
      hospitalName: hospitalName ?? this.hospitalName,
      tags: tags ?? this.tags,
      isFavorite: isFavorite ?? this.isFavorite,
      status: status ?? this.status,
    );
  }

  /// Check if file is an image
  bool get isImage {
    return fileType.startsWith('image/');
  }

  /// Check if file is a PDF
  bool get isPdf {
    return fileType == 'application/pdf';
  }

  /// Get formatted file size
  String get formattedFileSize {
    const int kb = 1024;
    const int mb = kb * 1024;
    const int gb = mb * 1024;

    if (fileSize >= gb) {
      return '${(fileSize / gb).toStringAsFixed(1)} GB';
    } else if (fileSize >= mb) {
      return '${(fileSize / mb).toStringAsFixed(1)} MB';
    } else if (fileSize >= kb) {
      return '${(fileSize / kb).toStringAsFixed(1)} KB';
    } else {
      return '$fileSize B';
    }
  }

  /// Get file extension
  String get fileExtension {
    return fileName.split('.').last.toUpperCase();
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        title,
        description,
        type,
        fileUrl,
        fileName,
        fileType,
        fileSize,
        uploadedAt,
        recordedAt,
        doctorName,
        hospitalName,
        tags,
        isFavorite,
        status,
      ];
}

/// Types of health records
enum HealthRecordType {
  prescription,
  labResult,
  imaging, // X-ray, MRI, CT scan, etc.
  medicalReport,
  vaccination,
  allergy,
  surgery,
  dischargeSummary,
  insurance,
  other,
}

/// Status of health record
enum HealthRecordStatus {
  active,
  archived,
  deleted,
}

/// Extension methods for enums
extension HealthRecordTypeExtension on HealthRecordType {
  String get displayName {
    switch (this) {
      case HealthRecordType.prescription:
        return 'Prescription';
      case HealthRecordType.labResult:
        return 'Lab Result';
      case HealthRecordType.imaging:
        return 'Medical Imaging';
      case HealthRecordType.medicalReport:
        return 'Medical Report';
      case HealthRecordType.vaccination:
        return 'Vaccination';
      case HealthRecordType.allergy:
        return 'Allergy Record';
      case HealthRecordType.surgery:
        return 'Surgery Record';
      case HealthRecordType.dischargeSummary:
        return 'Discharge Summary';
      case HealthRecordType.insurance:
        return 'Insurance Document';
      case HealthRecordType.other:
        return 'Other';
    }
  }

  String get iconName {
    switch (this) {
      case HealthRecordType.prescription:
        return 'receipt';
      case HealthRecordType.labResult:
        return 'science';
      case HealthRecordType.imaging:
        return 'image';
      case HealthRecordType.medicalReport:
        return 'description';
      case HealthRecordType.vaccination:
        return 'vaccines';
      case HealthRecordType.allergy:
        return 'warning';
      case HealthRecordType.surgery:
        return 'healing';
      case HealthRecordType.dischargeSummary:
        return 'logout';
      case HealthRecordType.insurance:
        return 'security';
      case HealthRecordType.other:
        return 'folder';
    }
  }
}

extension HealthRecordStatusExtension on HealthRecordStatus {
  String get displayName {
    switch (this) {
      case HealthRecordStatus.active:
        return 'Active';
      case HealthRecordStatus.archived:
        return 'Archived';
      case HealthRecordStatus.deleted:
        return 'Deleted';
    }
  }

  bool get isActive => this == HealthRecordStatus.active;
  bool get isArchived => this == HealthRecordStatus.archived;
  bool get isDeleted => this == HealthRecordStatus.deleted;
}
