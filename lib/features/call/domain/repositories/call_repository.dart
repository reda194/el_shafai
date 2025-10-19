import 'package:dartz/dartz.dart';
import 'package:neurocare_app/core/errors/failures.dart';
import 'package:neurocare_app/features/call/domain/entities/call_entity.dart';

abstract class CallRepository {
  /// Start a new call
  Future<Either<Failure, CallEntity>> startCall({
    required String receiverId,
    required CallType callType,
  });

  /// End an ongoing call
  Future<Either<Failure, CallEntity>> endCall(String callId);

  /// Get call history for current user
  Future<Either<Failure, List<CallEntity>>> getCallHistory();

  /// Get ongoing call if any
  Future<Either<Failure, CallEntity?>> getOngoingCall();

  /// Accept incoming call
  Future<Either<Failure, CallEntity>> acceptCall(String callId);

  /// Decline incoming call
  Future<Either<Failure, CallEntity>> declineCall(String callId);
}
