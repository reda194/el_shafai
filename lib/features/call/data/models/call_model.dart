import 'package:neurocare_app/features/call/domain/entities/call_entity.dart';

class CallModel extends CallEntity {
  const CallModel({
    required super.id,
    required super.callerId,
    required super.receiverId,
    required super.callType,
    required super.status,
    required super.startedAt,
    super.endedAt,
    super.duration,
  });

  factory CallModel.fromJson(Map<String, dynamic> json) {
    return CallModel(
      id: json['id'] as String,
      callerId: json['caller_id'] as String,
      receiverId: json['receiver_id'] as String,
      callType: CallType.values.firstWhere(
        (type) => type.toString() == json['call_type'],
      ),
      status: CallStatus.values.firstWhere(
        (status) => status.toString() == json['status'],
      ),
      startedAt: DateTime.parse(json['started_at'] as String),
      endedAt: json['ended_at'] != null
          ? DateTime.parse(json['ended_at'] as String)
          : null,
      duration: json['duration'] != null
          ? Duration(seconds: json['duration'] as int)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'caller_id': callerId,
      'receiver_id': receiverId,
      'call_type': callType.toString(),
      'status': status.toString(),
      'started_at': startedAt.toIso8601String(),
      'ended_at': endedAt?.toIso8601String(),
      'duration': duration?.inSeconds,
    };
  }

  factory CallModel.fromEntity(CallEntity entity) {
    return CallModel(
      id: entity.id,
      callerId: entity.callerId,
      receiverId: entity.receiverId,
      callType: entity.callType,
      status: entity.status,
      startedAt: entity.startedAt,
      endedAt: entity.endedAt,
      duration: entity.duration,
    );
  }
}
