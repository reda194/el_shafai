import 'package:equatable/equatable.dart';

enum CallType { video, audio }

enum CallStatus { connecting, connected, ended, missed }

class CallEntity extends Equatable {
  final String id;
  final String callerId;
  final String receiverId;
  final CallType callType;
  final CallStatus status;
  final DateTime startedAt;
  final DateTime? endedAt;
  final Duration? duration;

  const CallEntity({
    required this.id,
    required this.callerId,
    required this.receiverId,
    required this.callType,
    required this.status,
    required this.startedAt,
    this.endedAt,
    this.duration,
  });

  CallEntity copyWith({
    String? id,
    String? callerId,
    String? receiverId,
    CallType? callType,
    CallStatus? status,
    DateTime? startedAt,
    DateTime? endedAt,
    Duration? duration,
  }) {
    return CallEntity(
      id: id ?? this.id,
      callerId: callerId ?? this.callerId,
      receiverId: receiverId ?? this.receiverId,
      callType: callType ?? this.callType,
      status: status ?? this.status,
      startedAt: startedAt ?? this.startedAt,
      endedAt: endedAt ?? this.endedAt,
      duration: duration ?? this.duration,
    );
  }

  @override
  List<Object?> get props => [
        id,
        callerId,
        receiverId,
        callType,
        status,
        startedAt,
        endedAt,
        duration,
      ];
}
